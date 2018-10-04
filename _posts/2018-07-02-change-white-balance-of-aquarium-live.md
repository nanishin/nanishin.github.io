---
layout: post
comments: true
title:  "화이트발란스 변경으로 아쿠아리움라이브의 색감 조정"
date:   2018-07-02 20:30:00 +0900
categories: maker
---
파이캠의 기본 화이트발란스는 auto인데 어항조명에서 노랑색이 강하게 나타나서 해결방법을 찾다 보니

raspvid의 화이트발란스 옵션을 -aws sun로 둘 때 가장 자연스러운 색감이 나오는 것을 확인하고 적용 완료!!!

https://www.raspberrypi.org/documentation/raspbian/applications/camera.md 에서 발췌

> sun: sunny mode (between 5000K and 6500K)

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/bMGRpjKWRgI" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

