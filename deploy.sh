#!/usr/bin/env sh

set -e

flutter build web --release

cd ./build/web

git init
git add -A
timestamp="`date +'%Y-%m-%dT%T.%3N%z'`"
git commit -m "deploy @ $timestamp"

git push -f git@github.com:r08521610/personal_website.git master:gh-pages

cd -
