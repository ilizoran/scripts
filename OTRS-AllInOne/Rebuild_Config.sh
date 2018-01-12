#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

FrameworkRoot=${PWD}
OTRS4=0

echo -e "\n"
echo -e "${yellow}Switch Fred version"
echo -e "${yellow}======================================================================="
echo -e "${green}"

# Call different rebuild config scripts based on OTRS version.
if [[ $FrameworkRoot == "/opt/otrs4"* ]]
	then cd /opt/Fred/
		 git checkout rel-4_0
		 cd $FrameworkRoot

 		 echo -e "${yellow}\\n"
		 echo "${yellow}Rebuilding config:"
		 echo "${yellow}======================================================================="
		 echo -e "\n"
		 perl bin/otrs.RebuildConfig.pl

		 OTRS4=1

elif [[ $FrameworkRoot == "/opt/otrs5"* ]]
	then cd /opt/Fred/
		 git checkout master
		 cd $FrameworkRoot

		 echo -e "${yellow}\\n"
		 echo "${yellow}Rebuilding config:"
		 echo "${yellow}======================================================================="
		 echo -e "\n"
		 perl bin/otrs.Console.pl Maint::Config::Rebuild

elif [[ $FrameworkRoot == "/opt/otrs6"* ]]
	then cd /opt/Fred/
		 git checkout master
		 cd $FrameworkRoot

 		 echo -e "${yellow}\\n"
		 echo "${yellow}Rebuilding config:"
		 echo "${yellow}======================================================================="
		 echo -e "\n"
		 perl bin/otrs.Console.pl Maint::Config::Rebuild --cleanup

		 # echo -e "\n"
		 # perl bin/otrs.Console.pl Dev::Tools::Migrate::ConfigXMLStructure --source-directory ${PWD}/Kernel/Config/Files/
		 
elif [[ $FrameworkRoot == "/opt/otrs7"* ]]
	then cd /opt/Fred/
		 git checkout master
		 cd $FrameworkRoot

 		 echo -e "${yellow}\\n"
		 echo "${yellow}Rebuilding config:"
		 echo "${yellow}======================================================================="
		 echo -e "\n"
		 perl bin/otrs.Console.pl Maint::Config::Rebuild --cleanup

		 # echo -e "\n"
		 # perl bin/otrs.Console.pl Dev::Tools::Migrate::ConfigXMLStructure --source-directory ${PWD}/Kernel/Config/Files/
fi

if [[ $OTRS4 == "0" ]]
	then echo -e "\\n${yellow}Deletes cache files created by OTRS:"
		 echo -e "${green}"
		 perl bin/otrs.Console.pl Maint::Cache::Delete

  		 echo -e "\\n${yellow}Cleanup the CSS/JS loader cache:"
		 echo -e "${green}"
		 perl bin/otrs.Console.pl Maint::Loader::CacheCleanup
else 
		 echo -e "\\n${yellow}Deletes cache files created by OTRS:"
		 echo -e "${green}"
		 perl bin/otrs.DeleteCache.pl

  		 echo -e "\\n${yellow}Cleanup the CSS/JS loader cache:"
		 echo -e "${green}"
		 perl bin/otrs.LoaderCache.pl -o delete
fi

# Restart apache.
if [[ $FrameworkRoot != "/opt/otrs7-mojo"* ]]
	then echo -e "\\n${yellow}Restart apache:"
	echo -e "${green}"
	sudo service apache2 restart

	echo -e "\\n${yellow}======================================================================="
	echo -e "${reset}\\n"

fi


