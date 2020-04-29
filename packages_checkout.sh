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
elif [[ $1 == 7 ]]
    then branch='rel-7_0'
elif [[ $1 == 8 ]]
    then branch='rel-8_0'
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
        OTRSSTORM
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
        GitInterface
        PackageCompatibility
        OTRSCodeHub
        OPMS
        OTRSContinuousIntegrationMaster
        OTRSCodePolicy
        OTRSDataCompress
        OTRSDownloadStatsClient
        OTRSHideShowDynamicFields
        OTRSImagePreview
        OTRSStatePreselectionResponseTemplates
        OTRSTicketInvoker
        OTRSTicketWatchlist
        )

for NUM in "${NUMS[@]}"
do
    cd /opt/$NUM
    echo -e "${green}"
    echo $NUM
    echo -e "${reset}"
	git stash save


	git checkout master
	git pull

    if [[ $branch != 'master' ]]
    then 
        git checkout $branch
        git pull
    fi
	echo -e "${yellow}======================================================================="
done

cd $FrameworkRoot


 