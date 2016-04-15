# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;
use vars (qw($Self));

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        # get needed objects
        my $OTRSSystemsObject = $Kernel::OM->Get('Kernel::System::OTRSSystems');
        my $Helper            = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # get random ID
        my $RandomID = $Helper->GetRandomID();

        # add customer company
        my $CustomerCompanyID = $Kernel::OM->Get('Kernel::System::CustomerCompany')->CustomerCompanyAdd(
            CustomerID              => "CompanyID" . $RandomID,
            CustomerCompanyName     => "Company" . $RandomID,
            CustomerCompanyStreet   => $RandomID,
            CustomerCompanyZIP      => $RandomID,
            CustomerCompanyCity     => $RandomID,
            CustomerCompanyCountry  => $RandomID,
            CustomerCompanyURL      => 'http://www.example.org',
            CustomerCompanyComment  => 'some comment',
            ValidID                 => 1,
            UserID                  => 1,
        );
        $Self->True(
            $CustomerCompanyID,
            "CustomerCompany with ID $CustomerCompanyID is created!"
        );

        # add customer user
        my $Customer = 'Customer' . $RandomID;
        my $CustomerUserID = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserAdd(
            Source         => 'CustomerUser',
            UserFirstname  => $Customer,
            UserLastname   => $Customer,
            UserCustomerID => $CustomerCompanyID,
            UserLogin      => $Customer,
            UserEmail      => $Customer . '@example.com',
            ValidID        => 1,
            UserID         => 1,
        );
        $Self->True(
            $CustomerUserID,
            "CustomerUser with ID $CustomerUserID is created!"
        );

        my @OTRSSystems;
        my $Count = 1;

        # add otrs systems with different states
        for my $ActivityState (qw( Active Inactive Deregistered Cloned Linked )) {

            my $SystemFQDN = "$ActivityState.mycompany.$RandomID";
            my $SystemDesc = "SeleniumDescription.$ActivityState";
            my $SystemVers = "5.0.$Count";

            my %OTRSSystem = $OTRSSystemsObject->OTRSSystemsAdd(
                SystemType    => 'auto',
                CustomerID    => $CustomerCompanyID,
                UserID        => 1,
                UsedFor       => 'test',
                FQDN          => $SystemFQDN,
                Description   => $SystemDesc,
                ActivityState => $ActivityState,
                OTRSVersion   => $SystemVers,
                OSVersion     => 'Ubuntu 12.04',
            );
            $Self->True(
                $OTRSSystem{SystemID},
                "OTRSSystem $OTRSSystem{SystemID} is created"
            );

            $Count++;

            %{ $OTRSSystem{Check} } = (
                FQDN          => $SystemFQDN,
                Description   => $SystemDesc,
                OTRSVersion   => $SystemVers,
                ActivityState => $ActivityState,
            );

            push @OTRSSystems, \%OTRSSystem;
        }

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate() || die "Did not get test user";
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # navigate to CustomerInformationCenter screen
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentCustomerInformationCenter;CustomerID=$CustomerCompanyID"
        );

        # pass through all activity states (tabs), click on it and checkup table row content
        for my $OTRSSystem (@OTRSSystems) {
            my $TableFQDN        = $OTRSSystem->{Check}->{FQDN};
            my $TableDescription = $OTRSSystem->{Check}->{Description};
            my $TableOTRSVersion = $OTRSSystem->{Check}->{OTRSVersion};
            my $ActivState       = $OTRSSystem->{Check}->{ActivityState};

            $Selenium->find_element(
                "//a[contains(\@id, 'OTRSSystems$ActivState')]"
            )->click();

            # wait until loading has finished (until class "Loading" has gone)
            $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && !$(".Loading").length' );

            $Self->True(
                index( $Selenium->get_page_source(),
                    "$TableFQDN" ) > -1,
                "$ActivState - FQDN is correct!",
            );
            $Self->True(
                index( $Selenium->get_page_source(),
                    "$TableDescription" ) > -1,
                "$ActivState - Description is correct!",
            );
            $Self->True(
                index( $Selenium->get_page_source(),
                    "$TableOTRSVersion" ) > -1,
                "$ActivState - OTRSVersion is correct!",
            );
        }

        # delete test created OTRSSystems
        my $Success;
        for my $OTRSSystemDelete (@OTRSSystems) {
            $Success = $OTRSSystemsObject->OTRSSystemsDelete(
                SystemID => $OTRSSystemDelete->{SystemID},
            );
            $Self->True(
                $Success,
                "OTRSSystemID $OTRSSystemDelete->{SystemID} is deleted!"
            );
        }

        # delete test created customer user
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
        $Success = $DBObject->Do(
            SQL  => "DELETE FROM customer_user WHERE login = ?",
            Bind => [ \$Customer ],
        );
        $Self->True(
            $Success,
            "CustomerUser $Customer is deleted!",
        );

        # delete test created customer company
        $Success = $DBObject->Do(
            SQL  => "DELETE FROM customer_company WHERE customer_id = ?",
            Bind => [ \$CustomerCompanyID ],
        );
        $Self->True(
            $Success,
            "CustomerCompany $CustomerCompanyID is deleted!",
        );

        # cleanup cache
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp();
    }
);

1;