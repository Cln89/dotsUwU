#!/bin/bash

# The following will attempt to install all needed packages to run Hyprland
# This is a quick and dirty script there are no error checking
# This script is meant to run on a clean fresh Arch install
#
# NOTE: Due to a bug I found with GPG I was unable to retrieve gpg Keys, to fix this add port 80 to the domain of your keyserver in your gpg config.
#
# Below is a list of the packages that would be installed
#
# blueman: Graphical bluetooth manager                                                                              | https://github.com/blueman-project/blueman
# bluez: the bluetooth service                                                                                      | http://www.bluez.org/
# bluez-utils: command line utilities to interact with bluetooth devices                                            | http://www.bluez.org/
# brightnessctl: used to control monitor and keyboard bright level                                                  | https://github.com/Hummer12007/brightnessctl
# btop: Resource monitor that shows usage and stats for processor, memory, disks, network and processes.            | https://github.com/aristocratos/btop
# hyprland: This is the Hyprland compositor                                                                         | https://github.com/hyprwm/Hyprland
# grim: This is a screenshot tool it grabs images from a Wayland compositor                                         | https://sr.ht/~emersion/grim/
# kitty: This is the default terminal                                                                               | https://github.com/kovidgoyal/kitty
# bat: This is a cat clone with syntax highlighting and Git integration for your terminal                           | https://github.com/sharkdp/bat
# starship: allows to customize the shell prompt                                                                    | https://starship.rs/, https://github.com/starship/starship
# waybar-hyprland: This is a fork of waybar with Hyprland workspace support                                         | https://github.com/Alexays/Waybar
# swww: This is used to set an animated desktop background image                                                    | https://github.com/Horus645/swww
# swaylock-effects: This allows for the locking of the desktop its a fork that adds some additional visual effects  | https://github.com/mortie/swaylock-effects
# wofi: This is an application launcher menu                                                                        | https://hg.sr.ht/~scoopta/wofi
# wlogout: This is a logout menu that allows for shutdown, reboot and sleep                                         | https://github.com/ArtsyMacaw/wlogout
# mako: This is a graphical notification daemon                                                                     | https://github.com/emersion/mako
# xdg-desktop-portal-hyprland: xdg-desktop-portal backend for hyprland                                          | https://github.com/hyprwm/xdg-desktop-portal-hyprland
# swappy: This is a screenshot editor tool                                                                          | https://github.com/jtheoof/swappy
# slurp: This helps with screenshots, it selects a region in a Wayland compositor                                   | https://github.com/emersion/slurp
# thunar: This is a graphical file manager                                                                          | https://gitlab.xfce.org/xfce/thunar
# polkit-gnome: needed to get superuser access on some graphical application                                        | https://gitlab.gnome.org/GNOME/polkit-gnome, https://archlinux.org/packages/community/x86_64/polkit-gnome/
# python-requests: needed for the weather module script to execute                                                  | https://requests.readthedocs.io/en/latest/
# pamixer: This helps with audio settings such as volume                                                            | https://github.com/cdemoulins/pamixer
# pavucontrol: GUI for managing audio and audio devices                                                             | https://freedesktop.org/software/pulseaudio/pavucontrol/, https://github.com/pulseaudio/pavucontrol
# network-manager-applet: Applet for managing network connection                                                    | https://gitlab.gnome.org/GNOME/network-manager-applet
# gvfs: adds missing functionality to thunar such as automount usb drives                                           | https://gitlab.gnome.org/GNOME/gvfs
# thunar-archive-plugin: Provides a front end for thunar to work with compressed files                              | https://docs.xfce.org/xfce/thunar/archive
# file-roller: Backend set of tools for working with compressed files                                               | https://gitlab.gnome.org/GNOME/file-roller
# pacman-contrib: adds additional tools for pacman. needed for showing system updates in the waybar                 | https://archlinux.org/packages/extra/x86_64/pacman-contrib/
# ttf-jetbrains-mono-nerd: Som nerd fonts for icons and overall look                                                | https://github.com/ryanoasis/nerd-fonts
# noto-fonts-emoji: fonts needed by the weather script in the top bar                                               | https://archlinux.org/packages/extra/any/noto-fonts-emoji/
# lxappearance: used to set GTK theme                                                                               | https://github.com/lxde/lxappearance
# xfce4-settings: set of tools for xfce, needed to set GTK theme                                                    | https://gitlab.xfce.org/xfce/xfce4-settings, https://docs.xfce.org/xfce/xfce4-settings/start
# sddm-git: developement version of SDDM which is a display manager for graphical login                             | https://github.com/sddm/sddm
# sddm-sugar-candy-git: an sddm theme my theme is based on (copy of)                                                | https://aur.archlinux.org/packages/sddm-sugar-candy-git

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
#CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

