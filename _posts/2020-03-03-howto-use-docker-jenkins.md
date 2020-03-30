---
#layout: posts
comments: true
title:  "Jenkins Docker-in-Docker 환경 사용하기"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.png
date:   2020-03-03 15:30:00 +0900
categories:
  - tip
tags:
  - Jenkins
  - Docker-in-Docker
  - 젠킨스
  - 도커
---
정말 docker는 기존 한땀한땀 서비스 구성방식을 초간단하게 바꿔놨다...

Jenkins 역시 jenkins docker base를 활용하면 Job 백업/복원이 수월하면서

docker-in-docker까지 가능하기에 docker client 관련 패키지들까지 포함된

이미지 만든 뒤 docker hub에 push까지 완료!!!

## Jenkins Job에서 Docker 지원용 Dockerfile 구성

- [Reference blog of nestybox](https://blog.nestybox.com/2019/09/29/jenkins.html)

```docker
FROM jenkins/jenkins

# Docker install
USER root
RUN apt-get update && apt-get install -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins
```

## Jenkins Job 백업 및 docker-in-docker 지원 컨테이너 실행

```shell
$ mkdir ~/jenkins_home
$ docker run --rm -d --group-add $(stat -c '%g' /var/run/docker.sock) -p 8080:8080 -p 50000:50000 -v ~/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -P nanishin/jenkins-docker
```

## Docker Hub에 push한 jenkins-docker 경로

- [nanishin/jenkins-docker](https://hub.docker.com/r/nanishin/jenkins-docker)
