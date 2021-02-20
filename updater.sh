#!/bin/bash
clear
cd
rm -f updater*
sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command wasn't executed correctly."
sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error"
echo "\nDone, you can close this window."
sleep 99999
