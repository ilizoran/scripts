#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

# delete ZZZ* files in tmp
echo -e "\\n"
echo "${yellow}Delete ZZZ* files:"
echo "${yellow}======================================================================="
echo -e "\\n"

mysql -uroot -proot -e 'show databases'
mysql -uroot -proot -e 'drop database otrs'
echo -e "\\n${green}DB i is droped\\n"

mysql -uroot -proot -e 'show databases'

echo -e "\\n${green}Done\\n"
echo -e "\\n${yellow}======================================================================="
echo -e "${reset}\\n"
