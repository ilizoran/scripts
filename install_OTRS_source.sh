#!/bin/bash
# set outout colors
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`
echo -e "${yellow}\\n"
echo "${yellow}________________ INSTALLING OTRS ___________________"
echo -e "\\n"

# add the 'otrs' user to the group of the web server user
echo -e "\\n${yellow}Add the 'otrs' user to the group of the web server user:"
echo -e "${green}"
usermod -G www-data s7otrs

# copy some sample configuration files
echo -e "\\n${yellow}Copy Config.pm configuration file:"
echo -e "${green}"
cp Kernel/Config.pm.dist Kernel/Config.pm

echo -e "\\n${yellow}Copy GenericAgent.pm configuration file:"
echo -e "${green}"
cp Kernel/Config/GenericAgent.pm.dist Kernel/Config/GenericAgent.pm

# check if all needed modules are installed
echo -e "\\n${yellow}Check if all needed modules are installed:"
echo -e "${green}"
perl -cw /opt/otrs/bin/cgi-bin/index.pl
perl -cw /opt/otrs/bin/cgi-bin/customer.pl
perl -cw /opt/otrs/bin/otrs.PostMaster.pl

# configuring the Apache web server
echo -e "\\n${yellow}Configuring the Apache web server:"
echo -e "${green}"
cp /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/conf.d/otrs.conf

# restart apache
echo -e "\\n${yellow}Restart Apache web server:"
echo -e "${green}"
sudo service apache2 restart

# set permissions
echo -e "\\n${yellow}Set permissions"
echo -e "${green}"
sudo perl bin/otrs.SetPermissions.pl --otrs-user=s7otrs --web-group=www-data

echo "${yellow}________________  COMPLETED INSTALLING OTRS ___________________"
echo -e "${reset}\\n"