#clear the screen
clear

# set some expectations for the user
echo -e "$CNT - You are about to execute a script that would attempt to setup Hyprland.
Please note that Hyprland is still in Beta.
Please note that VMs are not fully supported and if you try to run this on
a Virtual Machine there is a high chance this will fail.
Please note that support for Nvidia GPUs is limited and may require
more work which is beyond the scope of this script.
\n"

sleep 3

read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    echo -e "$COK - Starting install script.."
else
    echo -e "$CNT - This script would now exit, no changes were made to your system."
    exit
fi


echo -e "\n
$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script."

sleep 3

#### Check for paru ####
ISPARU=/sbin/paru
if [ -f "$ISPARU" ]; then
    echo -e "$COK - paru was located, moving on."
else
    echo -e "$CWR - Paru was NOT located"
    read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install paru (y,n) ' INSTPARU
    if [[ $INSTPARU == "Y" || $INSTPARU == "y" ]]; then
        git clone https://aur.archlinux.org/paru-git.git &>> $INSTLOG
        cd paru-git || exit
        makepkg -si --noconfirm &>> ../$INSTLOG
        cd ..

    else
        echo -e "$CER - paru is required for this script, now exiting"
        exit
    fi
fi

### Disable wifi powersave mode ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to disable WiFi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC."
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>> $INSTLOG
    echo -e "\n"
    echo -e "$CNT - Restarting NetworkManager service..."
    sleep 1
    sudo systemctl restart NetworkManager &>> $INSTLOG
    sleep 3
fi

### Install all of the above pacakges ####
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # update the DB first
    echo -e "$COK - Updating paru database..."
    paru -Suy --noconfirm &>> $INSTLOG

    #Stage 0 - gpg error hotfix
    echo -e "\n$CNT - Stage 0 - Hot-fixing GPG key import error..."
    sudo cp ../.hotfixes/gpg.conf ~/.gnupg/gpg.conf

    #Stage 1
    echo -e "\n$CNT - Stage 1 - Installing main components, this may take a while..."
    for SOFTWR in hyprland tlp tlp-rdw hyprlock-git hypridle-git hyprpaper-git kitty waybar swww wofi wlogout mako xdg-desktop-portal-hyprland swappy grim slurp thunar
    do
        #First lets see if the package is there
        if paru -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            paru -S --noconfirm $SOFTWR &>> $INSTLOG
            if paru -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    #Stage 2
    echo -e "\n$CNT - Stage 2 - Installing additional tools and utilities, this may take a while..."
    for SOFTWR in polkit-gnome python-requests pamixer pavucontrol brightnessctl bluez bluez-utils bluez-cups \
                  blueman network-manager-applet gvfs thunar-archive-plugin udiskie file-roller btop \
                  pacman-contrib cava firefox flatpak hp-lip hyprpicker-git libreoffice-fresh playerctl
    do
        #First lets see if the package is there
        if paru -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            paru -S --noconfirm $SOFTWR &>> $INSTLOG
            if paru -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    #Stage 3
    echo -e "\n$CNT - Stage 3 - Installing theme and visual related tools and utilities, this may take a while..."
    for SOFTWR in bat starship ttf-jetbrains-mono-nerd noto-fonts-emoji lxappearance xfce4-settings sddm-git \
                  sddm-sugar-candy-git mupdf neovim noto-fonts pipewire print-manager tldr
    do
        #First lets see if the package is there
        if paru -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR is already installed."
        else
            echo -e "$CNT - Now installing $SOFTWR ..."
            paru -S --noconfirm $SOFTWR &>> $INSTLOG
            if paru -Qs $SOFTWR > /dev/null ; then
                echo -e "$COK - $SOFTWR was installed."
            else
                echo -e "$CER - $SOFTWR install had failed, please check the install.log"
                exit
            fi
        fi
    done

    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable --now bluetooth.service &>> $INSTLOG
    sleep 2

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 2

    # Clean out other portals
    echo -e "$CNT - Cleaning out conflicting xdg portals..."
    paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &>> $INSTLOG
