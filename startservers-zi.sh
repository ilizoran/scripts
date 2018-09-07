#!/bin/bash

cd /opt/otrs7

gnome-terminal \
		--tab -e "perl /opt/otrs7/bin/otrs.Console.pl Dev::Tools::WebServer" \
		--tab -e "/opt/elasticsearch/bin/elasticsearch" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
