#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

FrameworkRoot=${PWD}

if [[ $1 == 4 ]]
	then branch='rel-4_0' 
elif [[ $1 == 5 ]]
	then branch='rel-5_0'
elif [[ $1 == 6 ]]
	then branch='rel-6_0'
else
	branch='master'
fi

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
	echo -e "${yellow}======================================================================="
done

cd $FrameworkRoot


 