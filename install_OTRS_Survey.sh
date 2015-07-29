#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

/opt/scripts/DropTableOTRS.sh

# delete ZZZ* files in tmp
echo -e "\\n"
echo "${yellow}Delete ZZZ* files:"
echo "${yellow}======================================================================="
echo -e "\\n"
sudo rm /opt/otrs/Kernel/Config/Files/ZZZ*
echo -e "\\n${green}Done\\n"
ls /opt/otrs/Kernel/Config/Files/
echo -e "\\n${yellow}======================================================================="

# delete Config.pm files in tmp
echo -e "\\n"
echo "${yellow}Delete Config.pm file:"
echo "${yellow}======================================================================="
echo -e "\\n"
sudo rm /opt/otrs/Kernel/Config.pm
echo -e "\\n${green}Done\\n"
echo -e "\\n${yellow}======================================================================="


echo -e "\\n${yellow}======================================================================="
# copy the InstallTestsystem.pl script in otrs/Custom folder, execute it, and delete it
cp /opt/scripts/InstallTestsystem.pl /opt/otrs/Custom/
sudo perl Custom/InstallTestsystem.pl -p /opt/otrs -f /opt/Fred/
rm /opt/otrs/Custom/InstallTestsystem.pl
echo -e "\\n${yellow}======================================================================="

echo -e "${yellow}\\n"
echo "${yellow}Rebuilding config:"
echo "${yellow}======================================================================="
echo -e "\\n"
# set permissions
echo -e "${yellow}Set permissions:"
echo -e "${green}"
sudo bin/otrs.SetPermissions.pl --otrs-user=s7otrs --web-group=www-data /opt/otrs

# Rebuild the default configuration of OTRS.
echo -e "\\n${yellow}Rebuild the default configuration of OTRS:"
echo -e "${green}"
perl bin/otrs.Console.pl Maint::Config::Rebuild

# Deletes cache files created by OTRS.
echo -e "\\n${yellow}Deletes cache files created by OTRS:"
echo -e "${green}"
perl bin/otrs.Console.pl Maint::Cache::Delete

# Cleanup the CSS/JS loader cache.
echo -e "\\n${yellow}Cleanup the CSS/JS loader cache:"
echo -e "${green}"
perl bin/otrs.Console.pl Maint::Loader::CacheCleanup

# clean up log data
echo -e "\\n${yellow}Clean up log data:"
echo -e "${green}"
sudo perl ../scripts/otrs.CleanLog.pl

# restart apache
echo -e "\\n${yellow}Restart apache:"
echo -e "${green}"
sudo service apache2 restart

echo -e "\\n${yellow}======================================================================="

echo -e "\\n${green}***********Finished OTS***********"


echo -e "\\n${yellow}======================================================================="

perl ../scripts/Linker.pl -a install -m /opt -o /opt/otrs -l Survey -d


echo -e "\\n${green}***********Finished Survey***********"

echo -e "\\n${yellow}======================================================================="
# copy the FillTestsystem.pl script in otrs/Custom folder, execute it, and delete it
cp /opt/scripts/FillTestsystem.pl /opt/otrs/Custom/

# inject test data
echo -e "\\n${yellow}Inject test data:"
echo -e "${green}"
sudo perl Custom/FillTestsystem.pl
rm /opt/otrs/Custom/FillTestsystem.pl
echo -e "\\n${green}***********Finished ALL***********"
echo -e "\\n${yellow}======================================================================="
echo -e "${reset}\\n"




