#!/bin/sh
# app.html(본문만) → index.html(웹에 올릴 수 있는 완전한 페이지) 로 감싸 준다.
# 앱을 고친 뒤 ./build.sh 한 번 실행하면 index.html이 새로 만들어진다.
set -e
cd "$(dirname "$0")"
END=$(grep -n '</style>' app.html | head -1 | cut -d: -f1)
{
  cat head.part
  sed -n "1,${END}p" app.html
  printf '</head>\n<body>\n'
  sed -n "$((END+1)),\$p" app.html
  printf '</body>\n</html>\n'
} > index.html
echo "index.html 생성 완료 ($(wc -c < index.html | tr -d ' ') bytes)"
