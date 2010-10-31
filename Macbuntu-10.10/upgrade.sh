#!/bin/bash

# Macbuntu - Mac OS X Transformation Pack
# Author: lookout, elmigueluno
# Send feedback to lookout@losoft.org, elmigueluno@gmail.com
# Homepage: http://www.losoft.org/macbuntu/
# 
# Copyright (c) 2010 Jan Komadowski
# 
# This program is free software. Feel free to redistribute and/or
# modify it under the terms of the GNU General Public License v3
# as published by the Free Software Foundation.
# This program is distributed in the hope that it will be useful
# but comes WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# 
# See the GNU General Public License for more details.

UBUVER="10.10"
OLDUBUVER="Maverick"
UBUNTU="Ubuntu $UBUVER"

MACBUNTU="Macbuntu-$UBUVER"
VERSION="2.3"
OLDVERSION="2.3"
UPGRADE="$OLDUBUVER-$OLDVERSION"

MACBUNTUHOME="$HOME/.macbuntu"

CURRENT="$MACBUNTUHOME/$UBUVER-$VERSION"
BACKUP="$MACBUNTUHOME/backup"
BACKUPDIR="$BACKUP/$(date +%Y-%m-%d-%H:%M)"
BACKUPCURRENT="$BACKUP/current"

COMPIZPID=$(ps -o pid= -C compiz)
DOCKYPID=$(ps -o pid= -C docky)

RESOLUTION=$(xdpyinfo | grep -i dimensions: | sed 's/[^0-9]*pixels.*(.*).*//' | sed 's/[^0-9x]*//')
VRES=$(echo $RESOLUTION | sed 's/.*x//')
HRES=$(echo $RESOLUTION | sed 's/x.*//')

ARCH=$(uname -m)
ARCHDIR=`[ "$ARCH" == "x86_64" ] && echo "x64" || echo "x32"`

force=$1
tester=0

chk_user()
{
	echo ""
	echo "Checkin script user..."
	if [ $(whoami) = "root" ]
	then
		echo "Failed."
		echo "Root user not allowed, please run this script as a regular user."
		echo "Exiting..."
		exit 1;
	fi
	echo "Passed"
}

chk_root()
{
	echo ""
	echo "Checkin for a root access..."
	s=`sudo cat /etc/issue`
	if [ -n "$s" ]; then
		return
	fi
	echo "Authorization failed."
	echo "Exiting..."
	exit 1;
}

chk_system()
{
	echo ""
	echo "Checking Ubuntu version..."
	s=`cat /etc/issue | grep -i "$UBUNTU"`
	if [ ! -n "$s" ]; then
		echo "Failed. System not supported, script will end here"
		echo "To ignore their compatibility with current OS try ./upgrade.sh force"
		echo "Exiting..."
		exit 1;
	fi
	echo "Passed"
}

chk_program()
{
	s=`dpkg --status $1 | grep -q not-installed`
	if [ ! -n "$s" ]; then
		return 1
	fi
	return 0
}

chk_upgrade()
{
	echo ""
	echo "Checking currently installed version of $MACBUNTU..."
	d=$MACBUNTUHOME/current
	if [ -f "$d" ]; then
		s=`cat $MACBUNTUHOME/current | grep "$UBUVER-$VERSION"`
		if [ -n "$s" ]; then
			echo "You already have the latest versions. If you want to reinstall components or settings run install.sh"
			echo "Exiting..."
			exit 0;
		fi
		s=`cat $MACBUNTUHOME/current | grep "$UPGRADE"`
		if [ ! -n "$s" ]; then
			echo "Failed. Currently installed version is not compatible with this upgrade"
			echo "Exiting..."
			exit 1;
		fi
	else
		d=$MACBUNTUHOME/$UPGRADE
		if [ ! -d "$d" ]; then
			echo "Failed. The script is not able to determine what version is currently installed"
			echo "Exiting..."
			exit 1;
		fi
	fi
	echo "Passed"
}

# Changing current to script dir
cd -- "$(dirname -- "$0")"

echo ""
echo "Macbuntu - Mac OS X Transformation Pack"
echo "Upgrade from $OLDVERSION to version $VERSION"
echo ""
echo "Attention!"
echo "If you do not know what version you currently have installed or if you want"
echo "completely update components or settings abort (Control+C) the script and then run install.sh"

