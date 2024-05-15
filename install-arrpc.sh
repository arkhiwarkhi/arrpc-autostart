#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run this script with sudo, doas."
	exit 1
fi

chmod +x start_arrpc.sh
chmod +x start_arrpc.desktop

node --version
node_installed=$?
if [ $node_installed -eq 0 ];
  echo ""
else
  echo "Node is not installed on this system, exiting."
  exit 1
fi

npm --version
npm_installed=$?
if [ $npm_installed -eq 0 ]; then
  echo ""
else
  echo "npm is not installed on this system, exiting."
  exit 1
fi

git clone https://github.com/OpenAsar/arrpc

git_cloned=$?

if [ $git_cloned -eq 0 ]; then
  echo ""
else
  echo "Git clone failed, exiting. Do you have git installed?"
  exit 1
fi

cd arrpc
changed_dir=$?

if [ $changed_dir -eq 0 ]; then
  echo ""
else
  echo "Changing directory failed, exiting."
  exit 1
fi

npm install
installed_arrpc=$?

if [ $installed_arrpc -eq 0 ]; then
  echo ""
else
  echo "Installing arrpc failed, exiting."
  exit 1
fi

mv start_arrpc.desktop $HOME/.config/autostart/
moved_desktop_entry=$?

if [ $moved_desktop_entry -eq 0 ]; then
  echo "Successfully installed! Now you need to enable in your settings for Armcord or enable the RPC plugin on Vencord/Vesktop."
else
  echo "Could not move the desktop entry to .config/autostart. $HOME may not be set. Exiting."
  exit 1
fi
