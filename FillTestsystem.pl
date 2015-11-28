#!/usr/bin/perl
# --
# FillTestsystem.pl - script for adding test data to a OTRS instance
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

FillTestsystem.pl - script for adding testdata to a OTRS instance.

=head1 SYNOPSIS

FileListCheck.pl

=head1 DESCRIPTION

=cut

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Time;
use Kernel::System::Log;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::SysConfig;
use Kernel::System::User;
use Kernel::System::Group;
use Kernel::System::CustomerUser;
use Kernel::System::Service;
use Kernel::System::SLA;

local $Kernel::OM;
if ( eval 'require Kernel::System::ObjectManager' ) {    ## no critic

    # create object manager
    $Kernel::OM = Kernel::System::ObjectManager->new();
}

my %CommonObject = ();
$CommonObject{ConfigObject}       = Kernel::Config->new();
$CommonObject{EncodeObject}       = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}          = Kernel::System::Log->new(%CommonObject);
$CommonObject{TimeObject}         = Kernel::System::Time->new(%CommonObject);
$CommonObject{MainObject}         = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}           = Kernel::System::DB->new(%CommonObject);
$CommonObject{SysConfigObject}    = Kernel::System::SysConfig->new(%CommonObject);
$CommonObject{UserObject}         = Kernel::System::User->new(%CommonObject);
$CommonObject{GroupObject}        = Kernel::System::Group->new(%CommonObject);
$CommonObject{CustomerUserObject} = Kernel::System::CustomerUser->new(%CommonObject);
$CommonObject{ServiceObject}      = Kernel::System::Service->new(%CommonObject);
$CommonObject{SLAObject}          = Kernel::System::SLA->new(%CommonObject);

my $Config = {

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
            UserFirstname => 'agent-1',
            UserLastname  => 'agent-1',
            UserLogin     => 'agent-1',
            UserPw        => 'agent-1',
            UserEmail     => 'ilizoran@yahoo.com',
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
        },
        {
            UserFirstname  => 'Steva',
            UserLastname   => 'Stevic',
            UserLogin      => 'steva',
            UserPassword   => 'steva',
            UserEmail      => 'svik@s7designcreative.com',
        },
        {
            UserFirstname  => 'customer-1',
            UserLastname   => 'customer-1',
            UserLogin      => 'customer-1',
            UserPassword   => 'customer-1',
            UserEmail      => 'vmajkic@s7designcreative.com',
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
};

# Add Agents
AGENT:
for my $Agent ( @{ $Config->{Agents} } ) {

    next AGENT if !$Agent;
    next AGENT if !%{$Agent};

    # check if this user already exists
    my %User = $CommonObject{UserObject}->GetUserData(
        User => $Agent->{UserLogin},
    );
    if ( $User{UserID} ) {
        print STDERR "Agent '$Agent->{UserLogin}' already exists. Continue...\n";
        next AGENT;
    }

    my $UserID = $CommonObject{UserObject}->UserAdd(
        %{$Agent},
        ValidID      => 1,
        ChangeUserID => 1,
    );

    my %Groups = $CommonObject{GroupObject}->GroupList(
        Valid => 1,
    );

    if ($UserID) {
        for my $GroupID (keys %Groups) {
            my $Success = $CommonObject{GroupObject}->GroupMemberAdd(
                GID        => $GroupID,
                UID        => $UserID,
                Permission => {
                    rw => 1,
                },
                UserID => 1,
            );
        }
        print STDERR "Agent $UserID has been created.\n";
    }
}

my $TestCustomerID    = "FirstCID";
my $TestCompanyName   = "First Company";

my $CustomerCompanyID = $Kernel::OM->Get('Kernel::System::CustomerCompany')->CustomerCompanyAdd(
    CustomerID              => $TestCustomerID,
    CustomerCompanyName     => $TestCompanyName,
    CustomerCompanyStreet   => '5201 Blue Lagoon Drive',
    CustomerCompanyZIP      => '33126',
    CustomerCompanyCity     => 'Miami',
    CustomerCompanyCountry  => 'USA',
    CustomerCompanyURL      => 'http://www.example.org',
    CustomerCompanyComment  => 'some comment',
    ValidID                 => 1,
    UserID                  => 123,
);

