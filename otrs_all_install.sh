#!/bin/bash
cd ../module-tools/
git checkout rel-1_0
cd /opt/otrs
perl ../scripts/Linker.pl -a install -m /opt -o /opt/otrs -l All -d
