#!/bin/bash

gnome-terminal \
		--tab -e "perl /opt/otrs7/bin/otrs.Console.pl Dev::Tools::WebServer" \
		--tab -e "/opt/elasticsearch/bin/elasticsearch" \
		--tab -e "java -Dwebdriver.chrome.driver=/opt/scripts/chromedriver -jar /opt/scripts/selenium-server-standalone.jar" \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app Agent --port 3010" \
		--tab -e "perl /opt/otrs8/bin/otrs.Console.pl Dev::Tools::WebServer --app External --port 3012" \



