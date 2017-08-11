OTRS Scripts for installing multiple instances with Mysql or Postgresql DB type
===============================================================================

These scripts require to have already predifined OTRS folders or to have default OTRS folder in /opt/otrs

Install single OTRS instance
----------------------------

Script: Install_OTRS.sh

For installing single OTRS instance. Script require two parameters. First is for name of the site installing.
Please stay in the boundaries of naming sites in teplate (e.g otrs4-m otrs5-p otrs6-m ... ).
Second is for database type Mysql or Postgresql.


Example:
	perl /opt/scripts/OTRS-AllInOne/Install_OTRS.sh otrs5-m Mysql


This will install OTRS 5 with Mysql database on site otrs5-m. When installing on Postgresql please keep site name
lowercased. Postgresql is case sensitive database and it creates problem with uppercase letters.


Activate single OTRS site
-------------------------

Script: ActivateSite.sh

There can be only one single OTRS site with ModPerl active at one time. Call following script to activate for site
you are working on. Script will disable ModPerl in all other sites.

Script take one parameter, name of site you want to enable ModPerl.


Example:
	perl /opt/scripts/OTRS-AllInOne/ActivateSite.sh otrs5-m


Install all OTRS instances
--------------------------

Script: Install_All_OTRS.sh

This script will install OTRS 4,5,6 on both Mysql and Postgresql.

Result will be following sites:
	otrs4-m
	otrs4-p
	otrs5-m
	otrs5-p
	otrs6-m
	otrs6-7


Post install information
------------------------

After enabling ModPerl for appropriate site you can use following address to access OTRS in browser.

Example: http://localhost/otrs5-m/index.pl?

Note between localhost/...../index.pl? is the name of site you activated ModPerl for.
