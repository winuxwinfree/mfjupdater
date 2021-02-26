#!/bin/bash
#AUTHOR: androrama
#License GPLV3
#Script inspired by Fenix Updater and Fenix Assistant 
clear
cd
rm -f updater.sh*
cp /usr/share/applications/updater.desktop Desktop/ || echo "Error creating mfjupdater shortcut on desktop";
while :
do
	echo "   __     __)            __     __)                     
  (, /|  /|    /)  ,    (, /   /        /)              
    / | / |   //          /   /  __   _(/ _  _/_  _  __ 
 ) /  |/  |_ /(_  /_     /   /   /_)_(_(_(_(_(___(/_/ (_
(_/   '     /) .-/      (___(_.-/            beta           
           (/ (_/            (_/ 
---------------------------------------------------------"
echo "PRESS THE NUMBER:"
echo "1) To upgrade monkafenixjaro using the stable branch. "
echo "2) To upgrade monkafenixjaro using the unstable branch 
   (can break the system)."
echo "3) To clean unused packages and cache 
   (useful to clean the trash left by the previous options)."
echo " __                                                 
|__)_ |_ _|_  _ _   _  _  _|   _  _| _| __  _  _  _ 
|  (_||_(_| )(-_)  (_|| )(_|  (_|(_|(_|    (_)| )_) 
---------------------------------------------------------       "
echo "PRESS THE LETTER:"
echo "a) To repair tor-browser."
echo "b) Download wine apps and games."
echo "c) Solve crackling, popping, and other sound problems."
echo ""
echo -n "[Type an option: 1,2,3,a,b,c,q(EXIT) and then press INTRO]=> "
read opcion
case $opcion in
1) sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command can't be executed.";
   sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
   sudo mkdir /usr/share/bin || echo "";
   sudo mv /usr/bin/discord /usr/share/bin/ || echo "";
   #temporal
   sudo systemctl mask attach-bluetooth.service || echo "";
   sleep 10;;
2) sudo pacman-mirrors -aS unstable || echo "You are already using the unstable branch or the command can't be executed.";
   sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
   #temporal
   sudo systemctl mask attach-bluetooth.service || echo "";
   sleep 10;;
3) echo "
   Attention, please read the following warnings before proceeding:
   " & sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);
   sleep 10;;
a) install-tor;
   sleep 10;;
b) sh download-update_wine_test_apps.sh;
   sleep 10;;
c) echo "After this the equalizer and pulse-audio options will not work.";
   pulseaudio --kill || echo "Error killing pulseaudio, maybe it's killed.";
   systemctl --user mask pulseaudio.service || echo "Error masking pulseaudio.service, maybe it's already masked.";
   systemctl --user mask pulseaudio.socket || echo "Error masking pulseaudio.socket, maybe it's already masked.";
   sudo pacman -S alsa-utils || echo "Error installing alsa-utils.";
   sudo pacman -S qastools || echo "Error installing qastools.";
   cp /usr/share/applications/qasmixer.desktop Desktop/ || echo "Error creating qasmixer shortcut on desktop";
      echo " 

 ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ 
||R |||e |||b |||o |||o |||t |||       |||t |||h |||e ||
||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|
 ____ ____ ____ ____ ____ ____ 
||s |||y |||s |||t |||e |||m ||
||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|


                     ";
   echo "Once the patch has been applied, reboot and then right click on the volume icon,go to volume control settings and change the command to open the mixer to alsamixer (you can also use this command in a terminal). This allows to open the advanced sound control settings by clicking on Launch Mixer.";
   sleep 30;;
q) echo "Done, closing.";
   sleep 3; exit 1;;
*) echo "$opc invalid option ";
echo "Press a key to continue.";
read foo;;
esac
done
