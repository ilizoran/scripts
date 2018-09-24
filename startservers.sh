#!/bin/bash

Branch=$(git rev-parse --abbrev-ref HEAD)

# Script should be executed from the OTRS folder and elastic search in /opt
if [[ "$Branch" == *"master"* ]] 
	then gnome-terminal \
		--tab -e "perl /opt/otrs7-mojo/bin/otrs.Console.pl Dev::Tools::WebServer" \
		--tab -e "/opt/elasticsearch/bin/elasticsearch" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
else 
	gnome-terminal --tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
fi
