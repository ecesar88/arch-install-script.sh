#!/bin/bash
echo "#############################################"
echo "Arch Linux Automated Dotfiles Install Script"
echo "#############################################"

# Make all the main home user folders
echo
echo "Creating basic folders in $HOME"
echo
mkdir -vp $HOME/Desktop
mkdir -vp $HOME/Documents
mkdir -vp $HOME/Downloads
mkdir -vp $HOME/Downloads/_cloned-repos
mkdir -vp $HOME/Music
mkdir -vp $HOME/Pictures
mkdir -vp $HOME/Screenshots
mkdir -vp $HOME/Templates
mkdir -vp $HOME/Videos
mkdir -vp $HOME/_my-scripts
mkdir -vp $HOME/_my-sources
echo
echo "Done"
echo

# Full system upgrade
echo
echo "Full system upgrade"
echo
sudo pacman -Syyu

# Pacman Packages to install first
echo
echo "Installing All Pacman Packages"
echo
sudo pacman -S linux-lts linux-lts-headers xorg-server xorg-xinit xorg-xrandr xorg-xprop xorg-xvinfo xorg-xset networkmanager wget p7zip unzip unrar tar tree feh scrot hwinfo polkit-gnome gnome-keyring simplescreenrecorder ntfs-3g i3-gaps dmenu rofi dunst compton wmctrl git alsa-utils playerctl pulseaudio pulseaudio-alsa pavucontrol paprefs mpd ncmpcpp libmpdclient mplayer vlc clementine a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore python2-pip python-pip arandr ttf-font-awesome ttf-dejavu bdf-unifont powerline-fonts ttf-ubuntu-font-family noto-fonts ttf-roboto ttf-droid ttf-fira-mono ttf-inconsolata gucharmap termite rxvt-unicode rxvt-unicode-terminfo zsh zsh-completions zsh-autosuggestions zsh-history-substring-search tmux fzf aria2 qbittorrent qbittorrent-nox transmission-gtk ranger file-roller atool elinks ffmpegthumbnailer highlight libcaca lynx mediainfo odt2txt perl-image-exiftool poppler python-chardet transmission-cli w3m thunar tumbler thunar-volman thunar-archive-plugin thunar-media-tags-plugin gvfs numlockx htop gtop maim libqalculate unclutter conky bleachbit lxappearance gnome-disk-utility gnome-system-monitor viewnior flameshot mpv net-tools xautolock  mousepad xfce4-appfinder npm pulseaudio-equalizer pulseaudio-equalizer-ladspa pulseeffects speedtest-cli kdenlive clang xclip frei0r-plugins clang-tools-extra iw sxiv zathura zathura-pdf-mupdf tomboy inkscape krita gimp gparted xorg-xkill


# yay
echo
echo "Installing yay"
echo
cd $HOME/Downloads/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syyu
echo
echo "Done"
echo

# AUR
echo
echo "Enabling AUR..."
echo
cd /etc/
sudo rm -f ./pacman.conf
sudo wget https://raw.githubusercontent.com/zSucrilhos/arch-install-script.sh/master/pacman.conf
sudo pacman -Syy
echo
echo "Done"
echo

# Istalling AUR packages
echo
echo "AUR Packages"
echo
yay -S mps-youtube cava nerd-fonts-hack terminus-font-ttf ttf-unifont siji-git ttf-ms-fonts ttf-tahoma ttf-iosevka ttf-vista-fonts ttf-fixedsys-excelsior-linux ttf-material-icons pamac-aur gksu i3-scrot xkill spacefm oh-my-tmux oh-my-zsh vimplug lightscreen

echo
echo "Disable PC Speaker:"
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo 
echo "Disable webcam:"
echo "blacklist uvcvideo" > /etc/modprobe.d/blacklist.conf
echo
echo "Done"
echo

echo
echo "Changing shell to ZSH and installing oh-my-zsh and oh-my-tmux"
echo
chsh -s /bin/zsh
echo "Done"

echo
echo "oh-my-zsh"
echo
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo
echo "oh-my-tmux"
echo

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

echo
echo "Done"
echo

echo "######################################################################"
echo "######################## NOW, THE DOTFILES ###########################"
echo "######################################################################"

cd $HOME/Downloads/_cloned-repos
git clone https://github.com/zSucrilhos/dotfiles
cd dotfiles/Desktop

cp -r ./.config $HOME
cp -r ./.mpd $HOME
cp -r ./.ncmpcpp $HOME

cp ./.Xresources $HOME
cp ./.conkyrc $HOME

rm $HOME/.tmux.conf.local
cp ./.tmux.conf.local

cp ./.xinitrc $HOME
cp ./.zshrc $HOME

cd $HOME/_my-scripts
cp -r $HOME/Downloads/_cloned-repos/dotfiles/Desktop/scripts/*.* $HOME/_my-scripts/

echo
echo "Installing ZSH Plugins and themes"
echo
echo "Alias-tips plugin"
echo
cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins
git clone https://github.com/djui/alias-tips.git
echo
echo "K plugin"
git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k
echo
echo "Punctual theme"
echo
cd ..
cd themes
https://raw.githubusercontent.com/zSucrilhos/punctual-zsh-theme/master/punctual.zsh-theme
echo
echo "Done"
echo "##################################################"
echo "########### Full System upgrade ##################"
echo "##################################################"
source $HOME/.zshrc
sudo pacman -Syyu
yay -Syyu

echo
echo
echo
echo
echo "##################################################"
echo "############## FINISHED ##########################"
echo "##################################################"



