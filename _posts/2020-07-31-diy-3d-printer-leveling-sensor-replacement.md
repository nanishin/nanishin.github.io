---
#layout: posts
comments: true
title:  "DIY 3D 프린터 레벨링 센서 교체"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/20200726_201734.jpg
date:   2020-07-31 23:50:00 +0900
categories:
  - maker
tags:
  - 3D 프린터
  - 오토베드레벨링
  - 센서교체
  - 3D Printer
  - Auto Bed Labeling
  - SN04-N Sensor Replacement
  - Right to Repair
---
지난달부터 갑자기 오토베드레벨링을 수행하면 점점 Extruder가 하늘로 올라가는

증상 발생...Multi Meter로 확인해보니 원래 SN04-N 센서가 Metal 근접을 인지할

경우 5V이던 상태에서 0V로 떨어지는데 Pull-Up 상태인데도 1.35V로 나옴...

즉 로직 상 1이 아닌 0으로 인지되어 계속 올라갔던 것... :(

비교를 위해 12V 전원을 넣어도 현상이 동일해서 3D 프린터 보드 내 FET이 터진

상황인가 싶어서 좌절했는데 혹시나 해서 알리에서 SN04-N을 새로 주문...

대략 한달 뒤 도착해서 교체하니 예전처럼 베드레벨링 잘 되는 걸 확인하고 역시

부품별 교체가 가능해야 유지보수에 최고라는 걸 다시 한번 경험!!!

## 1. 기존 센서와 신규 센서 비교

기존 SN04-N은 동작 전압이 10~30V인데 신규 SN04-N은 6~36V

![Compare Old and New (SN04-N)](/assets/images/20200726_201734.jpg)

## 2. 고정판에 연결

이 부분에서 노즐 대비 적절한 센서 높이를 맞춰줘야 베드를 긁지 않게 되니

수동으로 손이 가는 부분...

![Attach New SN04-N](/assets/images/20200729_214413.jpg)

## 3. 3핀 커넥터 재사용

3핀 커넥터는 여분이 없는지라 기존 센서에서 전선 채 잘라서 서로 연결 뒤

열수축튜브로 마감해서 재사용

![Rewire 3 Pin Connector](/assets/images/20200729_214609.jpg)

## 4. Extruder 후면에 재설치

G29 명령으로 다시 오토베드레벨링 동작이 잘되는 것에서 뿌듯함을 느끼고

다시 밀려있던 메이킹 재개... ;D

![Reassemble](/assets/images/20200731_214703.jpg)

