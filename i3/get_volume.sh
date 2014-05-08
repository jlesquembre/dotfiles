#!/bin/bash

mute=`amixer -D pulse sget Master | grep "Front Left:" | awk '{print $6}'`

if [ $mute == "[off]" ] ; then
    echo "[Mute]"
else
    echo `amixer -D pulse sget Master | awk '/Front Left:/ {print $5}' | tr -dc "0-9"`%
fi

