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
 		GeneralCatalog
        ITSMCore
        ITSMConfigurationManagement
        ImportExport
        TimeAccounting
        ITSMChangeManagement
        ITSMIncidentProblemManagement
        ITSMServiceLevelManagement
        FAQ
        OTRSMasterSlave
        Survey
        SystemMonitoring
        OTRSBusiness
        OTRSBusinessSeleniumTesting

        # OTRSPortal
        # SaaSCockpit
        # SaaSSOAP

        # Campain
        # Contract-Management
        # Finance
        # OTRSAdditionalCalendars
        # OTRSCICustomSearch
        # OTRSDownloadStatsServer
        # OTRSRestorePendingInformation
        # OTRSDynamicFieldAttachment
        # OTRSCodePolicy
        # OTRSEscalationSuspend
        # OTRSTicketMaskExtensions
        # OTRSHideShowDynamicFields
        # OTRSSchedulerFAQTicketCreate
        # OTRSDynamicFieldAttachment
        # OTRSAdvancedEditor
        # OTRSDataCompress
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


 