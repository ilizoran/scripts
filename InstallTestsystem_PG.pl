#!/usr/bin/perl
# --
# InstallTestsystem.pl - script to setup test systems
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

=head1 NAME

InstallTestsystem.pl - script for installing a new test system

=head1 SYNOPSIS

InstallTestsystem.pl

=head1 DESCRIPTION

=cut

use strict;
use warnings;

use Cwd;
use DBI;
use File::Find;
use Getopt::Std;

# get options
my %Opts = ();
getopt( 'pf', \%Opts );

my $InstallDir = $Opts{p};
if ( !$InstallDir || !-e $InstallDir ) {
    Usage("ERROR: -p must be a valid directory!");
    exit 2;
}

my $FredDir = $Opts{f};
if ( !$FredDir || !-e $FredDir ) {
    Usage("ERROR: -f must be a valid Fred-Directory!");
    exit 2;
}

# remove possible slash at the end
$InstallDir =~ s{ / \z }{}xms;

# Configuration
my %Config = (

    # the path to your workspace directory, w/ leading and trailing slashes
    'EnvironmentRoot' => '/opt/',

    # the path to your module tools directory, w/ leading and trailing slashes
    'ModuleToolsRoot' => '/opt/module-tools/',

    # user name for mysql (should be the same that you usually use to install a local OTRS instance)
    'DatabaseUserName' => 'postgres',

    # password for your mysql user
    'DatabasePassword' => 'root',

    'PermissionsOTRSUser'  => 's7otrs',    # OTRS user
    'PermissionsWebGroup'  => 'www-data',    # otrs-web group

    # the apache config of the system you're going to install will be copied to this location
    'ApacheCFGDir' => '/etc/apache2/other/',

    # the command to restart apache (could be different on other systems)
    'ApacheRestartCommand' => 'apachectl graceful',
);

my $SystemName = $InstallDir;
$SystemName =~ s{$Config{EnvironmentRoot}}{}xmsg;
$SystemName =~ s{/}{}xmsg;

# Determine a string that is used for database user name, database name and database password
my $DatabaseSystemName = $SystemName;
$DatabaseSystemName =~ s{-}{_}xmsg;     # replace - by _ (hyphens not allowed in database name)
$DatabaseSystemName =~ s{\.}{_}xmsg;    # replace . by _ (hyphens not allowed in database name)
$DatabaseSystemName = substr( $DatabaseSystemName, 0, 16 );    # shorten the string (mysql requirement)

# edit Config.pm
print STDERR "--- Editing and copying Config.pm...\n";
if ( !-e '/opt/scripts/Config_PG.pm' ) {

    print STDERR "/opt/scripts/Config_PG.pm cannot be opened\n";
    exit 2;
}

## no critic
open my $File, '/opt/scripts/Config_PG.pm' or die "Couldn't open $!";
## use critic
my $ConfigStr = join( "", <$File> );
close $File;

$ConfigStr =~ s{/opt/otrs}{$InstallDir}xmsg;
$ConfigStr =~ s{('otrs'|'some-pass')}{'$DatabaseSystemName'}xmsg;

