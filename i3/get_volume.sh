#!/bin/bash


volume=`pulseaudio-ctl full-status`
level=`echo $volume | awk '{print $1}'`
out_muted=`echo $volume | awk '{print $2}'`
in_muted=`echo $volume | awk '{print $3}'`

if [ $out_muted == "yes" ] ; then
    echo "[Mute]"
else
    echo "${level}%"
fi


#mute=`amixer -D pulse sget Master | grep "Front Left:" | awk '{print $6}'`
#
#if [ $mute == "[off]" ] ; then
#    echo "[Mute]"
#else
#    echo `amixer -D pulse sget Master | awk '/Front Left:/ {print $5}' | tr -dc "0-9"`%
#fi