case "$force" in
	--force|force) ;;
	*) chk_system ;;
esac

chk_user
chk_upgrade

echo ""
echo "This script will upgrade $MACBUNTU to latest version now"
echo "You must have root privileges to be able to install listed components."
echo ""
echo "Attention!"
echo "Running scripts with root privileges is dangerous, if you do not trust the software"
echo "or you are unsure about the origin of this software, please abort (Control+C)."
echo "Macbuntu guarantee the safe code only if the application comes from this address"
echo "https://sourceforge.net/projects/macbuntu/"
echo ""
echo "Do you want to continue [Y/n]?"
read ans
case "$ans" in
	n*|N*)
	echo "Installation aborted. Exiting..."
	exit 0;
esac

chk_root

if [ $tester == 0 ] ; then

echo ""
echo "Preparing backup..."
if [ ! -f "$CURRENT" ]; then
	mkdir -p "$CURRENT"
fi
if [ ! -f "$BACKUPDIR" ]; then
	mkdir -p "$BACKUPDIR"
fi
if [ ! -f "$BACKUPCURRENT" ]; then
	mkdir -p "$BACKUPCURRENT"
fi

rm -rf $CURRENT/*
rm -rf $BACKUPCURRENT/*

cp -r * $CURRENT

# Questions section

# Setup
echo "Setting up repository"
sudo cp -r tools/remove-apt-repository /usr/bin
sudo apt-get update

echo ""
echo "Installing backgrounds..."
d=~/.backgrounds/
if [ ! -d "$d" ]; then
	mkdir "$d"
fi

cp -r backgrounds/* ~/.backgrounds/
sudo cp -r backgrounds/* /usr/share/backgrounds/

echo "Installing cursors..."
d=~/.icons/
if [ ! -d "$d" ]; then
	mkdir "$d"
fi
rm -rf ~/.icons/$MACBUNTU-Cursors/
rm -rf ~/.icons/Macbuntu-Cursors/
sudo rm -rf /usr/share/icons/$MACBUNTU-Cursors/
sudo rm -rf /usr/share/icons/Macbuntu-Cursors/
cp -r cursors/Macbuntu-Cursors ~/.icons/Macbuntu-Cursors
sudo cp -r cursors/Macbuntu-Cursors /usr/share/icons/Macbuntu-Cursors

echo "Installing icons..."
rm -rf ~/.icons/$MACBUNTU-Icons/
rm -rf ~/.icons/Macbuntu-Icons/
sudo rm -rf /usr/share/icons/$MACBUNTU-Icons/
sudo rm -rf /usr/share/icons/Macbuntu-Icons/
cp -r icons/Macbuntu-Icons ~/.icons/
sudo rm -f /usr/share/icons/applelogo.tif
sudo rm -f /usr/share/icons/LoginIcons/apps/64/applelogo.tif
sudo cp -r icons/Macbuntu-Icons /usr/share/icons/
sudo cp -r icons/applelogo.png /usr/share/icons/
sudo cp -r icons/applelogo-black.svg /usr/share/icons/
sudo cp -r icons/applelogo.png /usr/share/icons/LoginIcons/apps/64/
sudo cp -r icons/applelogo-black.svg /usr/share/icons/LoginIcons/apps/64/

echo "Installing themes..."
d=~/.themes/
if [ ! -d "$d" ]; then
	mkdir "$d"
fi
rm -rf ~/.themes/$MACBUNTU/
rm -rf ~/.themes/Macbuntu/
sudo rm -rf /usr/share/themes/$MACBUNTU/
sudo rm -rf /usr/share/themes/Macbuntu/
cp -r themes/Macbuntu ~/.themes/Macbuntu
sudo cp -r themes/Macbuntu /usr/share/themes/Macbuntu

echo "Installing new logo..."
case $dlogo in
	1*)
	cp -rf distributor-logo/mac-small/* ~/.icons/Macbuntu-Icons/places/scalable/
	sudo cp -rf distributor-logo/mac-small/* /usr/share/icons/Macbuntu-Icons/places/scalable/
	;;
	3*)
	cp -rf distributor-logo/mac-big/* ~/.icons/Macbuntu-Icons/places/scalable/
	sudo cp -rf distributor-logo/mac-big/* /usr/share/icons/Macbuntu-Icons/places/scalable/
	;;
	4*)
	cp -rf distributor-logo/ubuntu/* ~/.icons/Macbuntu-Icons/places/scalable/
	sudo cp -rf distributor-logo/ubuntu/* /usr/share/icons/Macbuntu-Icons/places/scalable/
	;;
	5*)
	cp -rf distributor-logo/gnome/* ~/.icons/Macbuntu-Icons/places/scalable/
	sudo cp -rf distributor-logo/gnome/* /usr/share/icons/Macbuntu-Icons/places/scalable/
	;;
	*)
	cp -rf distributor-logo/mac-middle/* ~/.icons/Macbuntu-Icons/places/scalable/
	sudo cp -rf distributor-logo/mac-middle/* /usr/share/icons/Macbuntu-Icons/places/scalable/
	;;
esac

# Backuping
echo "Backuping..."
mkdir -p $BACKUPDIR/sounds
sudo cp -rf /usr/share/sounds/purple $BACKUPDIR/sounds/
mkdir -p $BACKUPCURRENT/sounds
cp -rf $BACKUPDIR/sounds/* $BACKUPCURRENT/sounds/

# Sound theme
echo "Installing Sound theme..."
sudo cp -rf sounds/macbuntu /usr/share/sounds/
sudo cp -rf sounds/purple /usr/share/sounds/

if [ ! -z $DOCKYPID ]; then
	killall docky
fi

# Backuping
echo "Backuping..."
mkdir -p $BACKUPDIR/docky
gconftool-2 --dump /apps/docky-2 > $BACKUPDIR/docky/docky.entries
mkdir -p $BACKUPCURRENT/docky
cp $BACKUPDIR/docky/* $BACKUPCURRENT/docky/

echo ""
echo "Setting up Docky..."
gconftool-2 --set /apps/docky-2/Docky/Services/ThemeService/Theme --type string "Glass"
gconftool-2 --set /apps/docky-2/Docky/Services/ThemeService/UrgentHue --type int 150
gconftool-2 --set /apps/docky-2/Docky/DockController/Theme --type string "Glass"
gconftool-2 --set /apps/docky-2/Docky/DockController/UrgentHue --type int 150
gconftool-2 --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/IconSize --type int 48
gconftool-2 --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomPercent --type float 1.800

# Backuping
echo "Backuping..."
mkdir -p $BACKUPDIR/compiz
cp -f /usr/lib/compiz/libanimation.so $BACKUPDIR/compiz/
cp -f /usr/share/compiz/animation.xml $BACKUPDIR/compiz/
gconftool-2 --dump /apps/compiz > $BACKUPDIR/compiz/compiz.entries
mkdir -p $BACKUPCURRENT/compiz
cp $BACKUPDIR/compiz/* $BACKUPCURRENT/compiz/

echo "Setting up Compiz Fusion..."
gconftool-2 --set /apps/compiz/general/allscreens/options/cursor_theme --type string "Macbuntu-Cursors"
gconftool-2 --set /apps/compiz/plugins/cube/screen0/options/skydome_image --type string "/usr/share/backgrounds/leopard-aurora.jpg"
# Animation
# Minimize a window like OS-X
sudo cp -f compiz/$ARCHDIR/libanimation.so /usr/lib/compiz/
sudo cp -f compiz/$ARCHDIR/animation.xml /usr/share/compiz/
# Animation settings
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/close_durations --type list --list-type int "[100,500]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/close_effects --type list --list-type string "[animation:Fade,animation:Magic Lamp]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/close_matches --type list --list-type string "[(type=Menu | PopupMenu | Dialog | Normal | DropdownMenu),(type=ModalDialog)]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/minimize_durations --type list --list-type int "[500]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/minimize_effects --type list --list-type string "[animation:Magic Lamp]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/minimize_matches --type list --list-type string "[(type=Normal | Dialog | ModalDialog | Unknown)]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/open_durations --type list --list-type int "[100,500]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/open_effects --type list --list-type string "[animation:Fade,animation:Magic Lamp]"
gconftool-2 --set /apps/compiz/plugins/animation/screen0/options/open_matches --type list --list-type string "[(type=Menu | PopupMenu | Dialog | Normal | DropdownMenu),(type=ModalDialog)]"

# Backuping
echo "Backuping..."
mkdir -p $BACKUPDIR/panel
gconftool-2 --dump /apps/panel > $BACKUPDIR/panel/panel.entries
mkdir -p $BACKUPCURRENT/panel
cp $BACKUPDIR/panel/panel.entries $BACKUPCURRENT/panel/

echo "Setting up theme..."
# Panels
gconftool-2 --load panel/panel.entries
gconftool-2 --set /apps/panel/general/toplevel_id_list --type list --list-type string "[top_panel_screen0]"
gconftool-2 --set /apps/panel/toplevels/top_panel_screen0/background/type --type string "gtk"
# Backgrounds
gconftool-2 --set /desktop/gnome/background/picture_filename --type string "/usr/share/backgrounds/leopard-aurora.jpg"
# Gtk Theme
gconftool-2 --set /desktop/gnome/interface/gtk_theme --type string "Macbuntu"
gconftool-2 --set /apps/metacity/general/theme --type string "Macbuntu"
gconftool-2 --set /desktop/gnome/interface/icon_theme --type string "Macbuntu-Icons"
# Cursor
gconftool-2 --set /desktop/gnome/peripherals/mouse/cursor_theme --type string "Macbuntu-Cursors"
gconftool-2 --set /desktop/gnome/peripherals/mouse/cursor_size --type int 28
# Icons
gconftool-2 --set /desktop/gnome/interface/toolbar_style --type string "icons"
gconftool-2 --set /desktop/gnome/interface/buttons_have_icons --type boolean false
gconftool-2 --set /desktop/gnome/interface/menus_have_icons --type boolean true
# Compositing manager
gconftool-2 --set /apps/metacity/general/compositing_manager --type boolean true

echo "Setting up sound theme..."
gconftool-2 --set /desktop/gnome/sound/theme_name --type string "macbuntu"
gconftool-2 --set /desktop/gnome/sound/input_feedback_sounds --type boolean true
gconftool-2 --set /desktop/gnome/sound/event_sounds --type boolean true
gconftool-2 --set /desktop/gnome/sound/enable_esd --type boolean true

echo "Setting up login screen..."
# Login screen
# Backgrounds
sudo -u gdm gconftool-2 --set /desktop/gnome/background/picture_filename --type string "/usr/share/backgrounds/leopard-aurora.jpg"
# Gtk Theme
sudo -u gdm gconftool-2 --set /desktop/gnome/interface/icon_theme --type string "LoginIcons"
sudo -u gdm gconftool-2 --set /desktop/gnome/interface/gtk_theme --type string "Macbuntu"
sudo -u gdm gconftool-2 --set /apps/metacity/general/theme --type string "Macbuntu"
# Cursor
sudo -u gdm gconftool-2 --set /desktop/gnome/peripherals/mouse/cursor_size --type int 28
sudo -u gdm gconftool-2 --set /desktop/gnome/peripherals/mouse/cursor_theme --type string "Macbuntu-Cursors"
# Logo
sudo -u gdm gconftool-2 --set /apps/gdm/simple-greeter/logo_icon_name --type string "applelogo-black"
sudo rm -rf /usr/share/icons/LoginIcons/icon-theme.cache

# Sounds
sudo -u gdm gconftool-2 --set /desktop/gnome/sound/theme_name --type string "macbuntu"


# Reloading Gnome Panel
killall gnome-panel

# Starting Docky...
nohup docky > /dev/null &

# Reloading Compiz
if [ ! -z $COMPIZPID ]; then
	nohup compiz --replace > /dev/null &
fi

echo "Finishing installation..."
echo "$UBUVER-$VERSION" > $MACBUNTUHOME/current
OLD="$MACBUNTUHOME/$OLDUBUVER-$OLDVERSION"
rm -rf $OLD/
sleep 5

echo ""
echo "$MACBUNTU upgrade is completed! Have fun :)"

else # Tester

echo "Tester..."

fi # End Tester

