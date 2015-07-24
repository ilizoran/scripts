#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

# clean up DB
perl ../scripts/otrs.CleanTestUsers.pl

# delete ZZZ* files in tmp
echo -e "\\n"
echo "${yellow}Delete ZZZ* files:"
echo "${yellow}======================================================================="
echo -e "\\n"
sudo rm /opt/otrs/Kernel/Config/Files/ZZZ*
echo -e "\\n${green}Done\\n"
ls /opt/otrs/Kernel/Config/Files/
echo -e "\\n${yellow}======================================================================="


# rebuild config
../scripts/rebuild_config.sh

# delete screenshots in tmp
echo -e "\\n"
echo "${yellow}Delete screenshots:"
echo "${yellow}======================================================================="
echo -e "\\n"
# [ -f /tmp/*.png ] && sudo rm /tmp/*.png && echo "The screenshots are deleted" || echo "The screenshots are not found"
sudo rm /tmp/*.png
echo -e "\\n${green}Done\\n"
ls /tmp/*.png
echo -e "\\n${yellow}======================================================================="
echo -e "${reset}\\n"
