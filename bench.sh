#!/bin/sh -e

START=$(date "+%s")

ruby -Ilib bin/rcopyfind.rb -t ../../lib/brief_discourse-george_north.md -s ../../lib/shakespeare/plays/richard3.txt & PID=$!

sleep 2
rbspy record -p $PID

TIME=$(($(date "+%s")-$START))
echo "$TIME seconds elapsed."
