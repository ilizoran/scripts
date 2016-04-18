#!/bin/bash
perl ../scripts/Linker.pl -a install -m /opt -o /opt/otrs -l All -d
perl bin/otrs.Console.pl Admin::Package::Install ../OTRS-packages/OTRSDownloadStatsServer-5.0.3.opm
perl bin/otrs.Console.pl Admin::Package::Install ../OTRS-packages/SaaSSOAP-5.0.3.opm
perl bin/otrs.Console.pl Admin::Package::Install ../OTRS-packages/SaaSCockpit-5.0.11.opm