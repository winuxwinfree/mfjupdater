#!/bin/bash
#AUTHOR: androrama
#License GPLV3
#Script inspired by Fenix Updater and Fenix Assistant 
clear
cd
rm -f updater*

while :
do
	echo "   __     __)            __     __)                     
  (, /|  /|    /)  ,    (, /   /        /)              
    / | / |   //          /   /  __   _(/ _  _/_  _  __ 
 ) /  |/  |_ /(_  /_     /   /   /_)_(_(_(_(_(___(/_/ (_
(_/   '     /) .-/      (___(_.-/                       
           (/ (_/            (_/ 
---------------------------------------------------------"
echo "PRESS THE NUMBER:"
echo "1) To upgrade packages using the stable branch. "
echo "2) To upgrade packages using the unstable branch 
   (can break the system)."
echo "3) To clean unused packages and cache 
   (useful to clean the trash left by the previous options)."
echo "___  ____ ___ ____ _  _ ____ ____ 
|__] |__|  |  |    |__| |___ [__  
|    |  |  |  |___ |  | |___ ___]   and Add-ons
---------------------------------------------------------       "
echo "PRESS THE LETTER:"
echo "a) To repair tor-browser. b) Download wine apps and games."
echo ""
echo -n "Type an option:[1,2,3,a,b,q(EXIT)]=> "
read opcion
case $opcion in
1) sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command can't be executed.";
   sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";;
2) sudo pacman-mirrors -aS unstable || echo "You are already using the unstable branch or the command can't be executed.";
   sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";;
3) echo "
   Attention, please read the following warnings before proceeding:
   " & sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);;
a) install-tor;;
b) sh download-update_wine_test_apps.sh;;
q) echo "Done, closing.";
   sleep 3; exit 1;;
*) echo "$opc invalid option ";
echo "Press a key to continue.";
read foo;;
esac
done
