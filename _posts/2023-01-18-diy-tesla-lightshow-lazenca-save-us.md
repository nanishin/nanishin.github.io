---
#layout: posts
comments: true
title:  "Tesla Light Show 만들기 (N.EX.T - Lazenca Save Us)"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/tesla_lightshow_next_lazenca_save_us.jpg
date: 2023-01-18 22:30:00 +0900
categories:
  - maker
tags:
  - Tesla Light Show
  - 테슬라 라이트쇼
  - Custom
  - 커스텀
  - Tesla
  - 테슬라
  - N.EX.T
  - 넥스트
  - Lazenca Save Us
  - 라젠카 세이브 어스
---
지난 2022년 크리스마스 선물 펌웨어에서 1년 만에 라이트쇼 기능도 업데이트되면서 동작 안정성과 메뉴 구성이 개선되었기에 미루고 미루던 장엄한 곡 기반 작업 결심을 이번에 실천!

N.EX.T - Lazenca Save Us (넥스트 - 라젠카 세이브 어스)

## 1. 모든 마법은 xLights 설치와 Tesla 3D 모델 리소스 로딩으로 시작

Windows/Mac/Linux OS 환경에 맞는 xLights 최신버전을 설치해야 하는데 작업 시점 2023년 첫 릴리즈인 2023.01으로 다운로드 가능

