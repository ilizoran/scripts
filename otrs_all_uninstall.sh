#!/bin/bash
perl bin/otrs.Console.pl Admin::Package::Uninstall ../OTRS-packages/SaaSCockpit-5.0.11.opm
perl bin/otrs.Console.pl Admin::Package::Uninstall ../OTRS-packages/SaaSSOAP-5.0.3.opm
perl bin/otrs.Console.pl Admin::Package::Uninstall ../OTRS-packages/OTRSDownloadStatsServer-5.0.3.opm
perl ../scripts/Linker.pl -a uninstall -m /opt -o /opt/otrs -l All -d