#!/bin/bash
#AUTHOR: androrama, fenixlinux.com
#License GPLV3
#Script inspired by Fenix Updater and Fenix Assistant 

clear
cd
rm -f updater.sh*

patch () {
  echo 
  echo "Apply this patch if you have any of these problems:"
  echo "1: Crackling, popping, and other sound problems."
  echo "   (After this the equalizer and pulse-audio options will not work.)"
  echo "2: Bluetooth service does't work."
  echo "3: Discord does't work."
  echo 

  while true; do
    read -p "Run this patch? [y/n]: " yn
  case $yn in
    [Yy]* ) 


  echo ""
  echo "Step 1, installing alsa."
  read -p " Alsa sound is better, but pulseaduio equalizer will not work, continue? (y/n)]=> " answer 
  if [ $answer = y ] || [ $answer = Y ]; then
    pulseaudio --kill || echo "Error killing pulseaudio, maybe it's killed."
    systemctl --user mask pulseaudio.service || echo "Error masking pulseaudio.service, maybe it's already masked."
    systemctl --user mask pulseaudio.socket || echo "Error masking pulseaudio.socket, maybe it's already masked."
    sudo pacman -S alsa-utils || echo "Error installing alsa-utils."
    sudo pacman -S qastools || echo "Error installing qastools."
  FILE=Desktop/qasmixer.desktop
  if [ ! -f "$FILE" ]; then
    cp /usr/share/applications/qasmixer.desktop Desktop/ || echo "Error creating qasmixer shortcut on desktop"
  fi
  echo "Reboot and then right click on the volume icon,go to volume control settings and change the command to open the mixer to alsamixer (you can also use this command in a terminal). This allows to open the advanced sound control settings by clicking on Launch Mixer."
  sleep 5
  else
    echo "Unable to install alsa."
  fi

  echo "Step 2, repairing bluetooth problem.";
  sudo systemctl unmask attach-bluetooth.service;
  sudo systemctl start attach-bluetooth.service;
  sed -i 's/kgdboc=ttyAMA0/kgdboc=serial0/g' cmdline.txt || echo "Error replacing ttyAMAO with serial0 in /boot/cmdline.";
  sed -i 's/console=ttyAMA0/console=serial0/g' cmdline.txt || echo "Error replacing ttyAMAO with serial0 in /boot/cmdline.";

  echo "Step 3, repairing discord.";
  DIRECTORY=/usr/share/bin
  if [ ! -d "$DIRECTORY" ]; then
    sudo mkdir /usr/share/bin
  elif [ -d "$DIRECTORY" ]; then
    sudo mv /usr/bin/discord /usr/share/bin/ || echo "Discord is installed in the correct location or is missing.";
  else
    echo "Discord patch skipped due to errors."
  fi

  FILE=Desktop/updater.desktop
  if [ ! -f "$FILE" ]; then
   cp /usr/share/applications/updater.desktop Desktop/ || echo "Error creating mfjupdater shortcut on desktop, maybe it already exists.";
  fi
  
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
   sleep 25;
   exit 1;;

           [Nn]* ) exit;;
           * ) echo "Please answer yes or no.";;
       esac
   done

}


while :
  do


	echo "   __     __)            __     __)                     
  (, /|  /|    /)  ,    (, /   /        /)              
    / | / |   //          /   /  __   _(/ _  _/_  _  __ 
 ) /  |/  |_ /(_  /_...  /   /   /_)_(_(_(_(_(___(/_/ (_
(_/   '     /) .-/      (___(_.-/  Cli version / Beta                  
           (/ (_/            (_/ 
---------------------------------------------------------"
echo "1) Upgrade the system. "
echo "2) Clean unused packages and cache
   (useful to clean the trash left by the previous option)."


echo " __                                                 
|__)_ |_ _|_  _ _   _  _  _|   _  _| _| __  _  _  _ 
|  (_||_(_| )(-_)  (_|| )(_|  (_|(_|(_|    (_)| )_) 
---------------------------------------------------------       "
echo "a) Repair the most common problems."
echo "b) Reinstall tor-browser."
echo "c) Download wine apps and games."
echo "d) Pulseaudio/alsa(better sound) switcher."
echo ""
echo -n "[Type an option: 1,2,3,a,b,c,d,q(EXIT) and then press INTRO]=> "


read opcion
case $opcion in

1)
echo "";
read -p "Which branch do you want to use? [s(stable)/u(unstable)]=> " answer
if [ $answer = s ] || [ $answer = stable ]; then
  echo "Upgrading MFjaro using the stable branch";
  sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command can't be executed.";
  sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
  echo ;
  read -p "Clean unused packages and cache? (recomended to clean the trash left by the previous option). [y/n]=> " answer
  if [ $answer = y ] || [ $answer = Y ]; then
   echo  "Attention, please read the following warnings before proceeding:";
   sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);
  fi
  patch;
elif [ $answer = u ] || [ $answer = unstable ]; then
  echo "Upgrading MFjaro using the unstable branch";
  sudo pacman-mirrors -aS unstable || echo "You are already using the unstable branch or the command can't be executed.";
  sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
  echo ;
  read -p "Clean unused packages and cache? (recomended to clean the trash left by the previous option). [y/n]=> " answer
  if [ $answer = y ] || [ $answer = Y ]; then
   echo  "Attention, please read the following warnings before proceeding:";
   sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);
  fi
  patch;
else
  echo "Invalid option.";
fi
sleep 5;;

2)

echo "
Attention, please read the following warnings before proceeding:
" & sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);
sleep 5;;


a) 

patch;;


b) 

install-tor;
   sleep 5;;

c) 

sh download-update_wine_test_apps.sh;
echo "Open it from wine explorer. Wine explorer path: My Documents/wineapps.";
sleep 10;;

d) 
echo "";
read -p "Type (p) to use pulseaudio or (a) to use alsa=> " answer
if [ $answer = p ] || [ $answer = pulseaudio ]; then
  echo "Switching to pulseadio.";
  systemctl --user unmask pulseaudio.service || echo "Error unmasking pulseaudio.service, maybe it's already unmasked.";
  systemctl --user unmask pulseaudio.socket || echo "Error unmasking pulseaudio.socket, maybe it's already unmasked.";
elif [ $answer = a ] || [ $answer = alsa ]; then
  echo "Switching to alsa. The pulseadio equalizer will stop working.";
  systemctl --user mask pulseaudio.service || echo "Error masking pulseaudio.service, maybe it's already masked.";
  systemctl --user mask pulseaudio.socket || echo "Error masking pulseaudio.socket, maybe it's already masked.";
fi

sleep 5;;

q) 

echo "Done, closing. Not working properly? Fenix Linux/OS chat: https://discord.gg/dwAYC5QRDP.";
sleep 3; exit 1;;

*)

echo "$opc invalid option ";
echo "Press a key to continue.";
read foo;;

 esac
done