# inject some more data
my $ConfigInjectStr = <<"EOD";

    \$Self->{'SecureMode'} = 1;
    \$Self->{'SystemID'}            = '54';
    \$Self->{'SessionName'}         = '$SystemName';
    \$Self->{'ProductName'}         = '$SystemName';
    \$Self->{'ScriptAlias'}         = '$SystemName/';
    \$Self->{'Frontend::WebPath'}   = '/$SystemName-web/';
    # \$Self->{'CheckEmailAddresses'} = 0;
    # \$Self->{'CheckMXRecord'}       = 0;
    \$Self->{'Organization'}        = '';
    \$Self->{'LogModule'}           = 'Kernel::System::Log::File';
    \$Self->{'LogModule::LogFile'}  = '$Config{EnvironmentRoot}$SystemName/var/log/otrs.log';
    \$Self->{'FQDN'}                = 'localhost';
    \$Self->{'DefaultLanguage'}     = 'en';
    \$Self->{'DefaultCharset'}      = 'utf-8';
    \$Self->{'AdminEmail'}          = 'root\@localhost';
    \$Self->{'Package::Timeout'}    = '120';

    # Fred
    \$Self->{'Fred::BackgroundColor'} = '#006ea5';
    \$Self->{'Fred::SystemName'}      = '$SystemName';
    \$Self->{'Fred::ConsoleOpacity'}  = '0.6';
    \$Self->{'Fred::ConsoleWidth'}    = '25%';

    # Misc
    \$Self->{'Loader::Enabled::CSS'}  = 0;
    \$Self->{'Loader::Enabled::JS'}   = 0;

    \$Self->{'Ticket::Service'} =  1;

    # Send mail
    \$Self->{'SendmailModule::AuthPassword'} =  'neznam';
    \$Self->{'SendmailModule::AuthUser'} =  'zilibasic\@s7designcreative.com';
    \$Self->{'SendmailModule::Port'} =  '25';
    \$Self->{'SendmailModule::Host'} =  'mail.s7designcreative.com';
    \$Self->{'SendmailModule'} =  'Kernel::System::Email::SMTP';

    # phantomjs SeleniumTestsConfig
    # \$Self->{'SeleniumTestsConfig'} = {
    #     remote_server_addr  => 'localhost',
    #     port                => '8910',
    #     browser_name        => 'phantomjs',
    #     platform            => 'ANY',
    # };

    # phantomjs SeleniumTestsConfig
    # \$Self->{'SeleniumTestsConfig'} = {
    #     remote_server_addr  => '10.0.1.8',
    #     port                => '4444',
    #     browser_name        => 'phantomjs',
    #     platform            => 'ANY',
    # };

    # firefox SeleniumTestsConfig
    \$Self->{'SeleniumTestsConfig'} = {
        remote_server_addr  => 'localhost',
        port                => '4444',
        browser_name        => 'firefox',
        platform            => 'ANY',
    };

EOD

$ConfigStr =~ s{\# \s* \$Self->\{CheckMXRecord\} \s* = \s* 0;}{$ConfigInjectStr}xms;

## no critic
open( my $MyOutFile, '>' . $InstallDir . '/Kernel/Config.pm' );
## use critic
print $MyOutFile $ConfigStr;
close $MyOutFile;

# check apache config
if ( !-e $InstallDir . '/scripts/apache2-httpd.include.conf' ) {

    print STDERR "/scripts/apache2-httpd.include.conf cannot be opened\n";
    exit 2;
}

# copy apache config file
my $ApacheConfigFile = "$Config{ApacheCFGDir}$SystemName.conf";
system(
    "sudo cp $InstallDir/scripts/apache2-httpd.include.conf $ApacheConfigFile"
);


# restart apache
print STDERR "--- Restarting apache...\n";
system("sudo $Config{ApacheRestartCommand}");

# install database
print STDERR "--- Creating Database...\n";
system("PGPASSWORD=root psql -U postgres -h localhost -c \"CREATE DATABASE otrs WITH ENCODING 'UTF8'\"");

# copy the InstallTestsystemDatabase.pl script in otrs/bin folder, execute it, and delete it
system("cp $Config{ModuleToolsRoot}InstallTestsystemDatabase.pl $InstallDir/bin/");
system("perl $InstallDir/bin/InstallTestsystemDatabase.pl $InstallDir");
system("rm $InstallDir/bin/InstallTestsystemDatabase.pl");

# make sure we've got the correct rights set (e.g. in case you've downloaded the files as root)
system("sudo chown -R $Config{PermissionsOTRSUser} $InstallDir");

# link Fred
print STDERR "--- Linking Fred...\n";
print STDERR "############################################\n";
system(
    "$Config{ModuleToolsRoot}/module-linker.pl install $FredDir $InstallDir"
);
print STDERR "############################################\n";

# # Deleting Cache
# print STDERR "--- Deleting cache config...\n";
# print STDERR "############################################\n";
# system("sudo perl $InstallDir/bin/otrs.DeleteCache.pl");
# print STDERR "############################################\n";

# # Rebuild Config
# print STDERR "--- Rebuilding config...\n";
# print STDERR "############################################\n";
# system("sudo perl $InstallDir/bin/otrs.RebuildConfig.pl");
# print STDERR "############################################\n";

# # setting permissions
# print STDERR "--- Setting permissions...\n";
# print STDERR "############################################\n";
# system(
#     "sudo perl $InstallDir/bin/otrs.SetPermissions.pl --otrs-user=$Config{PermissionsOTRSUser}  --web-group=$Config{PermissionsWebGroup} --not-root $InstallDir"
# );
# print STDERR "############################################\n";


sub Usage {
    my ($Message) = @_;

    print STDERR <<"HELPSTR";
$Message

USAGE:
    $0 -p /opt/otrs32-devel -f /opt/Fred
HELPSTR
    return;
}

1;
