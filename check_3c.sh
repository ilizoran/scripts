#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

FrameworkRoot=${PWD}

cd /opt/otrs6-git

if [[ $1 == 4 ]]
	then 
        branch='rel-4_0'
elif [[ $1 == 5 ]]
	then 
        branch='rel-5_0'
elif [[ $1 == 6 ]]
	then 
        branch='rel-6_0'
else
	branch='master'
fi
git checkout $branch

NUMS=(        
        Campain
        FAQ
        Finance
        GeneralCatalog
        ITSMChangeManagement
        ITSMConfigurationManagement
        ITSMCore
        ImportExport
        ITSMIncidentProblemManagement
        ITSMServiceLevelManagement
        OTRSAdditionalCalendars
        OTRSAdvancedEditor
        OTRSBusiness
        OTRSBusinessSeleniumTesting
        OTRSCICustomSearch
        OTRSCodePolicy
        OTRSDataCompress
        OTRSDownloadStatsServer
        OTRSDynamicFieldAttachment
        OTRSMasterSlave
        OTRSPortal
        OTRSRestorePendingInformation
        SaaSCockpit
        SaaSSOAP
        Survey
        SystemMonitoring
        TimeAccounting 
        OTRSMultipleRecipientEncryption 
        OTRSTicketNumberCounterDatabase 
        OTRSAppointmentCalendar 
        OTRSRestrictCustomerDataView
        )

for NUM in "${NUMS[@]}"
do
    cd /opt/$NUM
    echo -e "${green}"
    echo $NUM
    echo -e "${reset}"
	git stash save
	git checkout $branch
	git pull

    echo -e "${green}"
    echo -e " ** CustomContentCheck for $NUM ** "
    echo -e "${green}"
    cd /opt/otrs

    if [[ $NUM == "OTRSRestorePendingInformation" || $NUM == "OTRSPortal" || $NUM == "OTRSAdvancedEditor" || $NUM == "OTRSMultipleRecipientEncryption" ]]
        then
            perl bin/otrs.Console.pl Dev::Code::CustomContentCheck --package-path /opt/$NUM/ \
            --required-package-path /opt/ITSMIncidentProblemManagement/ \
            --framework-path /opt/otrs6-git/ --detail --diff --summary --autopatch --skip-cache 
    else
        perl bin/otrs.Console.pl Dev::Code::CustomContentCheck --package-path /opt/$NUM/ \
        --framework-path /opt/otrs6-git/ --detail --diff --summary --autopatch --skip-cache     
    fi        

	echo -e "${yellow}======================================================================="
done

cd $FrameworkRoot


 