fi

### Copy Config Files ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying config files..."
    for DIR in hypr kitty mako waybar wlogout wofi
    do
        DIRPATH=~/.config/$DIR
        if [ -d "$DIRPATH" ]; then
            echo -e "$CAT - Config for $DIR located, backing up."
            mv $DIRPATH $DIRPATH-back &>> $INSTLOG
            echo -e "$COK - Backed up $DIR to $DIRPATH-back."
        fi
        echo -e "$CNT - Copying $DIR config to $DIRPATH."
        cp -R $DIR ~/.config/ &>> $INSTLOG
    done

    # Set some files as executable
    echo -e "$CNT - Setting some file as executable."
    chmod +x ~/.config/hypr/scripts/bgaction
    chmod +x ~/.config/hypr/scripts/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
    chmod +x ~/.config/waybar/scripts/baraction
    chmod +x ~/.config/waybar/scripts/update-sys

    # Copy the SDDM theme
    echo -e "$CNT - Setting up the login screen."
    sudo cp -R sdt /usr/share/sddm/themes/
    sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
    sudo mkdir /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG
    WLDIR=/usr/share/wayland-sessions
    if [ -d "$WLDIR" ]; then
        echo -e "$COK - $WLDIR found"
    else
        echo -e "$CWR - $WLDIR NOT found, creating..."
        sudo mkdir $WLDIR
    fi
    sudo cp extras/hyprland.desktop /usr/share/wayland-sessions/
    sudo sudo sed -i "s/Exec=Hyprland/Exec=\/home\/'$USER'\/start-hypr/" /usr/share/wayland-sessions/hyprland.desktop
    cp extras/start-hypr ~/

    #setup the first look and feel as dark
    ln -sf ~/.config/waybar/style/style-dark.css ~/.config/waybar/style.css
    ln -sf ~/.config/wofi/style/style-dark.css ~/.config/wofi/style.css
    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Adwaita-dark"
    ln -sf /usr/share/sddm/themes/sdt/Backgrounds/wallpaper-dark.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
fi

### Install the starship shell ###
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to activate the starship shell? (y,n) ' STAR
if [[ $STAR == "Y" || $STAR == "y" ]]; then
    # install the starship shell
    echo -e "$CNT - Hansen Crusher, Engage!"
    echo -e "$CNT - Updating .bashrc..."
    echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
    echo -e "$CNT - copying starship config file to ~/.config ..."
    cp extras/starship.toml ~/.config/
fi

### Install software for Asus ROG laptops ###
#read -n1 -rep $'[\e[1;33mACTION\e[0m] - For ASUS ROG Laptops - Would you like to install Asus ROG software support? (y,n) ' ROG
#if [[ $ROG == "Y" || $ROG == "y" ]]; then
#    echo -e "$CNT - Adding Keys..."
#    sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
#    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
#    sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
#    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35 &>> $INSTLOG
#
#    LOC="/etc/pacman.conf"
#    echo -e "$CNT - Updating $LOC with g14 repo."
#    echo -e "\n[g14]\nServer = https://arch.asus-linux.org" | sudo tee -a $LOC &>> $INSTLOG
#    echo -e "\n"
#    echo -e "$CNT - Update the system..."
#    sudo pacman -Suy --noconfirm &>> $INSTLOG
#
#    echo -e "$CNT - Installing ROG packages..."
#    sudo pacman -S --noconfirm asusctl supergfxctl rog-control-center &>> $INSTLOG
#    echo -e "$CNT - Activating ROG services..."
#    sudo systemctl enable --now power-profiles-daemon.service &>> $INSTLOG
#    sleep 2
#    sudo systemctl enable --now supergfxd &>> $INSTLOG
#    sleep 2
#
#    #add the keybinding file to the config
#    echo -e "\nsource = ~/.config/hypr/rog-g15-strix-2021-binds.conf" >> ~/.config/hypr/hyprland.conf
#fi

### Script is done ###
echo -e "$CNT - Script had completed!"
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec sudo systemctl start sddm &>> $INSTLOG
else
    exit
fi