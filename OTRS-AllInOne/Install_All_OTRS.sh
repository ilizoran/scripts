#!/bin/bash

sudo apachectl graceful

perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs4-m Mysql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs5-m Mysql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs6-m Mysql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs7-m Mysql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs4-p Postgresql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs5-p Postgresql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs6-p Postgresql
perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs7-p Postgresql

sudo apachectl graceful
