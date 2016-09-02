#!/bin/sh

SED_COMMAND='sed'
if test "$(uname)" = "Darwin"; then
  SED_COMMAND='gsed'
fi


read -p "Converting Essays (mayus) in: " choice
egrep -rl 'Essays' * | xargs $SED_COMMAND -i "s/Essays/$choice/g"

read -p "Converting essays (minus) in: " choice
egrep -rl 'essays' . | xargs $SED_COMMAND -i "s/essays/$choice/g"

rm -Rf .git
git init .
