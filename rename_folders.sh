#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

if [ -d "otrsOPMS" ]; then

  	echo "${yellow}Rename from 'otrs' to 'otrsForked' folder"
	echo "${yellow}======================================================================="
	sudo mv otrs otrsForked

	echo "${yellow}Rename from 'otrsOPMS' to 'otrs' folder"
	echo "${yellow}======================================================================="
	sudo mv otrsOPMS otrs
	echo -e "\\n${green}OPMS OTRS is active\\n"

elif [ -d "otrsForked" ]; then
	
	# rename from otrs to otrsOPMS folder
	echo "${yellow}Rename from 'otrs' to 'otrsOPMS' folder"
	echo "${yellow}======================================================================="
	sudo mv otrs otrsOPMS

	# rename from otrsForked to otrs folder
	echo "${yellow}Rename from 'otrsForked' to 'otrs' folder"
	echo "${yellow}======================================================================="
	sudo mv otrsForked otrs
	echo -e "\\n${green}Forked OTRS is active\\n"

fi