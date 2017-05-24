#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`
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
perl bin/otrs.Console.pl Maint::Config::Rebuild --cleanup
perl bin/otrs.Console.pl Dev::Tools::Migrate::ConfigXMLStructure --source-directory /opt/otrs/Kernel/Config/Files/

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
echo -e "${reset}\\n"


