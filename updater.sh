#!/bin/bash
clear
echo "Feature under development. "
echo "We test all updates to make sure they don't break anything, use this tool instead of pacman -Syyu... if you don't want to take risks."
echo "You have 15 seconds to close this window if you do not want to switch to the stable branch and upgrade the system."
echo "Commands to be executed:"
echo "1.sudo pacman-mirrors -aS stable. Important to avoid bluetooth problems and high cpu consumption on a core. Problem: Manjaro ARM update failed, “brcm-patchram-plus” and “pi-bluetooth” conflicting-https://forum.manjaro.org/t/manjaro-arm-update-failed-brcm-patchram-plus-and-pi-bluetooth-conflicting/42902"
echo "2.sudo pacman-Syyu"
sleep 15
sudo pacman-mirrors -aS stable
sleep 5
