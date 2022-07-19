---
#layout: posts
comments: true
title:  "부팅 안되는 RPI3, sdcard 파일시스템 수정으로 되살리기"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.jpg
date:   2022-07-15 23:45:00 +0900
categories:
  - tip
tags:
  - Raspberry Pi 3 Model B+
  - RPI3
  - 라즈베리파이3
---
한동안 RPI3로 돌리고 있는 서비스들(3D프린팅, 테슬라메이트 등)을 사용하지 않고 방치해둔 지 1개월 가량 지나 오랜만에 3D프린팅을 하려고 보니 RPI3가 부팅안되는 현상 확인... 복구가 안되면 예전처럼 수동으로 데이터 백업시킨 뒤 라즈베리안 최신 이미지 재설치까지 고난의 시간이 필요하기에 기도하는 마음으로 sdcard를 USB 리더기 사용해서 어항방송용 다른 RPI3에 연결하고 아래 사이트를 참고해서 복구 시작!!!

- [Repairing a Raspberry Pi Boot Partition](https://platfrastructure.life/post/rpi_boot_repair/)

## 1. rootfs ext4 파일시스템 복구

다른 RPI3에 USB 스토리지로 연결한 상태인지라 dev 디바이스 이름 확인한 뒤 우선 rootfs ext4 파티션의 파일시스템 복구

```shell
pi@rpi-aquarium:~ $ e2fsck -f -y /dev/sda2 
e2fsck 1.46.2 (28-Feb-2021)
e2fsck: Permission denied while trying to open /dev/sda2
You must have r/w access to the filesystem or be root
pi@rpi-aquarium:~ $ sudo e2fsck -f -y /dev/sda2 
e2fsck 1.46.2 (28-Feb-2021)
Pass 1: Checking inodes, blocks, and sizes
Inode 809 extent tree (at level 1) could be shorter.  Optimize? yes

Inodes that were part of a corrupted orphan linked list found.  Fix? yes

Inode 19015 was part of the orphaned inode list.  FIXED.
Inode 19097 was part of the orphaned inode list.  FIXED.
Pass 1E: Optimizing extent trees
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(1683010--1683011) +1688072 +1701533
Fix? yes


rootfs: ***** FILE SYSTEM WAS MODIFIED *****
rootfs: 180253/1865344 files (0.2% non-contiguous), 2155412/7725184 blocks
```

## 2. boot vfat 파일시스템 복구

다음으로 boot vfat 파티션의 파일시스템 복구

```shell
pi@rpi-aquarium:~ $ sudo dosfsck -t -a -w /dev/sda1
fsck.fat 4.2 (2021-01-31)
There are differences between boot sector and its backup.
This is mostly harmless. Differences: (offset:original/backup)
  65:01/00
  Not automatically fixing this.
Dirty bit is set. Fs was not properly unmounted and some data may be corrupt.
 Automatically removing dirty bit.
/dev/sda1: 402 files, 120815/516190 clusters
```

## 3. 다시금 RPI3는 힘차게 돌기 시작하고...

이후 원래 사용하던 RPI3에 sdcard 꽂고 무사히 부팅에 성공해서 3D프린팅도 하고 테슬라메이트도 업데이트 시킴... 얼쑤~ :D
