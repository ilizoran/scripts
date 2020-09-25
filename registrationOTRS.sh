#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

db_name=$1

if [[ ! $db_name ]]
	then 
		echo -e "${yellow}Need DB name!:"
		echo -e "${green}"
	exit 0
fi

echo -e "${yellow}\\n"
echo -e "${yellow}Update registration in DB:"
echo "${yellow}======================================================================="
echo -e "\\n"
echo -e "${green}"

echo -e "\\n"
mysql --host localhost --user root --password=root -D $db_name -e "
INSERT INTO system_data (data_key, data_value, create_time, create_by, change_time, change_by)
 VALUES ('Registration::DueTime', '2030-09-16 16:20:24', now(), 1, now(), 1);";


echo -e "\\n"
echo -e "Done!"

echo -e "\\n${yellow}======================================================================="
echo -e "${reset}\\n"