- [xLights Releases](https://xlights.org/releases/)

1년 사이에 xLights도 많이 개선되어 전반적인 작업 환경이 안정화되었다는...

Tesla 리소스 파일을 풀어준 뒤 가이드 설명처럼 Show Folder로 지정해주면 Tesla S 외관의 3D 모델 리소스 로딩은 작년과 동일

- [Telse Light Show xLights Guide](https://github.com/teslamotors/light-show#tesla-light-show-xlights-guide)

- [Tesla xLights Show Folder Zip File](https://github.com/teslamotors/light-show/blob/master/xlights/tesla_xlights_show_folder.zip?raw=true)

## 2. 라젠카 세이브 어스 음원 로딩하고 여러 레이어로 박자 쪼개며 싱크로율 올리기

작년과 달라진 부분은 이번 테슬라 샘플 레퍼런스를 참고하니 한곡 내 여러 악기들에 맞춰 Timing 라인을 구분해서 별도로 박자를 쪼깨는 걸 확인함...

이에 맞춰 라젠카 세이버 어스의 베이스/드럼/기타/보컬 에 따라 쪼개서 진행하니 좀 더 다양한 표현이 가능해짐

그리고 창문 닫고 여는 동작은 소리가 줄어들기에 사용하지 않고 트렁크/좌우사이드미러/충전구덮개는 곡 전개 상황에 맞춰 사용!!!

헤드라이트 프로젝션 문구 조정은 이번에도 지원하지 않는다고 하는데 우리집 테슬라는 프로젝션 지원 모델이 아닌지라 이부분은 그대로 스킵...

시퀀스와 차량 전후 라이트 싱크 맛보기 1분 영상은 Instagram에도 남겨둠~ :)

<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/p/CnhqzZLPEA6/?utm_source=ig_embed&amp;utm_campaign=loading" data-instgrm-version="14" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:540px; min-width:326px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:16px;"> <a href="https://www.instagram.com/p/CnhqzZLPEA6/?utm_source=ig_embed&amp;utm_campaign=loading" style=" background:#FFFFFF; line-height:0; padding:0 0; text-align:center; text-decoration:none; width:100%;" target="_blank"> <div style=" display: flex; flex-direction: row; align-items: center;"> <div style="background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 40px; margin-right: 14px; width: 40px;"></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 100px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 60px;"></div></div></div><div style="padding: 19% 0;"></div> <div style="display:block; height:50px; margin:0 auto 12px; width:50px;"><svg width="50px" height="50px" viewBox="0 0 60 60" version="1.1" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"><g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g transform="translate(-511.000000, -20.000000)" fill="#000000"><g><path d="M556.869,30.41 C554.814,30.41 553.148,32.076 553.148,34.131 C553.148,36.186 554.814,37.852 556.869,37.852 C558.924,37.852 560.59,36.186 560.59,34.131 C560.59,32.076 558.924,30.41 556.869,30.41 M541,60.657 C535.114,60.657 530.342,55.887 530.342,50 C530.342,44.114 535.114,39.342 541,39.342 C546.887,39.342 551.658,44.114 551.658,50 C551.658,55.887 546.887,60.657 541,60.657 M541,33.886 C532.1,33.886 524.886,41.1 524.886,50 C524.886,58.899 532.1,66.113 541,66.113 C549.9,66.113 557.115,58.899 557.115,50 C557.115,41.1 549.9,33.886 541,33.886 M565.378,62.101 C565.244,65.022 564.756,66.606 564.346,67.663 C563.803,69.06 563.154,70.057 562.106,71.106 C561.058,72.155 560.06,72.803 558.662,73.347 C557.607,73.757 556.021,74.244 553.102,74.378 C549.944,74.521 548.997,74.552 541,74.552 C533.003,74.552 532.056,74.521 528.898,74.378 C525.979,74.244 524.393,73.757 523.338,73.347 C521.94,72.803 520.942,72.155 519.894,71.106 C518.846,70.057 518.197,69.06 517.654,67.663 C517.244,66.606 516.755,65.022 516.623,62.101 C516.479,58.943 516.448,57.996 516.448,50 C516.448,42.003 516.479,41.056 516.623,37.899 C516.755,34.978 517.244,33.391 517.654,32.338 C518.197,30.938 518.846,29.942 519.894,28.894 C520.942,27.846 521.94,27.196 523.338,26.654 C524.393,26.244 525.979,25.756 528.898,25.623 C532.057,25.479 533.004,25.448 541,25.448 C548.997,25.448 549.943,25.479 553.102,25.623 C556.021,25.756 557.607,26.244 558.662,26.654 C560.06,27.196 561.058,27.846 562.106,28.894 C563.154,29.942 563.803,30.938 564.346,32.338 C564.756,33.391 565.244,34.978 565.378,37.899 C565.522,41.056 565.552,42.003 565.552,50 C565.552,57.996 565.522,58.943 565.378,62.101 M570.82,37.631 C570.674,34.438 570.167,32.258 569.425,30.349 C568.659,28.377 567.633,26.702 565.965,25.035 C564.297,23.368 562.623,22.342 560.652,21.575 C558.743,20.834 556.562,20.326 553.369,20.18 C550.169,20.033 549.148,20 541,20 C532.853,20 531.831,20.033 528.631,20.18 C525.438,20.326 523.257,20.834 521.349,21.575 C519.376,22.342 517.703,23.368 516.035,25.035 C514.368,26.702 513.342,28.377 512.574,30.349 C511.834,32.258 511.326,34.438 511.181,37.631 C511.035,40.831 511,41.851 511,50 C511,58.147 511.035,59.17 511.181,62.369 C511.326,65.562 511.834,67.743 512.574,69.651 C513.342,71.625 514.368,73.296 516.035,74.965 C517.703,76.634 519.376,77.658 521.349,78.425 C523.257,79.167 525.438,79.673 528.631,79.82 C531.831,79.965 532.853,80.001 541,80.001 C549.148,80.001 550.169,79.965 553.369,79.82 C556.562,79.673 558.743,79.167 560.652,78.425 C562.623,77.658 564.297,76.634 565.965,74.965 C567.633,73.296 568.659,71.625 569.425,69.651 C570.167,67.743 570.674,65.562 570.82,62.369 C570.966,59.17 571,58.147 571,50 C571,41.851 570.966,40.831 570.82,37.631"></path></g></g></g></svg></div><div style="padding-top: 8px;"> <div style=" color:#3897f0; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:550; line-height:18px;">Instagram에서 이 게시물 보기</div></div><div style="padding: 12.5% 0;"></div> <div style="display: flex; flex-direction: row; margin-bottom: 14px; align-items: center;"><div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(0px) translateY(7px);"></div> <div style="background-color: #F4F4F4; height: 12.5px; transform: rotate(-45deg) translateX(3px) translateY(1px); width: 12.5px; flex-grow: 0; margin-right: 14px; margin-left: 2px;"></div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(9px) translateY(-18px);"></div></div><div style="margin-left: 8px;"> <div style=" background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 20px; width: 20px;"></div> <div style=" width: 0; height: 0; border-top: 2px solid transparent; border-left: 6px solid #f4f4f4; border-bottom: 2px solid transparent; transform: translateX(16px) translateY(-4px) rotate(30deg)"></div></div><div style="margin-left: auto;"> <div style=" width: 0px; border-top: 8px solid #F4F4F4; border-right: 8px solid transparent; transform: translateY(16px);"></div> <div style=" background-color: #F4F4F4; flex-grow: 0; height: 12px; width: 16px; transform: translateY(-4px);"></div> <div style=" width: 0; height: 0; border-top: 8px solid #F4F4F4; border-left: 8px solid transparent; transform: translateY(-4px) translateX(8px);"></div></div></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center; margin-bottom: 24px;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 224px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 144px;"></div></div></a><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/p/CnhqzZLPEA6/?utm_source=ig_embed&amp;utm_campaign=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none;" target="_blank">Nani Shin(@nanishin)님의 공유 게시물</a></p></div></blockquote> <script async src="//www.instagram.com/embed.js"></script>

## 3. 무결성 체크 뒤 주차장에서 쇼타임!!!

USB 메모리에 최종 복사 전 시퀀스 파일 로딩에 문제가 없을 지 사전 무결성 체크!!!

```shell
$ python3.9 ~/github/light-show/validator.py lightshow.fseq
Found 5825 frames, step time of 20 ms for a total duration of 0:01:56.500000.
Used 20.57% of the available memory
```

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/VDFZY52ZMeU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
<br>
마지막으로 다른 테슬라 차주들도 사용할 수 있게 글로벌 테슬라 라이트쇼 공유 사이트에 등록 완료!!! ;P

- [TeslaLightShare.io N.EX.T - Lazenca Save Us](https://teslalightshare.io/light-show/566)

P.S. 제 추천 링크를 사용하여 Tesla 차량을 구매하고 할인 혜택(최대 ₩660,000) 및 리워드(향상된 오토파일럿 90일 이용)를 받으세요. :)

- http://ts.la/taeksu53570
