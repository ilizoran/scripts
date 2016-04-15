#!/usr/bin/perl
# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use Getopt::Std;

# get options
my %Opts = ();
getopt( 'avmothl', \%Opts );

# set default
if ( !$Opts{'a'} || !$Opts{'m'} || !$Opts{'o'} ) {
    $Opts{'h'} = 1;
}
if ( $Opts{'h'} ) {

    print <<'EOF';

Linker.pl -  to link / unlink all  modules into a OTRS system
Copyright (C) 2001-2014 OTRS AG, http://otrs.org/

Usage:
    Linker.pl -a <install|uninstall> [ -v <ITSM branch version number> ] [ -t <Module-Tools-Path> ] -m <Module-Path> -o <OTRS-path> [ -d (also executes DatabaseInstall and CodeInstall) ]

Examples:
    Linker.pl -a install -v 3.3 -m /devel -o /devel/otrs33-itsm
    Linker.pl -a install -v 4.0 -m /devel -o /devel/otrs40-itsm -d
    Linker.pl -a install -v 4.0 -t /devel/other/module-tools -m /devel -o /devel/otrs -d
    Linker.pl -a install -m /devel -o /devel/otrs40-itsm -d

    Linker.pl -a install -t /opt/module-tools -m /opt -o /opt/otrs -l FAQ -d

EOF

    exit 1;
}

my @Modules;

$Opts{'l'} = $Opts{'l'} || 'ITSM';

if ( $Opts{'l'} eq 'ITSM' ) {
    @Modules = (
        'GeneralCatalog',
        'ITSMCore',
        'ITSMIncidentProblemManagement',
        'ITSMConfigurationManagement',
        'ITSMChangeManagement',
        'ITSMServiceLevelManagement',
        'ImportExport',
    );
}

if ( $Opts{'l'} eq 'FAQ' ) {
    @Modules = (
        'FAQ',
    );
}

if ( $Opts{'l'} eq 'Survey' ) {
    @Modules = (
        'Survey',
    );
}

if ( $Opts{'l'} eq 'TimeAccounting' ) {
    @Modules = (
        'TimeAccounting',
    );
}


if ( $Opts{'l'} eq 'OTRSMasterSlave' ) {
    @Modules = (
        'OTRSMasterSlave',
    );
}

if ( $Opts{'l'} eq 'OTRSBusiness' ) {
    @Modules = (
        'OTRSBusiness',
    );
}

if ( $Opts{'l'} eq 'Fred' ) {
    @Modules = (
        'Fred',
    );
}

if ( $Opts{'l'} eq 'OTRSCustomerPortal' ) {
    @Modules = (
        'OTRSDynamicFieldAttachment',
        'FAQ',
        'OTRSCustomerPortal',
    );
}

if ( $Opts{'l'} eq 'OTRSCodePolicy' ) {
    @Modules = (
        'OTRSCodePolicy',
    );
}

if ( $Opts{'l'} eq 'All' ) {
    @Modules = (
        'GeneralCatalog',
        'ITSMCore',
        'ITSMIncidentProblemManagement',
        'ITSMConfigurationManagement',
        'ITSMChangeManagement',
        'ITSMServiceLevelManagement',
        'ImportExport',
        'TimeAccounting',
        'Campain',
        'Finance',
        'OTRSCICustomSearch',
        'OTRSDynamicFieldAttachment',
        'OTRSCustomerPortal',
        'FAQ',
        'OTRSRestorePendingInformation',
        'OTRSBusiness',
    );
}



# reverse the list of packages for uninstall
if ( $Opts{'a'} eq 'uninstall' ) {
    @Modules = reverse @Modules;
}

# replace . with _
$Opts{'v'} ||= '';
if ( $Opts{'v'} ) {
    $Opts{'v'} =~ s{\.}{_}gxms;
    $Opts{'v'} = '-' . $Opts{'v'};
}

# remove slashes at the end
$Opts{'m'} =~ s{ / \z }{}gxms;

my $ModuleToolsPath = $Opts{'t'};
if ( !$ModuleToolsPath ) {
    $ModuleToolsPath = "$Opts{'m'}/module-tools/";
}

# remove slashes at the end
$ModuleToolsPath =~ s{ / \z }{}gxms;

# copy helper scripts to bin folder
system("cp $ModuleToolsPath/DatabaseInstall.pl $Opts{'o'}/bin");
system("cp $ModuleToolsPath/CodeInstall.pl $Opts{'o'}/bin");

for my $Module (@Modules) {

    # get name of SOPM file
    my $SOPMFile = $Module . '.sopm';

    # create module path and name with correct version
    $Module = $Opts{'m'} . '/' . $Module . $Opts{'v'};

    # link the module
    system("perl $ModuleToolsPath/module-linker.pl $Opts{'a'} $Module $Opts{'o'}");

    # check if DatabaseInstall and CodeInstall should be excuted
    if ( $Opts{'a'} eq 'install' && $Opts{'d'} ) {
        system("perl $Opts{'o'}/bin/DatabaseInstall.pl -m $SOPMFile -a install");
        system("perl $Opts{'o'}/bin/CodeInstall.pl -m $SOPMFile -a install");
    }
}

print "... done\n"