# Add Customers
CUSTOMER:
for my $Customer ( @{ $Config->{Customers} } ) {

    next CUSTOMER if !$Customer;
    next CUSTOMER if !%{$Customer};

    # check if this user already exists
    my %User = $CommonObject{CustomerUserObject}->CustomerUserDataGet(
        User => $Customer->{UserLogin},
    );
    if ( $User{UserID} ) {
        print STDERR "Customer '$Customer->{UserLogin}' already exists. Continue...\n";
        next CUSTOMER;
    }

    my $UserID = $CommonObject{CustomerUserObject}->CustomerUserAdd(
        %{$Customer},
        UserCustomerID => $CustomerCompanyID,
        Source  => 'CustomerUser',
        ValidID => 1,
        UserID  => 1,
    );

    if ($UserID) {
        print STDERR "Customer $UserID has been created.\n";
    }
}

# Enable Service
$CommonObject{SysConfigObject}->WriteDefault();

# define the ZZZ files
my @ZZZFiles = (
    'ZZZAAuto.pm',
    'ZZZAuto.pm',
);

# reload the ZZZ files (mod_perl workaround)
for my $ZZZFile (@ZZZFiles) {
    PREFIX:
    for my $Prefix (@INC) {
        my $File = $Prefix . '/Kernel/Config/Files/' . $ZZZFile;
        next PREFIX if !-f $File;
        do $File;
        last PREFIX;
    }
}
my $Success = $CommonObject{SysConfigObject}->ConfigItemUpdate(
    Valid => 1,
    Key   => 'Ticket::Service',
    Value => 1,
);

# Add Services
my %ServicesNameToID;
SERVICE:
for my $Service ( @{ $Config->{Services} } ) {

    next SERVICE if !$Service;
    next SERVICE if !%{$Service};

    # check if this service already exists
    my $ExistingServiceID = $CommonObject{ServiceObject}->ServiceLookup(
        Name => $Service->{Name},
    );

    if ($ExistingServiceID) {
        print STDERR "Service '$Service->{Name}' already exists. Continue...\n";
        next SERVICE;
    }

    my $ServiceID = $CommonObject{ServiceObject}->ServiceAdd(
        %{$Service},
        ValidID => 1,
        UserID  => 1,
    );

    if ($ServiceID) {
        print STDERR "Service $ServiceID has been created.\n";
        $ServicesNameToID{ $Service->{Name} } = $ServiceID;
    }

    # add service as defalut service for all customers
    $CommonObject{ServiceObject}->CustomerUserServiceMemberAdd(
        CustomerUserLogin => '<DEFAULT>',
        ServiceID         => $ServiceID,
        Active            => 1,
        UserID            => 1,
    );
}

# Add SLAs and connect them with the Services
SLA:
for my $SLA ( @{ $Config->{SLAs} } ) {

    next SLA if !$SLA;
    next SLA if !%{$SLA};

    # check if this service already exists
    my $ExistingSLAID = $CommonObject{SLAObject}->SLALookup(
        Name => $SLA->{Name},
    );

    if ($ExistingSLAID) {
        print STDERR "SLA '$SLA->{Name}' already exists. Continue...\n";
        next SLA;
    }

    # Get Services that this SLA should be connected with
    my @ServiceIDs;
    for my $Service ( sort keys %ServicesNameToID ) {
        if ( grep { $_ eq $Service } @{ $SLA->{ServiceNames} } ) {
            push @ServiceIDs, $ServicesNameToID{$Service};
        }
    }
    delete $SLA->{ServiceNames};

    my $SLAID = $CommonObject{SLAObject}->SLAAdd(
        %{$SLA},
        ServiceIDs => \@ServiceIDs,
        ValidID    => 1,
        UserID     => 1,
    );

    if ($SLAID) {
        print STDERR "SLA $SLAID has been created.\n";
    }
}

1;
