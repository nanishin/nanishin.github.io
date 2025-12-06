#!/bin/bash
# 로컬 Jekyll 서버 실행 스크립트

echo "🚀 Jekyll 로컬 서버를 시작합니다..."
echo ""
echo "브라우저에서 http://localhost:4000 으로 접속하세요."
echo "서버를 중지하려면 Ctrl+C를 누르세요."
echo ""

# --quiet 옵션으로 경고 메시지 최소화 (선택적)
# bundle exec jekyll serve --incremental --quiet

# 기본 실행 (경고 메시지 포함)
bundle exec jekyll serve --incremental


