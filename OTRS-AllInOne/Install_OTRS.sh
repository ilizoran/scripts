#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

OTRS=$1
DBType=$2

# If DB type param is not available use Mysql.
if [[ ! $DBType ]]
	then DBType="Mysql"
fi

# Define needed variables.
FrameworkRoot="/opt/$OTRS"
FirstInstall=0

if [[ $OTRS == *"otrs4"* ]]
	then OTRSName="OTRS 4"
		 FrameworkVersion="rel-4_0"
		 FredVersion="rel-4_0"
elif [[ $OTRS == *"otrs5"* ]]
	then OTRSName="OTRS 5"
		 FrameworkVersion="rel-5_0"
		 FredVersion="master"
elif [[ $OTRS == *"otrs6"* ]]
	then OTRSName="OTRS 6"
		 FrameworkVersion="master"
		 FredVersion="master"
fi

# If this is first installation of OTRS for this version with this script copy content from the original folder.
if [[ ! -d $FrameworkRoot ]];
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
		 sudo rm $FrameworkRoot/Kernel/Config.pm
		 echo -e "\n${yellow}======================================================================="

		 # First installation flag.
		 FirstInstall=1
fi

# Copy custom configuration.
sudo cp -a /opt/scripts/OTRS-AllInOne/config.pl /opt/module-tools/etc/config.pl

# Install OTRS.
echo -e "\\n"
echo -e "${yellow}Checkout Fred to correct branch"
echo -e "${yellow}======================================================================="
echo -e "${green}"

cd /opt/Fred/
sudo git clean -d -f -f
git checkout $FredVersion
cd $FrameworkRoot

# Install OTRS.
echo -e "\\n"
echo -e "${yellow}Installing $OTRSName $DBType"
echo -e "${yellow}======================================================================="
echo -e "${green}"

sudo -u s7otrs /opt/module-tools/bin/otrs.ModuleTools.pl TestSystem::Instance::Setup --framework-directory $FrameworkRoot --fred-directory /opt/Fred --database-type $DBType

echo -e "\\n${yellow}======================================================================="
if [[ $FirstInstall == 1 ]]
	then SitePath="/etc/apache2/other/$OTRS.conf"
		 sudo cp $SitePath /etc/apache2/sites-available/
		 sudo a2ensite $OTRS
		 echo "Remember to enable ModPerl for this site"
fi

