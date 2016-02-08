#!/bin/bash


# Dependencies:
# volumeicon (official)
# pulseaudio-ctl (AUR)
# volnoti-hcchu-git (AUR)


read level out_muted in_muted <<<$(pulseaudio-ctl full-status)

if [ $out_muted == "yes" ] ; then
    volnoti-show -m
else
    volnoti-show $level
fi
