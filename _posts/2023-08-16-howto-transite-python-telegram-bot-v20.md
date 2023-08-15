---
#layout: posts
comments: true
title:  "python-telegram-bot v20 전환하기"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.jpg
date:   2023-08-16 02:10:00 +0900
categories:
  - tip
tags:
  - Python Telegram Bot
  - PTB
  - 파이썬 텔레그램 봇
---
작년에 python-telegram-bot으로 여러 봇 서비스들을 도커 컨테이너로 생성 뒤 사용했는데 주로 라즈베리파이4 시스템의 패키지 업데이트만 진행하고 봇 서비스 중인 컨테이너 내 코드 변화는 따라가고 있지 않았음

올해 상반기부터 트위터 개발자 권한 축소 (Elevated access에서 통폐합된 Free access로 강등) 여파였는지 API 호출도 몇번 막히고 이후 봇 서비스도 잘 동작하지 않아서 1년 만에 도커 컨테이너 이미지 리빌드 후 동작 시험하다가 모듈 에러들이 연이어 발생... 

마침 그당시 업무로 바쁘기도 했던 상황이라 그냥 냅두고 몇개월 방치하다가 이제서야 수정 작업 돌입!!!

분석 결과 주원인은 2023년부터 python-telegram-bot 기본 버전이 v13에서 v20으로 올라가면서 대규모 리팩토링이 발생했는데 그로 인해 코드 하위 호환성이 모두 깨진 상황...

결국 아래 가이드를 바탕으로 하나하나 수정 삽질을 반복하며 최종 전환 완료 후 내용 정리

- [Transition guide to Version 20.0](https://github.com/python-telegram-bot/python-telegram-bot/wiki/Transition-guide-to-Version-20.0)

## 1. 모듈 이름은 telegram.bot 대신 telegram 사용

Bot 모듈을 위해 사용하던 telegram.bot 대신 telegram 사용

```python
# from telegram.bot import Bot
from telegram import Bot
```

## 2. Bot 동작은 Updater 대신 Application 사용

main 함수에서 Bot 동작을 위해 사용하던 Updater 대신 v20 버전부터 새로운 구조 핵심인 Application 사용. 이 여파로 dispatcher 통해 핸들러 붙이던 방식은 직접 연결로 간결해짐

```python
from telegram.ext import (
    Application,
    # Updater,
    CommandHandler,
    CallbackQueryHandler,
    CallbackContext,
)

def main() -> None:
    """Run the bot."""
    application = Application.builder().token(os.getenv('TELEGRAM_BOT_API_KEY')).build()
    application.add_handler(CommandHandler('start', start))
    # updater = Updater(os.getenv('TELEGRAM_BOT_API_KEY'))
    # updater.dispatcher.add_handler(CommandHandler('start', start))

    # Start the Bot
    application.run_polling(allowed_updates=Update.ALL_TYPES)
    # updater.start_polling()
```

## 3. async 상태 적용 후 다시금 봇 서비스 재개

동작 시험 과정에서 warning 메시지 확인 후 Application 기반 동작 시 내부에 신규 추가된 asyncio 모듈 영향으로 코드 내 async나 await 적절히 추가 후 봇 서비스 다시 재개~ :D

```python
# def start(update: Update, context: CallbackContext) -> None:
async def start(update: Update, context: CallbackContext) -> None:

    # logic blah blah blah

    reply_markup = InlineKeyboardMarkup(keyboard)
    # update.message.reply_text('What do you want to do? :', reply_markup=reply_markup)
    await update.message.reply_text('What do you want to do? :', reply_markup=reply_markup)
```
