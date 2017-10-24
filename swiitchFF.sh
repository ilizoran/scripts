#!/bin/bash
if [ $1 == "56" ]; then
	sudo mv /usr/bin/firefox /usr/bin/firefoxold
	sudo ln -s /opt/firefox56/firefox /usr/bin/firefox
else
	sudo mv /usr/bin/firefox /usr/bin/firefoxold
    sudo ln -s /opt/firefox45/firefox /usr/bin/firefox
fi


