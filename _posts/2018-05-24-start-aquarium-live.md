---
#layout: posts
comments: true
title:  "자반어항에서 아쿠아리움라이브 방송 시작"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.png
date:   2018-05-24 21:30:00 +0900
categories:
  - maker
tags:
  - 자반어항
  - 어항방송
---
한달 간 삽질 끝에 드디어 자반어항에 설치한 라즈베리파이3와 파이캠을

이용해서 아쿠아리움 라이브 방송 시작!!!

대략 경험한 이슈들만 나열하면

- AWS IoT Core에 Thing 등록 및 MQTT 동작
- AWS Lambda 구성 및 SmartThings C2C Connector 동작
- SmartThings devWS로 C2C device 생성 방법
- SmartThings PPK Plugin 생성 및 사이드로딩 방법
- Raspbian headless 이미지 사용하면서 WiFi 연결 처리
- RPI3가 2.4GHz만 지원하는데 2.4GHz Steering Band로 동작하는 SmartThings WiFi Home Hub에는
붙지를 않아 결국 거실에 있는 KT Giga WiFi Hub에 붙이는 삽질
- 어항벽에 붙여둔 기구물이 바닥에 떨어져서 1시간 가량 검은 화면이 송출되어 방송정지 먹고 해명하면서 확인한 유튜브 AI 모니터링 시스템

튜닝은 방송 에이징을 하면서 계속 하는 것으로...

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/C8eJjoeYZ6k" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

