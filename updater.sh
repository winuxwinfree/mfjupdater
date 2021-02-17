#!/bin/bash
clear
echo "Feature under development."
echo "This script will switch the repositories to the stable branch in 10 seconds. Close this window if you prefer to continue using the unstable one."
echo "Command to be executed: sudo pacman-mirrors -aS stable."
sleep 10
sudo pacman-mirrors -aS stable
sleep 5
