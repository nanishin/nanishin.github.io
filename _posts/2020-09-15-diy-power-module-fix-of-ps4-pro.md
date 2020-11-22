---
#layout: posts
comments: true
title:  "PS4 Pro 죽음의 파란불 자가수리"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/20200905_000937.jpg
date:   2020-09-15 23:30:00 +0900
categories:
  - maker
tags:
  - 플스4 프로
  - PS4 Pro CUH-7117B
  - 파워모듈
  - PowerModule ADP-300ER
  - 죽음의 파란불
  - Blue Light of Death
  - DIY Fix
  - 자가수리
  - Right to Repair
---
이번 장마를 거친 뒤 시작된 플스4 프로의 죽음의 파란불 (Blue Light of Death)

내부 파워모듈이 저온상태에서 정상적인 전원 공급을 하지 못해서 전원 버튼을

누르면 파란불이 1초 정도 들어왔다가 바로 꺼지기를 반복...

이리저리 찾아본 팁을 적용해 드라이어기로 파워모듈 송풍구 부분에 1분 정도

뜨거운 바람을 불어넣으니 정상 부팅 확인....

그러나 이걸 게임할 때마다 해줘야 하다니.. :'(

결국 분해해서 파워모듈을 교체할지 아니면 수리 가능한지 확인작업 돌입!!!

## 1. 분해용 드라이버 확보

다양한 사이즈 확보를 위해 유명하다는 샤오미 드라이버 세트로 주문

![Mi x Whia Precision Screwdriver - 1](/assets/images/20200819_093043.jpg)

![Mi x Whia Precision Screwdriver - 2](/assets/images/20200915_222653.jpg)

실제로 사용되는 사이즈는 가운데 심이 있는 별나사 T8H

![TORX T8H - 1](/assets/images/20200904_232707.jpg)

![TORX T8H - 2](/assets/images/20200904_232646.jpg)

## 2. 분해는 차근차근

외관 플라스틱 케이스를 분해할 때 부술까 두려웠지만 언제나 친절한 레퍼런스인

iFixIt의 가이드대로 과감하게 뚜둑 소리나게 뜯어서 파워모듈 분리까지 완료

- [PlayStation 4 Pro Power Supply Unit Replacement](https://ko.ifixit.com/Guide/PlayStation+4+Pro+Power+Supply+Unit+Replacement/89196)

![PS4 Pro Power Disaseemble Top - 1](/assets/images/20200904_231843.jpg)

![PS4 Pro Power Disaseemble Top - 2](/assets/images/20200904_232508.jpg)

![PS4 Pro Power Disaseemble Top - 3](/assets/images/20200904_232759.jpg)

이미 무상 보증기간도 지났으니 후면 봉인씰 제거 후 나사 1개도 풀어줌

![PS4 Pro Power Disaseemble Rear](/assets/images/20200904_233229.jpg)

바닥면에서 나사 2개를 풀어야 파워모듈 분리 가능

![PS4 Pro Power Disaseemble Back - 1](/assets/images/20200905_000013.jpg)

![PS4 Pro Power Disaseemble Back - 2](/assets/images/20200905_001818.jpg)

파워모듈 분리!!!

![PS4 Pro Power Disaseemble Top - 4](/assets/images/20200905_000937.jpg)

## 3. 역시 기계는 쓸고 닦아줘야 한다

이리저리 파워모듈 내부 회로를 보다가 MOSFET 부분에 먼지 덩어리들이 붙어있는

상황 발견해서 진공청소기로 제거한 뒤 뒤늦게 찍어서 남진 않았지만 이 부분이

문제를 일으켰던 원인으로 확인됨

![Inside of Power Module](/assets/images/20200905_001221.jpg)

![MOSFET Close Up](/assets/images/20200905_001225.jpg)

## 4. 재조립 후 찾아온 평화

다시 조립하기 전 본체와의 커넥터 부분과 파워모듈 모델번호 ADP-300ER까지

확인 뒤 분해의 역순으로 재조립하고 문제없이 잘 부팅되는 거 확인!!! 

코로나19 집콕에 맞춰 다시금 평화롭게 폴가이즈와 위쳐3 게임 속으로... :D

![Connector of Power Module](/assets/images/20200905_004800.jpg)

![Model Number of Power Module](/assets/images/20200905_004919.jpg)
