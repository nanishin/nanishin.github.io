---
#layout: posts
comments: true
title:  "Docker 사용 중 발생한 Windows10 크래시 해결 방법"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.png
date:   2019-03-02 03:00:00 +0900
categories:
  - tip
tags:
  - Docker
  - Windows10
---
다시 Docker 기반 환경에서 적극적으로 개발해야 하는 상황이라 Windows10의 Hyper-V를

활성화하고 Base Container Image 빌드를 진행하던 중 계속 BSOD(Blue Screen Of Death) 발생

KERNEL_SECURITY_CHECK_FAILURE

DRIVER_IRQ_NOT_LESS_OR_EQUAL

여러 삽질을 거치다 아래 설정으로 어느정도 안정되어 아래 순서로 정리

1. [Windows10 1809 버전으로 업데이트](https://support.microsoft.com/ko-kr/help/4028685/windows-10-get-the-update)
2. [vmcompute.exe와 vmwp.exe에 대한 CFG(Code Flow Guard) 정책 적용 해제](https://social.technet.microsoft.com/Forums/en-US/ee5b1d6b-09e2-49f3-a52c-820aafc316f9/hyperv-doesnt-work-after-upgrade-to-windows-10-1809?forum=win10itprovirt)
3. 기존 설치된 Docker Desktop Uninstall
4. [Clean Remove Docker using Powershell Script](https://success.docker.com/article/how-to-completely-remove-docker-in-windows-10)
5. regedit 실행해서 Registry에서 docker 이름으로 검색되는 항목들 모두 수동 제거
6. Windows 기능 켜기 / 끄기 메뉴에서 Hyper-V 체크해제 후 재시작
7. Docker Hub에서 Docker Desktop Edge 버전 다운로드 후 설치
8. Windows 기능 켜기 / 끄기 메뉴에서 Hyper-V 체크 후 재시작
9. Docker 트레이 확인 후 사용
