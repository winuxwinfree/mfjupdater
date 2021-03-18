#!/bin/bash
#AUTHOR: androrama, fenixlinux.com
#License GPLV3
#Script inspired by Fenix Updater and Fenix Assistant 

clear
cd
rm -f updater.sh*

#MFjaro patch function.

patch () {
  echo 
  echo "Apply this patch if you have any of the following problems:"
  echo "1: Crackling, popping, and other sound problems."
  echo "   (After this the equalizer and pulse-audio options will not work)."
  echo "2: Bluetooth service does't work."
  echo "3: Discord does't work."
  echo "4: The start-up sound doesn't work."
  echo 
  echo "In addition, it will do the following:"
  echo "1: Install raspi-config."
  echo "2: Replace Pantheon-screenshot by Gnome-screenshot."
  echo "3: Ask if you want to add more software."
  echo 

  while true; do
    read -p "Run this patch? [y/n]: " yn
  case $yn in
    [Yy]* ) 


  echo ""
  
  #alsa audio fix
  
  echo "Step 1, installing alsa."
  
  if (systemctl -q is-active pulseaudio.service)
    then
    
  read -p " Alsa sound is better, but pulseaudio equalizer will not work, continue? (y/n)]=> " answer 
  if [ $answer = y ] || [ $answer = Y ]; then
    pkill pulseaudio || echo "Error killing pulseaudio, maybe it's killed."
    systemctl --user mask pulseaudio.service || echo "Error masking pulseaudio.service, maybe it's already masked."
    systemctl --user mask pulseaudio.socket || echo "Error masking pulseaudio.socket, maybe it's already masked."
    sudo pacman -S alsa-utils || echo "Error installing alsa-utils."
    sudo pacman -S qastools || echo "Error installing qastools."
  FILE=$HOME/Desktop/qasmixer.desktop
   if [ ! -f "$FILE" ]; then
    cp /usr/share/applications/qasmixer.desktop $HOME/Desktop/ || echo "Error creating qasmixer shortcut on desktop"
     echo " 
                        ";
   echo "If you switched pulse to alsa follow the steps below to configure it correctly:
   1. Right click on the volume icon.
   2. Go to volume control settings.
   3. Where it says -Command to open the mixer- type -alsamixer-. 
      (you can also use this command in a terminal). 
   Now you can open the advanced sound control settings 
   by clicking on -Launch Mixer-.
   4.
       ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ 
    ||R |||e |||b |||o |||o |||t |||       |||t |||h |||e ||
    ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__||
    |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|
     ____ ____ ____ ____ ____ ____ 
    ||s |||y |||s |||t |||e |||m ||
    ||__|||__|||__|||__|||__|||__||
    |/__\|/__\|/__\|/__\|/__\|/__\|

   With raspi-config you can change the audio output from hdmi to jack and viceversa.
   "
   fi
   else
    echo "Unable to install alsa."
  fi
  
 else
    echo "Nothing to do."
 fi
  
  #bluetooth fix
  
  echo "Step 2, repairing bluetooth problem."
  
  STRING="kgdboc=serial0"
  FILE="/boot/cmdline.txt"
  
  if grep -qF "$STRING" "$FILE";then
   echo "Nothing to do."
  else
   sudo systemctl unmask attach-bluetooth.service;
   sudo systemctl start attach-bluetooth.service;
   sudo sed -i 's/kgdboc=ttyAMA0/kgdboc=serial0/g' /boot/cmdline.txt || echo "Error replacing ttyAMAO with serial0 in /boot/cmdline."
   sudo sed -i 's/console=ttyAMA0/console=serial0/g' /boot/cmdline.txt || echo "Error replacing ttyAMAO with serial0 in /boot/cmdline."
   echo "Done." 
  fi
  
  #discord fix
  
  echo "Step 3, repairing discord.";
  DIRECTORY=/usr/share/bin
  FILE=/usr/bin/discord
  if [ ! -d "$DIRECTORY" ]; then
    sudo mkdir /usr/share/bin
  elif [[ -d "$DIRECTORY" && -f "$FILE" ]]; then 
    sudo mv /usr/bin/discord /usr/share/bin/ || echo "Error installing Discord."
    echo "Done."
  else
    echo "Nothing to do."
  fi

  FILE=$HOME/Desktop/updater.desktop
  if [ ! -f "$FILE" ]; then
   cp /usr/share/applications/updater.desktop $HOME/Desktop/ || echo "Error creating mfjupdater shortcut on desktop, maybe it already exists.";
  fi
  
  
  #xp alsa boot sound fix
  
  echo "Step 4, repairing the start-up sound.";
  
  echo "@cvlc --play-and-exit /home/pi/xp.ogg" >> $HOME/.config/lxsession/LXDE/autostart 
  
  echo "Done."
  
  #install raspi-config
    
  echo "Step 5, installing raspi-config.";
  
  FILE=/usr/bin/raspi-config
  if [ ! -f "$FILE" ]; then
  
  rm ~/.local/share/applications/raspi-config.desktop
  
  wget https://sourceforge.net/projects/fenixlinux/files/repo/archlinux/pi/raspi-config-git.pkg.tar.zst
  
  sudo pacman -U raspi-config-git.pkg.tar.zst 
  
  echo "[Desktop Entry]
  Type=Application
  Name=Raspi-config
  GenericName=Raspi-config
  Comment=Raspi-config port for archlinux and MfJaro
  Categories=System;
  Exec=lxterminal -e sudo raspi-config
  Icon=/usr/share/icons/hicolor/128x128/apps/rpi-imager.png
  StartupWMClass=Tor Browser" > ~/.local/share/applications/raspi-config.desktop
  
  echo "Done.";
  
  else
    echo "Nothing to do."
  fi

  #Replace Pantheon-screenshot by Gnome-screenshot.
  
  echo "Step 6, replacing Pantheon-screenshot by Gnome-screenshot.";
  
  FILE=/var/lib/pacman/local/pantheon-screenshot*
  if [ -f "$FILE" ]; then
  read -p "Replace Pantheon-screenshot by Gnome-screenshot? (y/n)]=> " answer 
 
   if [ $answer = y ] || [ $answer = Y ]; then
      sudo pacman -R pantheon-screenshot
      sudo pacman -S gnome-screenshot
   fi
  else
    echo "Nothing to do."
  fi
  
  sleep 5;
   
  echo
  read -p "Run the Add-On Wizard? [y/n]=> " answer
  if [ $answer = y ] || [ $answer = Y ]; then
   addapps;
  fi
  
  sleep 5;
  
   exit 1;;

           [Nn]* ) exit;;
           * ) echo "Please answer yes or no.";;
       esac
   done

}

 #Install Tor-Browser function / Thanks to botspot.

 tor () {

 cd
 DIRECTORY="$(dirname "$(dirname "$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )")")"

 function error {
   echo -e "\\e[91m$1\\e[39m"
   exit 1
 }

 rm -r ~/tor-browser_en-US 
 rm ~/tor.tar.xz
 rm ~/.local/share/applications/tor.desktop

 wget https://sourceforge.net/projects/tor-browser-ports/files/10.0.11-arm64/tor-browser-linux-arm64-10.0.11_en-US.tar.xz/download -O tor.tar.xz || error "Failed to download!"

 tar -xf ~/tor.tar.xz || error "Failed to extract!"

 echo "[Desktop Entry]
 Type=Application
 Name=Tor Browser
 GenericName=Web Browser
 Comment=Tor Browser is +1 for privacy and −1 for mass surveillance
 Categories=Network;WebBrowser;Security;
 Exec=$HOME/tor-browser_en-US/Browser/start-tor-browser
 X-TorBrowser-ExecShell=./Browser/start-tor-browser --detach
 Icon=/usr/share/icons/tor.png
 StartupWMClass=Tor Browser" > ~/.local/share/applications/tor.desktop

 rm $HOME/.local/share/applications/torinstall.desktop

 echo Done
 sleep 10

}

