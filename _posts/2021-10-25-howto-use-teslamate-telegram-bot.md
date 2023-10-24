---
#layout: posts
comments: true
title:  "TeslaMate Telegram Bot으로 테슬라 상태 정보 얻기"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/teslamate_telegram_bot.jpg
date:   2021-10-25 02:45:00 +0900
categories:
  - tip
tags:
  - Raspberry Pi
  - RPI
  - TeslaMate
  - MQTT
  - Telegram Bot
  - Docker
  - Tesla
  - 라즈베리파이
  - 테슬라메이트
  - 텔레그램 봇
  - 도커
  - 테슬라
---
메이커 입장에서 테슬라 차량은 Arduino/RaspberryPi/ESP 등을 활용하는 실험/재미를 넘어서서 상업적인 대량생산까지 성공한 최신 IoT 기기의 끝판왕이라 할 수 있음. 특히나 제로마진을 설파했던 제러미 리프킨이 언급한 좌초자산의 관점에서 보더라도 더이상 신규 내연기관차량은 선택지가 될 수 없음

진정한 21세기 미래 디자인을 몇개월 간 경험하면서 느낀 부분은 기존 내연기관 제조사들이 뒤늦게 테슬라를 쫓아 전기차로의 전환을 진행하면서 하드웨어 플래폼은 얼추 비슷한 형태로 올라온 듯 보이나 소프트웨어 부분에서는 OTA 업데이트를 통해 개선되거나 추가되는 기능들을 보면 여전히 차이가 크다는 걸 실감하게 됨

## 1. 테슬라 통계자료 풀장, TeslaMate

이 모든 응용의 시작인 Tesla API는 사실 공식적으로 오픈된 적은 없지만 Android/iOS Tesla 앱을 다년 간 리버스엔지니어링을 통해 다양한 응용 솔루션이 나오고 있음. 그러나 내 차량의 원격 제어권이 넘어갈 수 있다는 물리적인 보안 이슈와 동작 안정성을 고려했을 때 TeslaMate 정도가 오픈소스로 글로벌하게 크로스리뷰되면서 개인환경(라즈베리파이 내 도커 또는 개인 계정 클라우드)에서 안정적으로 관리할 수 있는 솔루션이라 할 수 있음

