---
#layout: posts
comments: true
title:  "Docker로 라즈베리파이용 ffmpeg 빌드하기"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.jpg
date:   2021-09-12 23:50:00 +0900
categories:
  - tip
tags:
  - Raspberry Pi
  - RPI
  - FFmpeg
  - Docker
  - 라즈베리파이
  - 도커
---
2018년 중반 메이커 활동을 본격화하면서 라즈베리파이3 내 ffmpeg 환경으로 어항방송 구축한 뒤 큰 업데이트 없이 소소한 튜닝 정도만 적용하면서 그대로 SmartThings 자동화와 연동해서 사용한 지 어언 3년...

그러다 일주일 전 잦은 스트리밍 처리로 SD카드 파티션에 에러가 누적되었는지 file io error 발생하면서 부팅 안됨...

이거이거 스트리밍으로 SD카드 수명이 단축된건가 했는데 다행히 다른 라즈베리파이에 마운트해서 fsck로 수정 처리하고 기존 데이터들 백업한 뒤 몇번의 포맷을 거쳐 다시 정상 부팅 확인...

기왕 오랜만에 업데이트한 김에 ffmpeg도 최신 버전 빌드하기 수월하게 docker 환경으로 정리 완료!!!

- [RPI FFmpeg Docker Build](https://github.com/nanishin/rpi-ffmpeg-docker-build)

그러나 아쉽게도 하드웨어 가속용 OMX 옵션(--enable-omx --enable-omx-rpi)은 아래 raspbian 환경과 달리 docker 이미지 내 libraspberrypi-dev 패키지에는 관련 헤더파일들이 없어서 뺀 상태로만 빌드 가능하다는 제약이 있음... :'( 그러니 빌드 과정 참고용으로만 활용...

현재 어항방송에 사용 중인 최신 버전 ffmpeg은 OMX 옵션을 사용하기 위해 raspbian 환경에서 직접 빌드한 건 안비밀 ;P

```shell
pi@raspberrypi:~ $ dpkg -L libraspberrypi-dev | grep OMX
/opt/vc/include/IL/OMX_Audio.h
/opt/vc/include/IL/OMX_Broadcom.h
/opt/vc/include/IL/OMX_Component.h
/opt/vc/include/IL/OMX_Core.h
/opt/vc/include/IL/OMX_ILCS.h
/opt/vc/include/IL/OMX_IVCommon.h
/opt/vc/include/IL/OMX_Image.h
/opt/vc/include/IL/OMX_Index.h
/opt/vc/include/IL/OMX_Other.h
/opt/vc/include/IL/OMX_Types.h
/opt/vc/include/IL/OMX_Video.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Audio.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Broadcom.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Component.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Core.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_ILCS.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_IVCommon.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Image.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Index.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Other.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Types.h
/opt/vc/include/interface/vmcs_host/khronos/IL/OMX_Video.h
```