#Download wine apps and games function.

wineapps () {

if [ -d "./wineapps" ] 
then
    cd wineapps
    git pull
else
    git clone https://github.com/winuxwinfree/wineapps
    
fi
echo "Open it from wine explorer. Wine explorer path: My Documents/wineapps."
sleep 10
}

#Pulseaudio/alsa(better sound) switcher function.

audiofix () {

echo "";
read -p "Type (p) to use pulseaudio or (a) to use alsa=> " answer
if [ $answer = p ] || [ $answer = pulseaudio ]; then
  echo "Switching to pulseadio."
  systemctl --user unmask pulseaudio.service || echo "Error unmasking pulseaudio.service, maybe it's already unmasked."
  systemctl --user unmask pulseaudio.socket || echo "Error unmasking pulseaudio.socket, maybe it's already unmasked."
  echo "Done, you can close this window."
  echo "Reboot the system to apply the changes."
  sleep 20
elif [ $answer = a ] || [ $answer = alsa ]; then
  echo "Switching to alsa. The pulseadio equalizer will stop working."
  pkill pulseaudio
  systemctl --user mask pulseaudio.service || echo "Error masking pulseaudio.service, maybe it's already masked."
  systemctl --user mask pulseaudio.socket || echo "Error masking pulseaudio.socket, maybe it's already masked."
  echo -e "If you switched pulse to alsa follow the steps below to configure it correctly: \n 1. Reboot. \n 2. Right click on the volume icon. \n 3. Go to volume control settings. \n 4. Where it says -Command to open the mixer- type -alsamixer-. \n (you can also use this command in a terminal). \n Now you can open the advanced sound control settings \n by clicking on -Launch Mixer-."
  echo "Done, you can close this window."
  sleep 999
fi

}

