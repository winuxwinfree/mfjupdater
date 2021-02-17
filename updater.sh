#!/bin/bash
clear
echo "Feature under development. "
echo "We test all updates to make sure they don't break anything, use this tool instead of pacman -Syyu... if you don't want to take risks."
echo "This script will switch the repositories to the stable branch in 10 seconds. Close this window if you prefer to continue using the unstable one."
echo "Commands to be executed: sudo pacman-mirrors -aS stable. Important to avoid bluetooth problems and high cpu consumption on a core. Problem: Manjaro ARM update failed, “brcm-patchram-plus” and “pi-bluetooth” conflicting https://forum.manjaro.org/t/manjaro-arm-update-failed-brcm-patchram-plus-and-pi-bluetooth-conflicting/42902"
sleep 10
sudo pacman-mirrors -aS stable
sleep 5
