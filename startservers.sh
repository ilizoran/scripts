#!/bin/bash

NoElastic=$1

Branch=$(git rev-parse --abbrev-ref HEAD)

# Script should be executed from the OTRS folder and elastic search in /opt
if [[ "$Branch" == *"rel-7_0"* ]] && [[ "$NoElastic" != "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs7-mojo/bin/otrs.Console.pl Dev::Tools::WebServer --port 3000" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
elif [[ "$Branch" == *"rel-7_0"* ]] && [[ "$NoElastic" == "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs7-mojo/bin/otrs.Console.pl Dev::Tools::WebServer --port 3000" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
elif [[ "$Branch" == *"rel-8_0"* ]] && [[ "$NoElastic" != "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app Agent --port 3010" \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app External --port 3012" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
elif [[ "$Branch" == *"rel-8_0"* ]] && [[ "$NoElastic" == "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app Agent --port 3010" \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app External --port 3012" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
elif [[ "$Branch" == *"master"* ]] && [[ "$NoElastic" != "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs9/bin/otrs.Console.pl Dev::Tools::WebServer --app Agent --port 3014" \
		--tab -e "perl /opt/otrs9/bin/otrs.Console.pl Dev::Tools::WebServer --app External --port 3016" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
elif [[ "$Branch" == *"master"* ]] && [[ "$NoElastic" == "No" ]]
	then gnome-terminal \
		--tab -e "perl /opt/otrs9/bin/otrs.Console.pl Dev::Tools::WebServer --app Agent --port 3014" \
		--tab -e "perl /opt/otrs9/bin/otrs.Console.pl Dev::Tools::WebServer --app External --port 3016" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
else
	gnome-terminal --tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar"
fi
