#!/bin/bash
green=`tput setaf 2`
reset=`tput sgr0`

OTRSArray=( otrs4-m otrs4-p otrs5-m otrs5-p otrs6-m otrs6-p otrs7-m otrs7-p )

for OTRS in "${OTRSArray[@]}"
do
	FrameworkRoot="/opt/$OTRS"
	if [[ -d $FrameworkRoot ]]
		then cd $FrameworkRoot
			 git pull
			 echo -e "${green}Directory $OTRS is up to date"
			 echo -e "${reset}"
			 git rp
			 echo -e "${green}Pruned origin $OTRS"
			 echo -e "${reset}"
	fi
done