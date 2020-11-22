---
#layout: posts
comments: true
title:  "DIY 3D 프린터용 OctoPrint 환경 변경(OctoPi -> Docker)"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.jpg
date:   2019-06-23 21:51:00 +0900
categories:
  - maker
tags:
  - 3D 프린터
  - Octoprint
  - Docker
---
OctoPrint는 DIY 3D 프린터에 원격제어라는 날개를 달아준 너무나도 고마운 존재이다.

그런데 Raspbian + OctoPrint 환경이 결합된 OctoPi를 쓰면서 반복적으로 경험한 고통이 있었으니

APT 패키지 업데이트를 주기적으로 하다 보면 어느순간 파일시스템이 깨지고 커널 패닉의 지옥으로 :'(

몇번 디버깅 시도하다 귀찮아서 OctoPi를 다시 SDCARD에 플래싱하기를 반복...

그러다 결국 Docker 환경으로 가기로 결정하고 Headless Raspbian에 armhf용 docker와 docker-compose 빌드 후 적용

1. [Install docker in raspberry pi 3](https://blog.docker.com/2019/03/happy-pi-day-docker-raspberry-pi/)
2. [Install docker-compose in raspberry pi 3](https://www.berthon.eu/2019/revisiting-getting-docker-compose-on-raspberry-pi-arm-the-easy-way/)
3. [Build Octoprint Docker Image](https://github.com/OctoPrint/docker)

기본 생성되는 Octoprint Docker Image가 x86_64 기반이어서 아래처럼 arm으로 arch 변경 후 docker build 진행 필요
```shell
pi@nani-octoprint:~/octoprint-docker $ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Dockerfile
	modified:   docker-compose.yml

no changes added to commit (use "git add" and/or "git commit -a")
pi@nani-octoprint:~/octoprint-docker $ git diff Dockerfile
diff --git a/Dockerfile b/Dockerfile
index 9e7cd3a..b0d8e6f 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,5 +1,5 @@

-FROM python:2.7
+FROM arm32v7/python:2.7-stretch
 EXPOSE 5000
 LABEL maintainer "gaetancollaud@gmail.com"

@@ -16,7 +16,7 @@ WORKDIR /opt/octoprint

 #install ffmpeg
 RUN cd /tmp \
-  && wget -O ffmpeg.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz \
+  && wget -O ffmpeg.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-armhf-static.tar.xz \
        && mkdir -p /opt/ffmpeg \
        && tar xvf ffmpeg.tar.xz -C /opt/ffmpeg --strip-components=1 \
   && rm -Rf /tmp/*
pi@nani-octoprint:~/octoprint-docker $ git diff docker-compose.yml
diff --git a/docker-compose.yml b/docker-compose.yml
index b947b9a..f519f1d 100644
--- a/docker-compose.yml
+++ b/docker-compose.yml
@@ -2,11 +2,11 @@ version: '2'
 services:
   octoprint:
     build: .
-    image: octoprint/octoprint
+    image: armhf/octoprint
     container_name: octoprint
     ports:
       - 5000:5000
-    # devices:
-    #  - /dev/ttyACM0:/dev/ttyACM0
+    devices:
+      - /dev/ttyUSB0:/dev/ttyUSB0
     volumes:
      - ./config:/home/octoprint/.octoprint
```

PiCam으로 프린팅 상황 스트리밍을 위해 mjpg-streamer에 대한 추가작업이 필요하지만 일단은

Docker Container 안에서 OctoPrint가 동작하면서 기존처럼 프린팅되는 것 확인 완료!!!

![OctoPrint in Docker](/assets/images/octoprint_in_docker.jpg)

# OctoPrint Docker Container in Raspberry Pi 3
```shell
pi@nani-octoprint:~/octoprint-docker $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
armhf/octoprint     latest              13a85554c7cd        3 weeks ago         943MB
arm32v7/python      2.7-stretch         d9fb312034b9        5 weeks ago         737MB
pi@nani-octoprint:~/octoprint-docker $ cat docker-compose.yml
version: '2'
services:
  octoprint:
    build: .
    image: armhf/octoprint
    container_name: octoprint
    ports:
      - 5000:5000
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
    volumes:
     - ./config:/home/octoprint/.octoprint
pi@nani-octoprint:~/octoprint-docker $ docker-compose up -d
Creating network "octoprint-docker_default" with the default driver
Creating octoprint ... done
pi@nani-octoprint:~/octoprint-docker $ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
9df48e847f4a        armhf/octoprint     "/opt/octoprint/venv…"   47 seconds ago      Up 28 seconds       0.0.0.0:5000->5000/tcp   octoprint
pi@nani-octoprint:~/octoprint-docker $ netstat -apt
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 [::]:5000               [::]:*                  LISTEN      -
pi@nani-octoprint:~/octoprint-docker $ docker-compose down
Stopping octoprint ... done
Removing octoprint ... done
Removing network octoprint-docker_default
pi@nani-octoprint:~/octoprint-docker $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
pi@nani-octoprint:~/octoprint-docker $ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

