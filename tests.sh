
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --test CIMaster
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --test Sort
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --test Index
  
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --directory CIMaster
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --directory Console/Command/Dev/CIMaster
 # perl bin/otrs.Console.pl Dev::UnitTest::Run --directory Console/Command/Maint/CIMaster


 # perl bin/otrs.Console.pl Dev::UnitTest::Run --directory Selenium/Output/Dashboard/CIMaster
 # # read -p "Press [Enter] key to continue..."

 #  perl bin/otrs.Console.pl Dev::UnitTest::Run --directory Selenium/Agent/CIMaster
 # read -p "Press [Enter] key to continue..."


perl bin/otrs.Console.pl Dev::UnitTest::Run --directory Chat

perl bin/otrs.Console.pl Dev::UnitTest::Run --test NotificationView
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Team
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Closed
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Old
perl bin/otrs.Console.pl Dev::UnitTest::Run --test DeleteExpired
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Console/Command/Maint/Stats/Reports/Generate
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Console/Command/Maint/Stats/Reports/GenerateCron
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Signalling
perl bin/otrs.Console.pl Dev::UnitTest::Run --test NotificationViewSearch
perl bin/otrs.Console.pl Dev::UnitTest::Run --test StatsReport

#
#	Selenium BS
#

# perl bin/otrs.Console.pl Dev::UnitTest::Run --test AdminGenericInterfaceWebserviceImportExample

perl bin/otrs.Console.pl Dev::UnitTest::Run --test AdminContactWithData
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AdminDynamicFieldContactWithData
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AdminDynamicFieldDatabase

#perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentAppointmentResourceOverview

perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentContactWithDataSearch

# failed 
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentDynamicFieldDatabase
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentNotificationView
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentStatisticsReports
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentTicketAttachmentView

# this one run three tests agent, customer and public
perl bin/otrs.Console.pl Dev::UnitTest::Run --test Chat

# this one run two tests agent, customer
perl bin/otrs.Console.pl Dev::UnitTest::Run --test VideoChat
perl bin/otrs.Console.pl Dev::UnitTest::Run --test AgentTicketAttachmentView

perl bin/otrs.Console.pl Dev::UnitTest::Run --test CustomerDynamicFieldDatabase


