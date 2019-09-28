---
layout: post
comments: true
title:  "DIY 3D 프린터용 OctoPrint PSU 제어 추가 (Docker 기반)"
date:   2019-09-29 02:30:00 +0900
categories: maker
---
귀차니즘은 결국 임계치가 있다. 왠만하면 3D 프린터 사용 후 전원을 끄기 위해 PSU 코드를 뺐는데

이것도 1년 정도 반복하니 해야지 해야지 하던 Relay로 PSU 전원 제어 기능을 결국 추가...

그런데 평소 아두이노에서 주로 하던 GPIO 처리를 라즈베리파이에서 하면서 처음에는 핀배열 헷갈려서 삽질~

이후에는 좀 더 양상이 복잡해져서 Docker Container 안에서 root가 아닌 octoprint에게 gpio 그룹 추가해도

결국 pid 관리 범위가 다른지라 제대로 먹히질 않아서 OctoPrint PSU Plugin에서 직접 GPIO Pin 통한 제어는

불가능하다는 것을 여러번의 삽질 끝에 확인하고 결국 sudoers에 octoprint를 추가해서 System Command

처리로 최종동작 확인한 뒤 내용 정리!!!

![PSU plugin menu](/assets/psu_plugin_menu.png)

GPIO 지원을 위해 적용된 패치 및 스크립트 
```shell
% git diff Dockerfile
diff --git a/Dockerfile b/Dockerfile
index 765d6fa..6e3363b 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -33,6 +33,22 @@ RUN cd /tmp \
 #Create an octoprint user
 RUN useradd -ms /bin/bash octoprint && adduser octoprint dialout
 RUN chown octoprint:octoprint /opt/octoprint
+
+#To support GPIO
+RUN pip install --upgrade RPi.GPIO
+
+#To control GPIO with octoprint user in docker container
+RUN apt-get update && apt-get install -y sudo
+RUN echo "octoprint ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/010_octoprint-nopasswd
+RUN chmod 0440 /etc/sudoers.d/010_octoprint-nopasswd
+
+# Not worked even octoprint user is added to gpio group
+#RUN groupadd gpio
+#RUN usermod -a -G gpio octoprint
+#RUN grep gpio /etc/group
+#RUN chown root.gpio /dev/gpiomem
+#RUN chmod g+rw /dev/gpiomem
+
 USER octoprint
 #This fixes issues with the volume command setting wrong permissions
 RUN mkdir /home/octoprint/.octoprint
@@ -44,5 +60,4 @@ RUN git clone --branch $tag https://github.com/foosel/OctoPrint.git /opt/octopri

 VOLUME /home/octoprint/.octoprint

-
 CMD ["/opt/octoprint/venv/bin/octoprint", "serve"]

% cd ..

% cat psu_power_on.py 
import RPi.GPIO as GPIO
import time

PIN = 4 

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM) # GPIO Numbers instead of board numbers
GPIO.setup(PIN, GPIO.OUT) # GPIO Assign mode

GPIO.output(PIN, GPIO.HIGH) # on
time.sleep(1)
#GPIO.cleanup()

% cat psu_power_off.py 
import RPi.GPIO as GPIO
import time

PIN = 4 

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM) # GPIO Numbers instead of board numbers
GPIO.setup(PIN, GPIO.OUT) # GPIO Assign mode

GPIO.output(PIN, GPIO.LOW) # out
time.sleep(1)
#GPIO.cleanup()
```

다행히 PSU 라인은 이미 기본적으로 Live, Neutral, Earth 구분이 되어 있던지라 Live 선으로 Relay 연결 작업 진행

![Check PSU Line](/assets/20190928_101608.png)

예전에 멀티탭 케이블 자른 뒤 직접 Relay 연결하면서 남은 220V 용 전선이 있던지라 재사용

![Prepare relay and wire](/assets/20190928_102644.png)
![Prepare relay and wire](/assets/20190928_103230.png)

NO (Normal Open)과 Common으로 각각 연결

![NO and Common](/assets/20190928_103538.png)
![NO and Common](/assets/20190928_103835.png)

OctoPrint 내 PSU toggle button으로 전원 제어 동작 확인!!!

![PSU toggle button](/assets/psu_toggle_button.png)
![psu control test](/assets/20190929_021510.png)
![psu control test](/assets/20190929_021504.png)

Docker Hub에도 Container Image 적용 완료

[Docker Hub - nanishin/arm32v7-octoprint](https://cloud.docker.com/repository/docker/nanishin/arm32v7-octoprint)
