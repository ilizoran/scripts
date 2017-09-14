#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

Active=$1

# Disable ModPerl in every OTRS site.
echo -e "\\n"
echo -e "${yellow}Enable ModPerl for" $Active "site"
echo -e "${yellow}======================================================================="
echo -e "${green}"

for SiteFile in $(ls /etc/apache2/sites-enabled/)
do

	# Skipt iterration for non OTRS sites.
	if [[ $SiteFile != "otrs"* ]]
		then continue
	fi

	# Enable modPerl for active site.
	if [[ $SiteFile == $Active* ]] 
		then sudo sed -i -e "s/<IfModule mod_perlOFF.c>/<IfModule mod_perl.c>/" /etc/apache2/sites-enabled/$SiteFile
		echo "ModPerl for site" ${SiteFile%?????} "is enabled" 
	else 
		sudo sed -i -e "s/<IfModule mod_perl.c>/<IfModule mod_perlOFF.c>/" /etc/apache2/sites-enabled/$SiteFile
	fi
done

# Restart Apache.
echo -e "\n"
echo -e "${yellow}Restart Apache"
echo -e "${yellow}======================================================================="
echo -e "${green}"

sudo apachectl graceful
echo -e "Done"

# For OTRS 4, switch Fred to rel-4. For others switch to master just in case.
echo -e "\n"
echo -e "${yellow}Switch Fred version"
echo -e "${yellow}======================================================================="
echo -e "${green}"

if [[ $Active == *"otrs4"* ]]
	then cd /opt/Fred/
		 sudo git clean -d -f -f
		 git checkout rel-4_0 
		 cd /opt/$Active
elif [[ $Active == *"otrs3"* ]]
	then cd /opt/Fred/
		 sudo git clean -d -f -f
		 git checkout rel-3_1 
		 cd /opt/$Active
else 
	cd /opt/Fred/
	sudo git clean -d -f -f
	git checkout master
	cd /opt/$Active
fi

echo -e "\\n${yellow}======================================================================="

