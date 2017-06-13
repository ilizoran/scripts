#!/bin/bash
cd /opt/scripts/
git checkout master_4_0 
cd /opt/otrs

/opt/scripts/install_OTRS.sh

cd /opt/scripts/
git checkout master
cd /opt/otrs