- [TeslaMate GitHub](https://github.com/adriankumpf/teslamate)

## 2. 이 풀장에서 얻을 수 있는 정보들의 리스트, MQTT Topics

한동안 TeslaMate의 통계자료를 보는 것만으로도 뿌듯한 나날이었지만 슬슬 IoT 연동 확인도 필요한지라 1단계 확인차원으로 TeslMate에서 수집된 테슬라 차량 상태를 Get하는데 사용하는 MQTT Topic들을 Telegram Bot을 통해 확인

- [TeslaMate MQTT Topics List](https://docs.teslamate.org/docs/integrations/mqtt#mqtt-topics)

- [TeslaMate Telegram Bot - check_teslamate_mqtt_topics Branch](https://github.com/nanishin/TeslaMate_Telegram_Bot/tree/check_teslamate_mqtt_topics)

```shell
pi@raspberrypi:~ $ cat teslamte_telegram_bot.py
...
def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload.decode()))
    title = msg.topic
    value = str(msg.payload.decode())
    # Check Teslamate MQTT Topics based on https://docs.teslamate.org/docs/integrations/mqtt
    if msg.topic == "teslamate/cars/1/display_name":
        title = "<b>Display Name</b> : "
    elif msg.topic == "teslamate/cars/1/state":
        title = "<b>State</b> : "
    elif msg.topic == "teslamate/cars/1/since":
        title = "<b>Since</b> : "
    elif msg.topic == "teslamate/cars/1/healthy":
        title = "<b>Healthy</b> : "
    elif msg.topic == "teslamate/cars/1/version":
        title = "<b>Version</b> : "
    elif msg.topic == "teslamate/cars/1/update_available":
        title = "<b>State</b> : "
    elif msg.topic == "teslamate/cars/1/update_version":
        title = "<b>Update Version</b> : "
    elif msg.topic == "teslamate/cars/1/model":
        title = "<b>Model</b> : "
    elif msg.topic == "teslamate/cars/1/trim_badging":
        title = "<b>Trim Badging</b> : "
    elif msg.topic == "teslamate/cars/1/exterior_color":
        title = "<b>Exterior Color</b> : "
    elif msg.topic == "teslamate/cars/1/wheel_type":
        title = "<b>Wheel Type</b> : "
    elif msg.topic == "teslamate/cars/1/spoiler_type":
        title = "<b>Spoiler Type</b> : "
    elif msg.topic == "teslamate/cars/1/geofence":
        title = "<b>Geofence</b> : "
    elif msg.topic == "teslamate/cars/1/latitude":
        title = "<b>latitude</b> : "
    elif msg.topic == "teslamate/cars/1/longitude":
        title = "<b>Longitude</b> : "
    elif msg.topic == "teslamate/cars/1/shift_state":
        title = "<b>Shift State</b> : "
    elif msg.topic == "teslamate/cars/1/power":
        title = "<b>Power</b> : "
    elif msg.topic == "teslamate/cars/1/speed":
        title = "<b>Speed</b> : "
    elif msg.topic == "teslamate/cars/1/heading":
        title = "<b>Heading</b> : "
    elif msg.topic == "teslamate/cars/1/elevation":
        title = "<b>Elevation</b> : "
    elif msg.topic == "teslamate/cars/1/locked":
        title = "<b>Locked</b> : "
    elif msg.topic == "teslamate/cars/1/sentry_mode":
        title = "<b>Sentry Mode</b> : "
    elif msg.topic == "teslamate/cars/1/windows_open":
        title = "<b>Windows Open</b> : "
    elif msg.topic == "teslamate/cars/1/doors_open":
        title = "<b>Doors Open</b> : "
    elif msg.topic == "teslamate/cars/1/trunk_open":
        title = "<b>Trunk Open</b> : "
    elif msg.topic == "teslamate/cars/1/frunk_open":
        title = "<b>Frunk Open</b> : "
    elif msg.topic == "teslamate/cars/1/is_user_present":
        title = "<b>Is User Present</b> : "
    elif msg.topic == "teslamate/cars/1/is_climate_on":
        title = "<b>Is Climate On</b> : "
    elif msg.topic == "teslamate/cars/1/inside_temp":
        title = "<b>Inside Temp</b> : "
    elif msg.topic == "teslamate/cars/1/outside_temp":
        title = "<b>Outside Temp</b> : "
    elif msg.topic == "teslamate/cars/1/is_preconditioning":
        title = "<b>Is Preconditioning</b> : "
    elif msg.topic == "teslamate/cars/1/odometer":
        title = "<b>Odometer</b> : "
    elif msg.topic == "teslamate/cars/1/est_battery_range_km":
        title = "<b>Est Battery Range Km</b> : "
    elif msg.topic == "teslamate/cars/1/rated_battery_range_km":
        title = "<b>Rated Battery Range Km</b> : "
    elif msg.topic == "teslamate/cars/1/ideal_battery_range_km":
        title = "<b>Ideal Battery Range Km</b> : "
    elif msg.topic == "teslamate/cars/1/battery_level":
        title = "<b>Battery Level</b> : "
    elif msg.topic == "teslamate/cars/1/usable_battery_level":
        title = "<b>Usable Battery Level</b> : "
    elif msg.topic == "teslamate/cars/1/plugged_in":
        title = "<b>Plugged In</b> : "
    elif msg.topic == "teslamate/cars/1/charge_energy_added":
        title = "<b>Charge Energy Added</b> : "
    elif msg.topic == "teslamate/cars/1/charge_limit_soc":
        title = "<b>Charge Limit</b> : "
    elif msg.topic == "teslamate/cars/1/charge_port_door_open":
        title = "<b>Charge Port Door Open</b> : "
    elif msg.topic == "teslamate/cars/1/charger_actual_current":
        title = "<b>Charger Actual Current</b> : "
    elif msg.topic == "teslamate/cars/1/charger_phases":
        title = "<b>Charger Phases</b> : "
    elif msg.topic == "teslamate/cars/1/charger_power":
        title = "<b>Charger Power</b> : "
    elif msg.topic == "teslamate/cars/1/charger_voltage":
        title = "<b>Charger Voltage</b> : "
    elif msg.topic == "teslamate/cars/1/scheduled_charging_start_time":
        title = "<b>Scheduled Charging Start Time</b> : "
    elif msg.topic == "teslamate/cars/1/time_to_full_charge":
        title = "<b>Time To Full Charge</b> : "

    bot.send_message(
        chat_id,
        text = title + value,
        parse_mode=ParseMode.HTML,
    )
...
```

## 3. 버튼 제어 추가

버튼 제어를 통해 좀 더 모아보는 형태로 수정 적용 완료

- [TeslaMate Telegram Bot - add_button_control Branch](https://github.com/nanishin/TeslaMate_Telegram_Bot/tree/add_button_control)

![Tesla Vehicle Information with TeslaMate MQTT Topics](/assets/images/teslamate_telegram_bot.jpg)

## 4. Set은 결국 Tesla API 직접 호출로...

요건 운행 중인 테슬라 차량 상태에 직접 영향을 줄 수 있다 보니 추가 시나리오 확인 후 적용 예정

P.S. 제 추천 링크를 사용하여 Tesla 차량을 구매하고 할인 혜택(최대 ₩660,000) 및 리워드(향상된 오토파일럿 90일 이용)를 받으세요. :)

- http://ts.la/taeksu53570
