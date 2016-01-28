#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`


# delete ZZZ* files in tmp
echo -e "\\n"
echo "${yellow}Delete ZZZ* files:"
echo "${yellow}======================================================================="
echo -e "\\n"

PGPASSWORD=root psql -U postgres -h localhost -l
PGPASSWORD=root dropdb -h localhost  -U postgres otrs
echo -e "\\n${green}DB i is droped\\n"

PGPASSWORD=root psql -U postgres -h localhost -l

echo -e "\\n${green}Done\\n"
echo -e "\\n${yellow}======================================================================="
echo -e "${reset}\\n"
