#!/usr/bin/perl
# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

my $Config = {

    # settings used by TestSystem::Instance::Setup and TestSystem::Database::Fill.
    TestSystem => {

        # the path to your workspace directory, w/ leading and trailing slashes
        EnvironmentRoot => '/opt/',

        # User name for mysql (should be the same that you usually use to install a local OTRS).
        DatabaseUserNameMysql => 'otrs',

        # Password for your mysql user.
        DatabasePasswordMysql => 'otrs',

        # User name for PostgreSQL.
        DatabaseUserNamePostgresql => 'postgres',

        # Password for your PostgreSQL user.
        DatabasePasswordPostgresql => 'root',

        # User name for Oracle.
        DatabaseUserNameOracle => 'sys',

        # Password for your Oracle user.
        DatabasePasswordOracle => '',

        PermissionsOTRSUser   => 's7otrs',                                  # OTRS user
        PermissionsOTRSGroup  => 'www-data',                                # OTRS group
        PermissionsWebUser    => 's7otrs',                                  # otrs-web user
        PermissionsWebGroup   => 'www-data',                                # otrs-web group
        PermissionsAdminGroup => ( $^O =~ /darwin/i ? 'wheel' : 'root' ),

        # the apache config of the system you're going to install will be copied to this location
        ApacheCFGDir => '/etc/apache2/other/',

        # the command to restart apache (could be different on other systems)
        ApacheRestartCommand => 'apachectl graceful',

        # Define your own configuration here if you would like to override default one. You may use
        #  following variables: $SystemName, %Config.
        ConfigInject => <<'EOD'

    #\$Self->{TestDatabase} = {
    #    DatabaseDSN  => 'DBI:mysql:database=otrs_test;host=127.0.0.1;',
    #    DatabaseUser => 'otrs_test',
    #    DatabasePw   => 'otrs_test',
    #};

    \$Self->{'SecureMode'} = 1;
    \$Self->{'SystemID'}            = '54';
    \$Self->{'SessionName'}         = '$SystemName';
    \$Self->{'ProductName'}         = '$SystemName';
    \$Self->{'CheckEmailAddresses'} = 1;
    \$Self->{'CheckMXRecord'}       = 0;
    \$Self->{'Organization'}        = '';
    \$Self->{'LogModule'}           = 'Kernel::System::Log::File';
    \$Self->{'LogModule::LogFile'}  = '$Config{EnvironmentRoot}$SystemName/var/log/otrs.log';
    \$Self->{'FQDN'}                = 'localhost';
    \$Self->{'TestHTTPHostname'}    = 'localhost:3001';
    \$Self->{'DefaultLanguage'}     = 'en';
    \$Self->{'DefaultCharset'}      = 'utf-8';
    \$Self->{'AdminEmail'}          = 'root\@localhost';
    \$Self->{'Package::Timeout'}    = '120';

    # Configure send main
    \$Self->{'SendmailModule::AuthPassword'} =  '';
    \$Self->{'SendmailModule::AuthUser'}     =  'zilibasic@s7designcreative.com';
    \$Self->{'SendmailModule::Port'}         =  '25';
    \$Self->{'SendmailModule::Host'}         =  'mail.s7designcreative.com';
    \$Self->{'SendmailModule'}               =  'Kernel::System::Email::DoNotSendEmail';

    # Fred
    \$Self->{'Fred::BackgroundColor'} = '#006ea5';
    \$Self->{'Fred::SystemName'}      = '$SystemName';
    \$Self->{'Fred::ConsoleOpacity'}  = '0.7';
    \$Self->{'Fred::ConsoleWidth'}    = '30%';
    \$Self->{'Fred::Active'}          = 0;

    # Misc
    \$Self->{'Loader::Enabled::CSS'}  = 0;
    \$Self->{'Loader::Enabled::JS'}   = 0;

    # Selenium
    # For testing with Firefox until v. 47 (testing with recent FF and marionette is currently not supported):
    # \$Self->{'SeleniumTestsConfig'} = {
    #     remote_server_addr  => 'localhost',
    #     port                => '4444',
    #     platform            => 'ANY',
    #     browser_name        => 'firefox',
    #     extra_capabilities => {
    #        marionette     => \0,     # Required to run FF 47 or older on Selenium 3+.
    #    },
    # };

    # For testing with Chrome/Chromium (requires installed geckodriver):
    \$Self->{'SeleniumTestsConfig'} = {
        remote_server_addr  => 'localhost',
        port                => '4444',
        platform            => 'ANY',
        browser_name        => 'chrome',
        extra_capabilities => {
            chromeOptions => {
                args => ["no-sandbox", "disable-infobars"],
            },
        },
    };

    delete \$Self->{'Frontend::NotifyModule'}->{'1100-SystemContract'};

EOD
        ,

        # Agent data
        Agents => [
            {
                UserFirstname => 'Zoran',
                UserLastname  => 'Ilibasic',
                UserLogin     => 'zilibasic',
                UserPw        => 'zilibasic',
                UserEmail     => 'zilibasic@s7designcreative.com',
            },
            {
                UserFirstname => 'Sanjin',
                UserLastname  => 'Vik',
                UserLogin     => 'svik',
                UserPw        => 'svik',
                UserEmail     => 'svik@s7designcreative.com',
            },
            {
                UserFirstname => 'Milan',
                UserLastname  => 'Rakic',
                UserLogin     => 'mrakic',
                UserPw        => 'mrakic',
                UserEmail     => 'mrakic@s7designcreative.com',
            },
        ],

        # Customer data
        Customers => [
            {
                UserFirstname  => 'Pera',
                UserLastname   => 'Peric',
                UserLogin      => 'pera',
                UserPassword   => 'pera',
                UserEmail      => 'zilibasic@s7designcreative.com',
                UserCustomerID => 'FirstCID',
            },
            {
                UserFirstname  => 'Steva',
                UserLastname   => 'Stevic',
                UserLogin      => 'steva',
                UserPassword   => 'steva',
                UserEmail      => 'svik@s7designcreative.com',
                UserCustomerID => 'FirstCID',
            },
            {
                UserFirstname  => 'Janko',
                UserLastname   => 'Jankovic',
                UserLogin      => 'janko',
                UserPassword   => 'janko',
                UserEmail      => 'mrakic@s7designcreative.com',
                UserCustomerID => 'FirstCID',
            },
            {
                UserFirstname  => 'Ana',
                UserLastname   => 'Anic',
                UserLogin      => 'ana',
                UserPassword   => 'ana',
                UserEmail      => 'anne.mustermann@s7designcreative.com',
                UserCustomerID => 'FirstCID',
            },
            {
                UserFirstname  => 'Susanne',
                UserLastname   => 'Susic',
                UserLogin      => 'susanne',
                UserPassword   => 'susanne',
                UserEmail      => 'susanne.mustermann@s7designcreative.com',
                UserCustomerID => 'FirstCID',
            },
        ],

        # Service data
        Services => [
            { Name => 'Service 1' },
            { Name => 'Service 2' },
        ],

        # SLA data
        SLAs => [
            {
                Name         => 'SLA 1',
                ServiceNames => ['Service 2'],
            },
            {
                Name         => 'SLA 2',
                ServiceNames => [ 'Service 2', 'Service 1' ],
            },
        ],
    },

    # Settings used by Git::Directories::Update.
    DevelDir => {
        DevelDirectories => [

            #    '/path/to/your/devel/directory/',
        ],
        AdditionalDevelDirectories => [

            #    '/path/to/your/directory/with/all/git/repositories/',
        ],
        GitIgnore => [

            #    '/path/to/ignore/',
        ],
        CodePolicyRegisterCommand => '/opt/OTRSCodePolicy/scripts/install-git-hooks.pl',
    },

    # Collections of modules to be used by Files::Link, Files::Unlink, Module::Install, Module::UnInstall.
    ModuleCollection => {
        ITSM => [
            '/opt/GeneralCatalog',
            '/opt/ITSMCore',
            '/opt/ITSMIncidentProblemManagement',
            '/opt/ITSMConfigurationManagement',
            '/opt/ITSMChangeManagement',
            '/opt/ITSMServiceLevelManagement',
            '/opt/ImportExport',
        ],
        Public => [
            '/opt/FAQ',
            '/opt/OTRSAppointmentCalendar',
            '/opt/OTRSMasterSlave',
            '/opt/Survey',
            '/opt/SystemMonitoring',
            '/opt/TimeAccounting',
        ],
        CI => [
            '/opt/GitInterface',
            '/opt/PackageCompatibility',
            '/opt/OTRSCodeHub',
            '/opt/OPMS',
            '/opt/OTRSContinuousIntegrationMaster',
        ],
    },
};
