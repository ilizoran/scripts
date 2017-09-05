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

if [[ $OTRS == *"otrs4"* ]]
	then OTRSName="OTRS 4"
		 FrameworkVersion="rel-4_0"
		 FredVersion="rel-4_0"
elif [[ $OTRS == *"otrs5"* ]]
	then OTRSName="OTRS 5"
		 FrameworkVersion="rel-5_0"
elif [[ $OTRS == *"otrs6"* ]]
	then OTRSName="OTRS 6"
		 FrameworkVersion="rel-6_0"
elif [[ $OTRS == *"otrs7"* ]]
	then OTRSName="OTRS 7"
		 FrameworkVersion="master"
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
		 sudo git clean -d -f -f
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
sudo cp -a /opt/scripts/OTRS-AllInOne/config.pl /opt/module-tools/etc/config.pl

# Select appropriate Fred version.
echo -e "\\n"
echo -e "${yellow}Checkout Fred to correct branch"
echo -e "======================================================================="
echo -e "${green}"

cd /opt/Fred/
sudo git clean -d -f -f
git checkout $FredVersion
cd $FrameworkRoot

# Install OTRS.
echo -e "\\n"
echo -e "${yellow}Installing $OTRSName $DBType"
echo -e "======================================================================="
echo -e "${green}"

sudo -u s7otrs /opt/module-tools/bin/otrs.ModuleTools.pl TestSystem::Instance::Setup --framework-directory $FrameworkRoot --fred-directory /opt/Fred --database-type $DBType

echo -e "\\n${yellow}======================================================================="

# Disable OTRS site and enable it again.
echo -e "${yellow}Enable OTRS $OTRS site"
echo -e "======================================================================="
echo -e "${green}"

SitePath="/etc/apache2/other/$OTRS.conf"
sudo cp $SitePath /etc/apache2/sites-available/
sudo a2ensite $OTRS

echo -e "\\n${yellow}======================================================================="

# Enable ModPerl for this site.
perl /opt/scripts/OTRS-AllInOne/ActivateSite.sh $OTRS
