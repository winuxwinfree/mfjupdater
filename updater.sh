#!/bin/bash
clear
echo "Feature under development."
echo "Commands to be executed:"
echo "1.sudo pacman-mirrors -aS stable."
echo "2.sudo pacman-Syyu"
sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command wasn't executed correctly."
sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error"
echo "Done, you can close this window."
sleep 99999
