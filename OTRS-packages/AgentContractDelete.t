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
            State                 => 'draft',
            SalesChannel          => 'direct',
            OTRSSubsidiary        => 'OTRS AG',
            TypeID                => $ContractTypeID,
            IntialPeriod          => 12,
            DiscountInitialPeriod => 0,
            RenewalPeriod         => 12,
            AutoRenewal           => 1,
            Volume                => '3995',
            Currency              => 'EUR',
            IncludedFeatureAddOns => '2',
            BugEscalation         => '1',
            ServiceRequest        => '20',
            CustomerID            => 'SeleniumCustomer',
            EndCustomerID         => 'SeleniumCustomer',
            SupportStartDate      => $CurrentTime,
            UserID                => 1,
        );
        $Self->True(
            $ContractID,
            "Contract (ID = $ContractID) is created!"
        );

        # create test user
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users', 'contract', 'contract-verify', 'contract-edit' ],
        ) || die "Did not get test user";

        # login
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # navigate to AgentContractZoom with contractID
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentContractZoom;ContractID=$ContractID"
        );

        # click 'Delete' menu button and open popup
        $Selenium->find_element(
            "//a[contains(\@href, 'Action=AgentContractDelete;ContractID=$ContractID')]"
        )->click();

        # switch to popup
        $Selenium->WaitFor( WindowCount => 2 );
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && $(".CancelClosePopup").length' );

        # check popup
        $Self->True(
            index(
                $Selenium->get_page_source(),
                "Deleting the contract will remove all data irrevocable."
                ) > -1,
            "Popup is correct!",
        );

        # submit deleting
        $Selenium->find_element("//button[\@value='Delete'][\@type='submit']")->click();

        # switch back to window
        $Selenium->WaitFor( WindowCount => 1 );
        $Selenium->switch_to_window( $Handles->[0] );

        # check if deleted contract exists
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentContractZoom;ContractID=$ContractID"
        );

        $Self->True(
            index(
                $Selenium->get_page_source(),
                "ContractID $ContractID not found in database!"
                ) > -1,
            "Contract (ID = $ContractID) doesn't exist in database!",
        );

        # --------------------------------
        # cleanup
        # --------------------------------

        # get DB object
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

        # delete test created ContractType dependencies
        my $Success = $DBObject->Do(
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
