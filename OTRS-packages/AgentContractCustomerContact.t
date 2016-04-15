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
        my $Helper         = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $ContractObject = $Kernel::OM->Get('Kernel::System::Contract');

        # get random ID
        my $RandomID = $Helper->GetRandomID();

        # get current time
        my $CurrentTime = $Kernel::OM->Get('Kernel::System::Time')->CurrentTimestamp();

        # add customer company
        my $CustomerCompanyID = $Kernel::OM->Get('Kernel::System::CustomerCompany')->CustomerCompanyAdd(
            CustomerID             => "CompanyID" . $RandomID,
            CustomerCompanyName    => "Company" . $RandomID,
            CustomerCompanyStreet  => $RandomID,
            CustomerCompanyZIP     => $RandomID,
            CustomerCompanyCity    => $RandomID,
            CustomerCompanyCountry => $RandomID,
            CustomerCompanyURL     => 'http://www.example.org',
            CustomerCompanyComment => 'some comment',
            ValidID                => 1,
            UserID                 => 1,
        );
        $Self->True(
            $CustomerCompanyID,
            "CustomerCompany with ID $CustomerCompanyID is created!"
        );

        # create customer users
        my @CustomerUsers;
        for my $Item ( 1 .. 2 ) {
            my $CustomerUser   = $Item . 'CustomerUser' . $RandomID;
            my $CustomerUserID = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserAdd(
                Source         => 'CustomerUser',
                UserFirstname  => $CustomerUser,
                UserLastname   => $CustomerUser,
                UserCustomerID => $CustomerCompanyID,
                UserLogin      => $CustomerUser,
                UserPassword   => $CustomerUser,
                UserEmail      => $CustomerUser . '@test.com',
                ValidID        => 1,
                UserID         => 1,
            );

            $Self->True(
                $CustomerUserID,
                "CustomerUser (ID = $CustomerUserID) is created!",
            );

            push @CustomerUsers, $CustomerUser;
        }

        # add contract type
        my $ContractTypeID = $ContractObject->ContractTypeAdd(
            UniqueName   => "ContractType.$RandomID",
            Name         => "Name.$RandomID",
            Label        => "ContractType",
            Dependencies => {
                OTRSSubsidiaries => [ 'OTRS AG', 'OTRS B.V.', ],
                SalesChannels    => ['direct'],
            },
            GeneralConfig => {
                Costcenter => '1100',
            },
            FieldConfig => [],
            PDFConfig   => {
                Template => 'Standard',
                Content  => 'Default',
            },
            State  => 'sellable',
            UserID => 1,
        );
        $Self->True(
            $ContractTypeID,
            "ContractType (ID = $ContractTypeID) is created!"
        );

        # add contract
        my $ContractID = $ContractObject->ContractAdd(
            State                             => 'active',
            SalesChannel                      => 'direct',
            OTRSSubsidiary                    => 'OTRS AG',
            TypeID                            => $ContractTypeID,
            IntialPeriod                      => 12,
            DiscountInitialPeriod             => 0,
            RenewalPeriod                     => 12,
            AutoRenewal                       => 1,
            Volume                            => '3995',
            Currency                          => 'EUR',
            IncludedFeatureAddOns             => '2',
            BugEscalation                     => '1',
            ServiceRequest                    => '20',
            CustomerID                        => $CustomerCompanyID,
            EndCustomerID                     => $CustomerCompanyID,
            SupportStartDate                  => $CurrentTime,
            UserID                            => 1,
            DynamicField_CCustomerUserContact => [ $CustomerUsers[0] ],
        );
        $Self->True(
            $ContractID,
            "Contract (ID = $ContractID) is created!"
        );

        # create test user
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users', 'contract', 'contract-verify', 'contract-support-contact-user' ],
        ) || die "Did not get test user";

        # login
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # define nonexisting contract id
        my $NonexistingContractID = $ContractID + 1;

        my @Tests = (
            {
                Description => "Case 1 - with no contractID",
                Action      => "AgentContractCustomerContact",
                Message     => "Can't show customer contact screen, as no ContractID is given!",
            },
            {
                Description => "Case 2 - with nonexisting contractID",
                Action      => "AgentContractCustomerContact;ContractID=$NonexistingContractID",
                Message     => "Contract '$NonexistingContractID' not found in the data base!",
            },
        );

        # run tests
        for my $Test (@Tests) {
            my $Description = $Test->{Description};
            my $Action      = $Test->{Action};
            my $Message     = $Test->{Message};

            $Selenium->VerifiedGet(
                "${ScriptAlias}index.pl?Action=$Action"
            );

            $Self->True(
                index(
                    $Selenium->get_page_source(),
                    "$Message"
                    ) > -1,
                "$Description",
            );
        }

        # navigate to AgentContractZoom with contractID
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentContractZoom;ContractID=$ContractID"
        );

        my $EligibleUser = "\"$CustomerUsers[0] $CustomerUsers[0]\" - $CustomerUsers[0]\@test.com";

        $Self->True(
            index(
                $Selenium->get_page_source(),
                $EligibleUser
                ) > -1,
            "Eligible User exists on screen!",
        );

        # click on 'Eligible User' menu button and open popup
        $Selenium->find_element(
            "//a[contains(\@href, 'Action=AgentContractCustomerContact;ContractID=$ContractID')]"
        )->click();

        # switch to popup
        $Selenium->WaitFor( WindowCount => 2 );
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && $(".CancelClosePopup").length' );

        # change eligible user
        $Selenium->execute_script(
            "\$('#DynamicField_CCustomerUserContact').val('$CustomerUsers[1]').trigger('redraw.InputField').trigger('change');"
        );

        # submit
        $Selenium->find_element("//button[\@value='Update'][\@type='submit']")->click();

        # switch back to window
        $Selenium->WaitFor( WindowCount => 1 );
        $Selenium->switch_to_window( $Handles->[0] );

        # check if eligible user is changed
        $EligibleUser = "\"$CustomerUsers[1] $CustomerUsers[1]\" - $CustomerUsers[1]\@test.com";

        $Self->True(
            index(
                $Selenium->get_page_source(),
                $EligibleUser
                ) > -1,
            "Changed Eligible User exists on screen!",
        );

        # delete test created Contract
        my $Success = $ContractObject->ContractDelete(
            ContractID => $ContractID,
            UserID     => 1,
        );
        $Self->True(
            $Success,
            "ContractID $ContractID is deleted"
        );

        # get DB object
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

        # delete test created ContractType dependencies
        $Success = $DBObject->Do(
            SQL  => "DELETE FROM contract_type_dependencies WHERE type_id = ?",
            Bind => [ \$ContractTypeID ],
        );
        $Self->True(
            $Success,
            "ContractType dependencies are deleted",
        );

        # delete test created ContractType
        $Success = $DBObject->Do(
            SQL  => "DELETE FROM contract_type WHERE id = ?",
            Bind => [ \$ContractTypeID ],
        );
        $Self->True(
            $Success,
            "ContractTypeID $ContractTypeID is deleted",
        );

        # make sure cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'Contract*',
        );
    }
);

1;
