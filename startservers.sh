#!/bin/sh
# Script should be executed from the OTRS folder and elastic search in /opt
gnome-terminal \
        --tab -e "perl $PWD/bin/otrs.Console.pl Dev::Tools::WebServer" \
        --tab -e "/opt/elasticsearch/bin/elasticsearch" \
        --tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar" \
