#!/usr/bin/perl
# --
# bin/otrs.CleanTestUsers.pl - to cleanup, remove used tmp data of ipc, database or fs
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
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

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/otrs/Kernel/cpan-lib';
use lib dirname($RealBin) . '/otrs/Custom';

use Getopt::Std;

use Kernel::System::ObjectManager;
our $ObjectManagerDisabled = 1;

# create object manager
local $Kernel::OM = Kernel::System::ObjectManager->new(
    'Kernel::System::Log' => {
        LogPrefix => 'OTRS-otrs.CleanTestUsers.pl',
    },
);

my $StdOut = $Kernel::OM->Get('Kernel::System::Console::BaseCommand');

# get options
my %Opts;
getopt( '', \%Opts );
if ( $Opts{h} ) {

    $StdOut->Print("<green> otrs.CleanTestUsers.pl - OTRS cleanup test users </green>\n");
    $StdOut->Print("<green> usage: otrs.CleanTestUsers.pl</green>\n");
    exit 1;
}


$StdOut->Print("<yellow>\n\nCleaning up DB ...\n</yellow>");
$StdOut->Print("<yellow>=======================================================================</yellow>");


##############################################
# update test users that was changed during the testing
my $DBObject= $Kernel::OM->Get('Kernel::System::DB');
my $Success = $DBObject->Do(
        SQL => 'UPDATE notifications SET create_by = 1,  change_by=1 WHERE (create_by > 4 OR change_by > 4 )'
    );

$Success = $DBObject->Do(
        SQL => 'UPDATE users SET create_by = 1, change_by = 1 WHERE (create_by > 4 OR change_by > 4 )'
    );

my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
my @TicketIDs = $TicketObject->TicketSearch( UserID => 1);

# ##############################################
# # delete created tickets

$StdOut->Print("<yellow>\n\nCleaning up tickets ...</yellow>");
for my $TicketID ( @TicketIDs ) {
    $StdOut->Print("<green> Deleting ticket - $TicketID </green>\n");
    my $Success = $TicketObject->TicketDelete(
        TicketID => $TicketID,
        UserID   => 1,
    );
}

 if ( $Success ) {
        $StdOut->Print("<green> done</green>\n");
    }
    else {
        $StdOut->Print("<red> failed.</red>\n");
    }
##############################################
# delete service_customer_user

$StdOut->Print("<yellow>Cleaning up service_customer_user ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM service_customer_user '
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# delete created service_preferences

$StdOut->Print("<yellow>Cleaning up service_preferences ...</yellow>");
$Success = $DBObject->Do(
    SQL => "DELETE FROM service_preferences",
);
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################
# delete created dynamic fields

$StdOut->Print("<yellow>Cleaning up dynamic fields ...</yellow>");
$Success = $DBObject->Do(
    SQL => "DELETE FROM dynamic_field WHERE id > 2",
);
$Success = $DBObject->Do(
    SQL => "DELETE FROM dynamic_field_value WHERE field_id > 2",
);
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# delete created sla_preferences

$StdOut->Print("<yellow>Cleaning up sla_preferences ...</yellow>");
$Success = $DBObject->Do(
    SQL => "DELETE FROM sla_preferences",
);
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################

# delete created personal_queues

$StdOut->Print("<yellow>Cleaning up personal_queues ...</yellow>");
$Success = $DBObject->Do(
    SQL => "DELETE FROM personal_queues WHERE ( queue_id > 4 || user_id > 4 )",
);
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################

# delete created queue_preferences

$StdOut->Print("<yellow>Cleaning up queue_preferences ...</yellow>");
$Success = $DBObject->Do(
    SQL => "DELETE FROM queue_preferences",
);
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################
# delete created sla

$StdOut->Print("<yellow>Cleaning up sla ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM sla where id > 2 '
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################
# delete created service

$StdOut->Print("<yellow>Cleaning up service ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM service where id > 2 '
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################
# clean up test users data

$StdOut->Print("<yellow>Cleaning up user_preferences ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM user_preferences where user_id > 4'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up test queue
$StdOut->Print("<yellow>Cleaning up queue ...</yellow>");

$Success = $DBObject->Do(
        SQL => 'DELETE FROM queue where id > 4'
    );

if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up test users data
$StdOut->Print("<yellow>Cleaning up users data from group_user ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM group_user where user_id > 4'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM group_user where group_id > 3'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up stats
$StdOut->Print("<yellow>Cleaning up stats ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM xml_storage where xml_key > 11'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up process data
$StdOut->Print("<yellow>Cleaning up process data ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_activity_dialog'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_entity_sync'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_activity'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_transition'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_transition_action'
    );
$Success = $DBObject->Do(
        SQL => 'DELETE FROM pm_process'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up standard_attachment
$StdOut->Print("<yellow>Cleaning up standard_attachment ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM standard_attachment'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up test customer user preferences
$StdOut->Print("<yellow>Cleaning up customer_preferences ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM customer_preferences WHERE user_id NOT IN ( SELECT login FROM customer_user WHERE id <= 3);'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################


##############################################
# clean up test  group
$StdOut->Print("<yellow>Cleaning up groups ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM groups where id > 3'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################


##############################################
# clean up test customers
$StdOut->Print("<yellow>Cleaning up customer users ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM customer_user where id > 3'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################


##############################################
# clean up test customer company
$StdOut->Print("<yellow>Cleaning up customer_company ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM customer_company where change_by IN  (2,3,4)'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}

##############################################
# clean up test agents
$StdOut->Print("<yellow>Cleaning up users ...</yellow>");
$Success = $DBObject->Do(
        SQL => 'DELETE FROM users where id > 4'
    );
if ( $Success ) {
    $StdOut->Print("<green> done</green>\n");
}
else {
    $StdOut->Print("<red> failed.</red>\n");
}


##############################################
# clean up cache
$Kernel::OM->Get('Kernel::System::Cache')->CleanUp();

$StdOut->Print("<yellow>=======================================================================\n</yellow>");

exit 0;
