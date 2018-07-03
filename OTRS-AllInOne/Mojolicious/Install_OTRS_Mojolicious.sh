#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

OTRS=$1
DBType=$2

# If DBType param is not available use Mysql as default.
if [[ ! $DBType ]]
	then DBType="Mysql"
fi

# Define needed script variables.
FrameworkRoot="/opt/$OTRS"
FredVersion="master"

cd ../module-tools/
git checkout master
cd /opt/$OTRS

if [[ $OTRS == *"otrs7"* ]]
	then OTRSName="OTRS 7 Mojolicious"
		 FrameworkVersion="master-internal"
fi

# If this is first installation of OTRS for this version with this script copy content from the original folder.
if [[ ! -d $FrameworkRoot ]]
	then echo -e "\n${yellow}Preparing $OTRSName $DBType"
		 echo -e "${yellow}======================================================================="
		 echo -e "${green}"
		 echo -e "Copying OTRS original content to $OTRSName new folder please wait..." 

		 sudo cp -a /opt/otrs/. $FrameworkRoot
		 echo -e "Done"

		 # Go to new framework folder and switch to appropriate branch and clean it.
		 echo -e "\n"
		 cd $FrameworkRoot
		 sudo git clean -dxf
		 echo -e "\n"
		 git checkout $FrameworkVersion
		 git pull
		 sudo rm $FrameworkRoot/Kernel/Config.pm
		 echo -e "\n${yellow}======================================================================="

		 # Grant Mysql DB privileges to the 'otrs' user to be able to create other necessary users.
		 if [[ $DBType == "Mysql" ]]
			then echo -e "\n${yellow}Give 'otrs' user all privileges for MySQL DB"
		 	 	 echo -e "${yellow}======================================================================="

			     sudo echo "GRANT ALL ON *.* TO 'otrs'@'localhost'" | mysql -u "root" "-proot"
			 	 sudo echo "GRANT GRANT OPTION ON *.* TO 'otrs'@'localhost'" | mysql -u "root" "-proot"

				 echo -e "${green}Done"
		 fi
fi

# Copy custom configuration.
sudo cp -a /opt/scripts/OTRS-AllInOne/Mojolicious/config.pl /opt/module-tools/etc/config.pl

# Install OTRS.
echo -e "\\n"
echo -e "${yellow}Installing $OTRSName $DBType"
echo -e "======================================================================="
echo -e "${green}"

sudo -u s7otrs /opt/module-tools/bin/otrs.ModuleTools.pl TestSystem::Instance::Setup --framework-directory $FrameworkRoot --database-type $DBType

echo -e "\\n${yellow}======================================================================="

# Copy Kernel/WebApp.conf.dist to Kernel/WebApp.conf
echo -e "${yellow}Copy Kernel/WebApp.conf.dist to Kernel/WebApp.conf"
echo -e "======================================================================="
sudo cp -a /opt/$OTRS/Kernel/WebApp.conf.dist /opt/$OTRS/Kernel/WebApp.conf
echo -e "${green}"

# Rebuild config.
echo "${yellow}Rebuilding config:"
 echo "${yellow}======================================================================="
 echo -e "\n"
 perl bin/otrs.Console.pl Maint::Config::Rebuild --cleanup
