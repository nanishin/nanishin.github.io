---
#layout: posts
comments: true
title:  "Tesla Custom Light Show 만들기 (BTS 피땀눈물 리믹스)"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/final_sequencer_of_bts_oh_nae_money.jpg
date:   2021-12-31 20:20:00 +0900
categories:
  - maker
tags:
  - Tesla Light Show
  - 테슬라 라이트쇼
  - Custom
  - 커스텀
  - Tesla
  - 테슬라
  - BTS
  - 방탄소년단
  - 피땀눈물
  - Blood Sweat and Tears
---
V10 이후 2년 만에 2021년 크리스마스 선물로 월드와이드 배포된 Tesla OS V11

- [Introducing Software V11.0](https://www.tesla.com/blog/introducing-software-v11-0)

UI 룩앤필이 전반적으로 모두 바뀐 상황이라 완전히 새로워진 차량의 경험을 매일 하고 있는 요즘 특히 메이커의 혼을 불러일으킨 가장 재밌는 기능인 라이트쇼 커스텀 지원

- [Tesla Light Show xLights Guide](https://github.com/teslamotors/light-show)

마침 2020년 크리스마스 선물이었던 주행중 붐박스에 사용하기 위해 아미인 가족들 요청으로 만들었던 BTS 피땀눈물 리믹스는 결국 국내법 제약으로 주행중 기능이 사라져서 아쉬워하던 차였는데 커스텀 라이트쇼로 재탄생시키기로 결정!!!

## 1. xLights 설치하고 Tesla 리소스 로딩하기

우선 PC OS 환경에 맞는 xLights 최신버전 설치

- [xLights Releases](https://xlights.org/releases/)

Tesla 리소스 파일을 풀어준 뒤 가이드 설명처럼 Show Folder로 지정해주면 Tesla S 외관의 3D 모델 리소스 로딩 완료

- [Tesla xLights Show Folder Zip File](https://github.com/teslamotors/light-show/blob/master/xlights/tesla_xlights_show_folder.zip?raw=true)

## 2. 음원 로딩하고 시퀀서로 열심히 박자 쪼개며 창작혼 불태우기

음원까지 로딩되면 첫단계는 New Timing 라인 선택하고 열심히 음원 들으며 T 키 눌러서 라이트쇼에 사용할 박자 쪼개는 사전 작업 진행 

이후 테슬라 차량에 있는 라이트들을 박자 상황에 맞춰 켜고 끌지를 시퀀서 내에 차례대로 인내심을 가지면서 한땀한땀 표기

첫 시도인지라 안전(?)을 위해 물리적인 장치인 트렁크/윈도우4개/좌우사이드미러/충전구덮개 제어는 일부러 빼둠...다음에 좀 더 장엄(?)한 곡으로 도전하기로...

전면 헤드라이트의 TESLA 프로젝션 문구 역시 프로젝션 지원 모델이 아닌지라 직접 확인하진 못했지만 현재는 기능 설명 상 문구 변경 미지원...

![Final Sequencer of BTS Oh Nae Money](/assets/images/final_sequencer_of_bts_oh_nae_money.jpg)

## 3. 파일 로딩하고 지하주차장에서 쇼타임!

테슬라 차량에 실제 적용 전 lightshow.fseq와 lightshow.wav로 이름 맞춘 뒤 로딩 과정에 문제 없을지 파일 무결성 체크!!!

```shell
$ ls -al
total 8152
drwxr-xr-x 2 nani nani    4096 Dec 31 19:34 .
drwxr-xr-x 3 nani nani    4096 Dec 26 23:29 ..
-rwxr-xr-x 1 nani nani  112052 Dec 26 23:32 lightshow.fseq
-rwxr-xr-x 1 nani nani 8226428 Dec 26 23:32 lightshow.wav
$ python3.9 ../../validator.py lightshow.fseq
Found 2331 frames, step time of 20 ms for a total duration of 0:00:46.620000.
Used 59.32% of the available memory
```

이제 USB 메모리에 LightShow 폴더(TeslaCam 폴더와는 다른 파티션 사용) 만들어서 복사하고 차량 내 USB 포트에 꽂고 라이트쇼 메뉴에서 로딩하면 짜잔~

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/121ZwuLArdM" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

