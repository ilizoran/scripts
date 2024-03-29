#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

OTRS=$1
Module=$2
DBType=$3


# If DBType param is not available use Mysql as default.
if [[ ! $DBType ]]
	then DBType="Mysql"
fi

if [[ $Module == "Postgresql" || $Module == "Mysql" || $Module == "" ]]
	then
		Module="No"
fi

if [[ $OTRS == "otrs" || $OTRS == "otrs7" || $OTRS == "otrs8" || $OTRS == "otrs9" ]]
then
	if [[ $DBType == "Postgresql" ]]
		then

		# delete DB otrs
		echo -e "\\n"
		echo "${yellow}Drop DB:"
		echo "${yellow}======================================================================="
		echo -e "\\n"

		sudo /etc/init.d/postgresql restart

		PGPASSWORD=root psql -U postgres -h localhost -l
		PGPASSWORD=root dropdb -h localhost  -U postgres $OTRS
		echo -e "\\n${green}DB i is droped\\n"

		PGPASSWORD=root psql -U postgres -h localhost -l

		PGPASSWORD=root psql -U postgres -h localhost -c "DROP ROLE IF EXISTS $OTRS"
		echo -e "\\n${green}Done\\n"
		echo -e "\\n${yellow}======================================================================="
		echo -e "${reset}\\n"
	else
		# delete DB otrs
		echo -e "\\n"
		echo "${yellow}Drop DB"
		echo "${yellow}======================================================================="
		echo -e "\\n"

		mysql -uroot -proot -e 'show databases'
		mysql -uroot -proot -e "drop database $OTRS"
		echo -e "\\n${green}DB i is droped\\n"

		mysql -uroot -proot -e 'show databases'

		echo -e "\\n${green}Done\\n"
		echo -e "\\n${yellow}======================================================================="
		echo -e "${reset}\\n"

		# Grant Mysql DB privileges to the 'otrs' user to be able to create other necessary users.
		echo -e "\n${yellow}Give 'otrs' user all privileges for MySQL DB"
	 	echo -e "${yellow}======================================================================="

     	sudo echo "GRANT ALL ON *.* TO 'otrs'@'localhost'" | mysql -u "root" "-proot"
 	 	sudo echo "GRANT GRANT OPTION ON *.* TO 'otrs'@'localhost'" | mysql -u "root" "-proot"

	 	echo -e "${green}Done"
	fi
fi

# Define needed script variables.
FrameworkRoot="/opt/$OTRS"

cd ../module-tools/
git checkout master
cd /opt/$OTRS

if [[ $OTRS == *"otrs7"* ]]
	then OTRSName="OTRS 7"
		 FrameworkVersion="rel-7_0"
elif [[ $OTRS == *"otrs8"* ]]
	then OTRSName="OTRS 8"
		 FrameworkVersion="rel-8_0"
else [[ $OTRS == *"otrs9"* ]]
	 OTRSName="OTRS 9"
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

# Install modules.
if [[ $Module != "No" ]]
	then
		echo -e "\\n"
		echo -e "${yellow}Installing $Module modules"
		echo -e "======================================================================="
		echo -e "${green}"
		perl ../module-tools/bin/otrs.ModuleTools.pl Module::Package::Install $Module
fi

# Update registration date.
if [[ $DBType == "Mysql" ]]
then 
	/opt/scripts/registrationOTRS.sh $OTRS
fi

# Rebuild config.
echo "${yellow}Rebuilding config:"
echo "${yellow}======================================================================="
echo -e "\n"
perl bin/otrs.Console.pl Maint::Config::Rebuild

Branch=$(git rev-parse --abbrev-ref HEAD)
if [[ $Branch == "rel-7_0" || $Branch == "rel-8_0" || $Branch == "master" ]]
	then

	# Copy Kernel/WebApp.conf.dist to Kernel/WebApp.conf
	echo -e "${yellow}Copy Kernel/WebApp.conf.dist to Kernel/WebApp.conf"
	echo -e "======================================================================="
	sudo cp -a /opt/$OTRS/Kernel/WebApp.conf.dist /opt/$OTRS/Kernel/WebApp.conf
	sudo sed -i -e 's|selenium_test_mode\s*=>.*|selenium_test_mode => 1,|' /opt/$OTRS/Kernel/WebApp.conf
	echo -e "${green}Done.\\n"
else
	if [[ $OTRS != "otrs" ]]
	then
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
	fi
fi

# Adding users to all groups.
if [[ $Module != "No" ]]
	then
		echo -e "${yellow}Adding users to all groups..."
		echo -e "======================================================================="
		echo -e "${green}"
		OTRSDB="$(sed s/-/_/g <<< $OTRS)"

        if [[ $Module == "OPMS" ]]
        	then
        		perl /opt/$OTRS/bin/otrs.Console.pl Admin::Group::Add --name 'ci-frontend' --quiet
    	fi

		if [[ $DBType == "Mysql" ]]
			then
				# Get all users from the DB.
				UsersString=$(mysql $OTRSDB -uroot -proot -e "SELECT login FROM users ORDER BY login")
				IFS=$'\n' AllUsers=($(grep -oP '^(\w|-|@)*$' <<< "$UsersString"))
				AllUsers=("${AllUsers[@]:1}")

				# Get all groups from the DB.
				if [[ $Branch == "rel-7_0" || $Branch == "rel-8_0" || $Branch == "master" ]]
					then
					GroupsString=$(mysql $OTRSDB -uroot -proot -e "SELECT name FROM groups_table ORDER BY name")
				else
					GroupsString=$(mysql $OTRSDB -uroot -proot -e "SELECT name FROM groups ORDER BY name")
				fi
				IFS=$'\n' AllGroups=($(grep -oP '^(\w|-)*$' <<< "$GroupsString"))
				AllGroups=("${AllGroups[@]:1}")
		else

				# Get all users from the DB.
				UsersString=$(PGPASSWORD=root psql -U postgres -h localhost -d $OTRSDB -c "SELECT login FROM users ORDER BY login")
				IFS=$'\n' AllUsers=($(grep -oP '^\s(\w|-|@)*$' <<< "$UsersString"))

				# Get all groups from the DB.
				if [[ $Branch == "rel-7_0" || $Branch == "rel-8_0" || $Branch == "master" ]]
					then
					GroupsString=$(PGPASSWORD=root psql -U postgres -h localhost -d $OTRSDB -c "SELECT name FROM groups_table ORDER BY name")
				else
					GroupsString=$(PGPASSWORD=root psql -U postgres -h localhost -d $OTRSDB -c "SELECT name FROM groups ORDER BY name")
				fi

				IFS=$'\n' AllGroups=($(grep -oP '^\s(\w|-)*$' <<< "$GroupsString"))
		fi

		# Add each user to each group with rw access.
		for User in "${AllUsers[@]}"
		do
			User="$(sed 's/^[[:space:]]//' <<< $User)"
			for Group in "${AllGroups[@]}"
			do
				Group="$(sed 's/^[[:space:]]//' <<< $Group)"
			    perl /opt/$OTRS/bin/otrs.Console.pl Admin::Group::UserLink --user-name $User --group-name $Group --permission rw --quiet
			done
		done
		echo -e "${green}Done.\\n"
fi