#Add software function.

addapps () {
echo
if [ ! -f /usr/bin/anbox ]; then
  echo "Install anbox (Android In a Box)?"
  echo -e "\nAnbox may reduce system performance. \nYou can uninstall it by running this wizard again.\n"
  read -p "Continue? (y/n)]=> " answer 
if [ $answer = y ] || [ $answer = Y ]; then
  sudo pacman -S anbox-image-aarch64 || echo "Error installing anbox."
fi
else
  read -p "Uninstall anbox? (y/n)]=> " answer 
if [ $answer = y ] || [ $answer = Y ]; then
  sudo pacman -R anbox-image-aarch64
  sudo pacman -R anbox
fi
fi
}

#Fenix Updater -cli version- main menu.

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
echo "2) Clean unused packages and cache."


echo " __                                                 
|__)_ |_ _|_  _ _   _  _  _|   _  _| _| __  _  _  _ 
|  (_||_(_| )(-_)  (_|| )(_|  (_|(_|(_|    (_)| )_) 
---------------------------------------------------------       "
echo "a) Repair the most common problems."
echo "b) Reinstall tor-browser."
echo "c) Download wine apps and games."
echo "d) Pulseaudio/alsa(better sound) switcher."
echo "e) Add-ons."
echo ""
echo -n "[Type an option: 1,2,a,b,c,d,e and then press INTRO]=> "


read opcion
case $opcion in

1)

echo "";

read -p "Which branch do you want to use? [s(stable)/u(unstable)]=> " answer
#stable
if [ $answer = s ] || [ $answer = stable ]; then
  echo "Upgrading MFjaro using the stable branch";
  sudo pacman-mirrors -aS stable || echo "You are already using the stable branch or the command can't be executed.";
  sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
  echo;
  sleep 5;
  
  patch;
  
  echo;
  read -p "Clean unused packages and cache? (recommended to free up space after upgrade). [y/n]=> " answer
  if [ $answer = y ] || [ $answer = Y ]; then
   echo  "Attention, please read the following warnings before proceeding:";
   sudo pacman -Scc && paccache -r && sudo pacman -Rns $(pacman -Qtdq);
  fi
 #unstable
 elif [ $answer = u ] || [ $answer = unstable ]; then
  echo "Upgrading MFjaro using the unstable branch";
  sudo pacman-mirrors -aS unstable || echo "You are already using the unstable branch or the command can't be executed.";
  sudo pacman -Syyu  || echo "sudo pacman -Syyu - Error";
  echo;
  sleep 5;
  
  patch;
  
  echo;
  read -p "Clean unused packages and cache? (recommended to free up space after upgrade.). [y/n]=> " answer
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

tor;;

c) 

wineapps;;

d)

audiofix;;

e)

addapps;;

q) 

echo "Done, closing. Not working properly? Fenix Linux/OS chat: https://discord.gg/dwAYC5QRDP.";
sleep 3; exit 1;;

*)

echo "$opc invalid option ";
echo "Press a key to continue.";
read foo;;

 esac
done
