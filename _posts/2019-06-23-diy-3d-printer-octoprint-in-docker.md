---
layout: post
comments: true
title:  "DIY 3D 프린터용 OctoPrint 환경 변경(OctoPi -> Docker)"
date:   2019-06-23 21:51:00 +0900
categories: maker
---
OctoPrint는 DIY 3D 프린터에 원격제어라는 날개를 달아준 너무나도 고마운 존재이다.

그런데 Raspbian + OctoPrint 환경이 결합된 OctoPi를 쓰면서 반복적으로 경험한 고통이 있었으니

APT 패키지 업데이트를 주기적으로 하다 보면 어느순간 파일시스템이 깨지고 커널 패닉의 지옥으로 :'(

몇번 디버깅 시도하다 귀찮아서 OctoPi를 다시 SDCARD에 플래싱하기를 반복...

그러다 결국 Docker 환경으로 가기로 결정하고 Headless Raspbian에 armhf용 docker와 docker-compose 빌드 후 적용

PiCam으로 프린팅 상황 스트리밍을 위해 mjpg-streamer에 대한 추가작업이 필요하지만 일단은

Docker Container 안에서 OctoPrint가 동작하면서 기존처럼 프린팅되는 것 확인 완료!!!

![OctoPrint in Docker](/assets/octoprint_in_docker.png)

# OctoPrint Docker Container in Raspberry Pi 3
```shell
pi@nani-octoprint:~/octoprint-docker $ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
armhf/octoprint     latest              13a85554c7cd        3 weeks ago         943MB
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

