#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

FrameworkRoot=${PWD}
OTRS4=0
Branch=$(git rev-parse --abbrev-ref HEAD)

echo -e "\n"
echo -e "${yellow}Switch Fred version"
echo -e "${yellow}======================================================================="
echo -e "${green}"

# Call different rebuild config scripts based on OTRS version.
if [[ $Branch == "rel-4_0" ]] 
	then
	cd /opt/Fred/
	git checkout rel-4_0
	cd $FrameworkRoot

	echo -e "${yellow}\\n"
	echo "${yellow}Rebuilding config:"
	echo "${yellow}======================================================================="
	echo -e "\n"
	perl bin/otrs.RebuildConfig.pl

	echo -e "\\n${yellow}Deletes cache files created by OTRS:"
	echo -e "${green}"
	perl bin/otrs.DeleteCache.pl

	echo -e "\\n${yellow}Cleanup the CSS/JS loader cache:"
	echo -e "${green}"
	perl bin/otrs.LoaderCache.pl -o delete
else
	cd /opt/Fred/
	git checkout master
	cd $FrameworkRoot

	echo -e "${yellow}\\n"
	echo "${yellow}Rebuilding config:"
	echo "${yellow}======================================================================="
	echo -e "\n"
	perl bin/otrs.Console.pl Maint::Config::Rebuild

	echo -e "\\n${yellow}Deletes cache files created by OTRS:"
	echo -e "${green}"
	perl bin/otrs.Console.pl Maint::Cache::Delete

	echo -e "\\n${yellow}Cleanup the CSS/JS loader cache:"
	echo -e "${green}"
	perl bin/otrs.Console.pl Maint::Loader::CacheCleanup
fi

# Restart apache.
if [[ $Branch != "master-internal"* ]]
	then echo -e "\\n${yellow}Restart apache:"
	echo -e "${green}"
	sudo service apache2 restart

	echo -e "\\n${yellow}======================================================================="
	echo -e "${reset}\\n"

fi
