# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use vars (qw($Self));
use utf8;

use Kernel::System::VariableCheck qw(:all);

my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

# set attribute
$ConfigObject->Set(
    Key   => 'TimeWorkingHours',
    Value => {

        # calendar 1 setup
        # 24 hours working time, Mo - Su
        'Mon' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Tue' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Wed' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Thu' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Fri' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Sat' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
        'Sun' => [
            '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '10', '11',
            '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
        ],
    },
);
$ConfigObject->Set(

    # no holidays
    Key   => 'TimeVacationDays',
    Value => {},
);
$ConfigObject->Set(

    # no holidays
    Key   => 'TimeVacationDaysOneTime',
    Value => {},
);
$ConfigObject->Set(

    # no holidays
    Key   => 'OTRSTimeZone',
    Value => 'Europe/Berlin',
);

my $CalendarData = {
    1 => {

        # calendar 1 setup
        # 8-17 (08:00:00 - 16:59:59) working time, Mo - Fr, regular holidays
        'TimeWorkingHours' => {
            'Mon' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Tue' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Wed' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Thu' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Fri' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Sun' => [],
            'Sat' => [],
        },
        'TimeVacationDays' => {
            '1' => {
                '1' => 'New Year\'s Day'
            },
            '5' => {
                '1' => 'International Workers\' Day'
            },
            '12' => {
                '24' => 'Christmas Eve',
                '25' => 'First Christmas Day',
                '26' => 'Second Christmas Day',
                '31' => 'New Year\'s Eve'
            },
        },
        'TimeVacationDaysOneTime' => {},
        'TimeZone'                => 'Europe/Berlin',
    },

    2 => {

        # calendar 2 setup
        # 8-17 (08:00:00 - 16:59:59) working time, Mo - Fr, regular holidays
        'TimeWorkingHours' => {
            'Mon' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Tue' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Wed' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Thu' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Fri' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Sun' => [],
            'Sat' => [],
        },
        'TimeVacationDays' => {
            '1' => {
                '1' => 'New Year\'s Day'
            },
            '5' => {
                '1' => 'International Workers\' Day'
            },
            '12' => {
                '24' => 'Christmas Eve',
                '25' => 'First Christmas Day',
                '26' => 'Second Christmas Day',
                '31' => 'New Year\'s Eve'
            },
        },
        'TimeVacationDaysOneTime' => {
        },

        # Calendar 2 is UTC+3, OTRSTimeZone is UTC+2
        'TimeZone' => 'Europe/Sofia',
    },
    3 => {

        # calendar 3 setup
        # 8-17 (08:00:00 - 16:59:59) working time, Mo - Fr, regular holidays
        'TimeWorkingHours' => {
            'Mon' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Tue' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Wed' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Thu' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Fri' => [ '8', '9', '10', '11', '12', '13', '14', '15', '16' ],
            'Sun' => [],
            'Sat' => [],
        },
        'TimeVacationDays' => {
            '1' => {
                '1' => 'New Year\'s Day'
            },
            '5' => {
                '1' => 'International Workers\' Day'
            },
            '12' => {
                '24' => 'Christmas Eve',
                '25' => 'First Christmas Day',
                '26' => 'Second Christmas Day',
                '31' => 'New Year\'s Eve'
            },
        },
        'TimeVacationDaysOneTime' => {
        },

        # Calendar 3 is UTC-6
        'TimeZone' => 'America/Mexico_City',
    },
};

# set up calendar data
for my $CalendarNumber ( %{$CalendarData} ) {
    for my $Attribute ( sort keys %{ $CalendarData->{$CalendarNumber} } ) {

        # set attribute
        $ConfigObject->Set(
            Key   => $Attribute . '::Calendar' . $CalendarNumber,
            Value => $CalendarData->{$CalendarNumber}->{$Attribute},
        );
    }
}

my $TimeDiff = sub {
    my ( $TimeStamp1, $TimeStamp2 ) = @_;

    my $DateTimeObject1 = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $TimeStamp1,
        },
    );

    my $DateTimeObject2 = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $TimeStamp2,
        },
    );

    return $DateTimeObject1->ToEpoch() - $DateTimeObject2->ToEpoch();
};

# EscalationTime tests
my @EscalationTime = (

    # MINUTES tests, no calendar
    {
        Name             => 'Test A-01: Escalation after 3 minutes, within the same real day (no calendar)',
        StartTime        => '2013-04-11 12:15:00',
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '',
        TimeSpan         => 3,
        EndTime          => '2013-04-11 12:18:00',
    },

    {
        Name             => 'Test A-02: Escalation after 3 minutes, within the same real day (no calendar)',
        StartTime        => '2013-04-11 12:15:30',
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '',
        TimeSpan         => 3,
        EndTime          => '2013-04-11 12:18:30',
    },
    {
        Name =>
            'Test A-03: Escalation after 3 minutes (round up), within the same real day (no calendar)',
        StartTime          => '2013-04-11 12:15:30',
        StartTimeRoundUp   => '1',
        TimeUnit           => 'm',
        Calendar           => '',
        TimeSpan           => 3,
        EndTime            => '2013-04-11 12:19:00',
        EndTimeMinus       => '2013-04-11 12:15:00',
        RemainingTime      => 210,
        RemainingTimeMinus => -210,
    },
    {
        Name =>
            'Test A-04: Escalation after 10 minutes, start on monday evening (1 day before christmas eve, no calendar)',
        StartTime        => '2013-12-23 16:55:00',    # monday evening
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '',
        TimeSpan         => 10,
        EndTime          => '2013-12-23 17:05:00',    # still monday evening
    },

    # MINUTES tests, calendar with 8-17 working time (Mo - Fr), regular holidays
    {
        Name =>
            'Test B-01: Escalation after 3 minutes, reach in the next working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 16:58:00',    # thursday evening
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '1',
        TimeSpan         => 3,
        EndTime          => '2013-04-12 08:01:00',    # friday morning
    },
    {
        Name =>
            'Test B-02: Escalation after 3 minutes, reach in the next working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 16:57:00',    # thursday evening
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '1',
        TimeSpan         => 3,
        EndTime          => '2013-04-12 08:00:00',    # friday morning
    },
    {
        Name =>
            'Test B-03: Escalation after 10 minutes, start on monday evening (1 day before christmas eve), jump over holidays (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-12-23 16:55:00',    # monday evening
        StartTimeRoundUp => '0',
        TimeUnit         => 'm',
        Calendar         => '1',
        TimeSpan         => 10,
        EndTime          => '2013-12-27 08:05:00',    # friday morning (beginning of next working day)
    },

    # HOURS tests, no calendar
    {
        Name             => 'Test C-01: Escalation after 4 hours, within the same real day (no calendar)',
        StartTime        => '2013-04-11 12:15:00',
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '',
        TimeSpan         => 4,
        EndTime          => '2013-04-11 16:15:00',
        NoCalendar       => 1,
    },
    {
        Name             => 'Test C-02: Escalation after 16 hours, reach into next real day (no calendar)',
        StartTime        => '2013-04-11 12:15:00',
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '',
        TimeSpan         => 16,
        EndTime          => '2013-04-12 04:15:00',
        NoCalendar       => 1,
    },
    {
        Name             => 'Test C-03: Escalation after 24 hours, reach into next real day (no calendar)',
        StartTime        => '2013-04-11 12:15:00',
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '',
        TimeSpan         => 24,
        EndTime          => '2013-04-12 12:15:00',
    },
    {
        Name      => 'Test C-04: Escalation after 24 hours, reach into next real day (no calendar)',
        StartTime => '2013-04-11 12:15:00',
        StartTimeRoundUp   => '1',                     # use round up
        TimeUnit           => 'h',
        Calendar           => '',
        TimeSpan           => 24,
        EndTime            => '2013-04-12 13:00:00',
        EndTimeMinus       => '2013-04-11 12:00:00',
        RemainingTime      => 89100,
        RemainingTimeMinus => -89100,
    },

    # HOURS tests, calendar with 8-17 working time (Mo - Fr), regular holidays
    {
        Name =>
            'Test D-01: Escalation after 4 hours, within the same working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 12:15:00',    # thursday morning
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '1',
        TimeSpan         => 4,
        EndTime          => '2013-04-11 16:15:00',    # thursday afternoon
    },
    {
        Name =>
            'Test D-02: Escalation after 8 hours, reach into next working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 12:15:00',    # thursday morning
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '1',
        TimeSpan         => 8,
        EndTime          => '2013-04-12 11:15:00',    # friday morning
    },
    {
        Name =>
            'Test D-03: Escalation after 10 hours, start on friday morning, reach into next week (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-12 10:15:00',    # friday morning
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '1',
        TimeSpan         => 10,
        EndTime          => '2013-04-15 11:15:00',    # monday morning
    },
    {
        Name =>
            'Test D-04: Escalation after 10 hours (with round up), start on friday morning, reach into next week (8-17/Mo-Fr/holidays)',
        StartTime => '2013-04-12 10:15:00'
        ,    # friday morning, escalation should start on 11:00:00 due to round up
        StartTimeRoundUp   => '1',                      # use round up!
        TimeUnit           => 'h',
        Calendar           => '1',
        TimeSpan           => 10,
        EndTime            => '2013-04-15 12:00:00',    # monday morning
        EndTimeMinus       => '2013-04-12 10:00:00',    # monday morning
        RemainingTime      => 38700,
        RemainingTimeMinus => -38700,
    },
    {
        Name =>
            'Test D-05: Escalation after 24 hours (with round up), start on friday morning, reach into next week (8-17/Mo-Fr/holidays)',
        StartTime => '2013-04-12 10:15:00',

        # friday morning, escalation should start on 11:00:00 due to round up
        StartTimeRoundUp   => '1',                      # use round up!
        TimeUnit           => 'h',
        Calendar           => '1',
        TimeSpan           => 24,
        EndTime            => '2013-04-17 08:00:00',    # wednesday morning
        EndTimeMinus       => '2013-04-12 11:00:00',    # wednesday morning
        RemainingTime      => 89100,
        RemainingTimeMinus => -89100,
    },
    {
        Name =>
            'Test D-06: Escalation after 7 hours, start on monday morning (1 day before christmas eve), jump over holidays (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-12-23 10:15:00',      # monday morning
        StartTimeRoundUp => '0',
        TimeUnit         => 'h',
        Calendar         => '1',
        TimeSpan         => 7,
        EndTime          => '2013-12-27 08:15:00',      # friday morning (first working day after holidays)
    },
    {
        Name =>
            'Test D-07: Escalation after 7 hours (with round up), start on monday morning (1 day before christmas eve), jump over holidays (8-17/Mo-Fr/holidays)',
        StartTime => '2013-12-23 10:15:00'
        ,    # monday morning, escalation should start on 11:00:00 due to round up
        StartTimeRoundUp   => '1',                      # use round up!
        TimeUnit           => 'h',
        Calendar           => '1',
        TimeSpan           => 7,
        EndTime            => '2013-12-27 09:00:00',    # friday morning (first working day after holidays)
        EndTimeMinus       => '2013-12-23 10:00:00',
        RemainingTime      => 27900,
        RemainingTimeMinus => -27900,
    },

    # DAYS tests (round up should be implicit), no calendar
    {
        Name             => 'Test E-01: Escalation after 1 day, end of next real day (no calendar)',
        StartTime        => '2013-04-11 12:15:00',                                                    # thursday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '',
        TimeSpan         => 1,
        EndTime          => '2013-04-13 00:00:00',                                                    # friday evening
        EndTimeMinus     => '2013-04-11 00:00:00',                                                    # friday evening
        NoCalendar       => 1,
    },
    {
        Name      => 'Test E-02: Escalation after 2 days, end of after next real day (no calendar)',
        StartTime => '2013-04-11 12:15:00',                                                           # thursday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '',
        TimeSpan         => 2,
        EndTime          => '2013-04-14 00:00:00',                                                    # saturday evening
        EndTimeMinus     => '2013-04-11 00:00:00',                                                    # saturday evening
        NoCalendar       => 1,
    },

    # DAYS tests (round up should be implicit), calendar with 8-17 working time (Mo - Fr), regular holidays
    {
        Name => 'Test F-01: Escalation after 1 day, end of next working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 12:15:00',                                                    # thursday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '1',
        TimeSpan         => 1,
        EndTime          => '2013-04-12 17:00:00',                                                    # friday evening
        EndTimeMinus     => '2013-04-10 17:00:00',                                                    # friday evening
    },
    {
        Name =>
            'Test F-02: Escalation after 2 days, end of after next working day (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-04-11 12:15:00',                                                    # thursday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '1',
        TimeSpan         => 2,
        EndTime          => '2013-04-15 17:00:00',                                                    # monday evening
        EndTimeMinus     => '2013-04-10 17:00:00',                                                    # monday evening
    },
    {
        Name =>
            'Test F-03: Escalation after 3 days, start on monday morning (1 day before christmas eve), jump over holidays (8-17/Mo-Fr/holidays)',
        StartTime        => '2013-12-23 10:15:00',                                                    # monday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '1',
        TimeSpan         => 3,
        EndTime          => '2014-01-02 17:00:00',
        EndTimeMinus     => '2013-12-20 17:00:00',
    },
    {
        Name               => 'Test F-04: Seconds - end date has higher second value',
        StartTime          => '2014-01-10 10:15:00',
        Calendar           => '1',
        EndTime            => '2014-01-10 10:16:15',
        RemainingTime      => 75,
        RemainingTimeMinus => -75,
    },
    {
        Name               => 'Test F-05: Seconds - end date has lower second value',
        StartTime          => '2014-01-10 10:15:30',
        Calendar           => '1',
        EndTime            => '2014-01-10 10:16:15',
        RemainingTime      => 45,
        RemainingTimeMinus => -45,
    },
    {
        Name               => 'Test F-06: Seconds - end date has equal minute value',
        StartTime          => '2014-01-10 10:15:30',
        Calendar           => '1',
        EndTime            => '2014-01-10 10:15:33',
        RemainingTime      => 3,
        RemainingTimeMinus => -3,
    },
    {
        Name               => 'Test F-07: Seconds - minutes are not equal and seconds are lower',
        StartTime          => '2014-05-16 13:41:13',
        Calendar           => '1',
        EndTime            => '2014-05-16 14:41:11',
        RemainingTime      => 3598,
        RemainingTimeMinus => -3598,
    },
    {
        Name               => 'Test F-07: Seconds - TargetTimeCalculate with seconds',
        StartTime          => '2013-04-11 12:15:00',
        StartTimeRoundUp   => '0',
        TimeUnit           => 's',
        Calendar           => '',
        TimeSpan           => 3705,
        EndTime            => '2013-04-11 13:16:45',
        RemainingTime      => 3705,
        RemainingTimeMinus => -3705,
    },
    {
        Name             => 'Test G-01: Seconds - Wrong UnitTest for old unrefactored calculation',
        StartTime        => '2014-08-26 15:55:00',
        StartTimeRoundUp => '0',
        TimeUnit         => 's',
        Calendar         => '',
        TimeSpan         => 9705933,
        EndTime          => '2014-12-16 23:00:33',
        RemainingTime    => $TimeDiff->(
            '2014-12-16 23:00:33',
            '2014-08-26 15:55:00',
        ),
        RemainingTimeMinus => -9705933,
    },
    {
        Name             => 'Test G-02: Seconds - small change by 2 seconds',
        StartTime        => '2014-08-01 11:12:59',
        StartTimeRoundUp => '0',
        TimeUnit         => 's',
        Calendar         => '',
        TimeSpan         => 2,
        EndTime          => '2014-08-01 11:13:01',
        RemainingTime    => $TimeDiff->(
            '2014-08-01 11:13:01',
            '2014-08-01 11:12:59',
        ),
        RemainingTimeMinus => -2,
    },
    {
        Name =>
            'Test G-03: hard calculation over 2 working weeks in minutes 8 hours a day * 7 days a week * 2 weeks (regard calender has 9 hours a day)',
        StartTime          => '2014-11-13 12:00:00',
        StartTimeRoundUp   => '0',
        TimeUnit           => 'm',
        Calendar           => '1',
        TimeSpan           => 6720,
        EndTime            => '2014-12-01 16:00:00',
        RemainingTime      => 6720 * 60,
        RemainingTimeMinus => 6720 * 60 * -1,
    },
    {
        Name =>
            'Test G-04: hard calculation over 2 working weeks in minutes 8 hours a day * 5 days a week * 2 weeks (regard calender has 9 hours a day)',
        StartTime          => '2014-11-18 16:00:00',
        StartTimeRoundUp   => '0',
        TimeUnit           => 'm',
        Calendar           => '1',
        TimeSpan           => 4800,
        EndTime            => '2014-12-01 15:00:00',
        RemainingTime      => 4800 * 60,
        RemainingTimeMinus => 4800 * 60 * -1,
    },
    {
        Name               => 'Test G-04: Notify rounding stuff 50% of 5 days',
        StartTime          => '2013-04-29 08:00:00',
        StartTimeRoundUp   => '1',
        TimeUnit           => 'd',
        Calendar           => '1',
        TimeSpan           => 2.5,
        EndTime            => '2013-05-02 17:00:00',
        EndTimeMinus       => '2013-04-26 17:00:00',
        RemainingTime      => 60 * 60 * 8 * 5,
        RemainingTimeMinus => 60 * 60 * 8 * 5 * -1,
    },
    {
        Name             => 'Test H-01a: Calendar 2  different that OTRSTimeZone add 2 days with StartTimeRoundUp',
        StartTime        => '2020-11-16 10:15:00',
        TimeUnit         => 'd',
        Calendar         => '2',
        TimeSpan         => 2,
        StartTimeRoundUp => '1',
        EndTime          => '2020-11-18 16:00:00',
    },
    {
        Name      => 'Test H-01b: Calendar 2  different that OTRSTimeZone add 2 days without StartTimeRoundUp',
        StartTime => '2020-11-16 10:15:00',
        TimeUnit  => 'd',
        Calendar  => '2',
        TimeSpan  => 2,
        EndTime   => '2020-11-18 10:15:00',
    },
    {
        Name =>
            'Test H-02: Escalation after 4 days, Calendar 2 different that OTRSTimeZone, start 1 day before christmas eve, jump over holidays (8-17/Mo-Fr/holidays)',
        StartTime        => '2020-12-23 10:15:00',    # monday morning
        StartTimeRoundUp => '1',
        TimeUnit         => 'd',
        Calendar         => '2',
        TimeSpan         => 4,

        # jump to new year because of vacation days
        EndTime => '2021-01-04 16:00:00',
    },
    {
        Name      => 'Test H-03: Calendar 2  different that OTRSTimeZone add 2 hours in working time',
        StartTime => '2020-11-16 10:15:00',
        TimeUnit  => 'h',
        Calendar  => '2',
        TimeSpan  => 2,
        EndTime   => '2020-11-16 12:15:00',
    },
    {
        Name      => 'Test H-04: Calendar 2  different that OTRSTimeZone add 2 hours out of working time',
        StartTime => '2020-11-16 20:15:00',
        TimeUnit  => 'h',
        Calendar  => '2',
        TimeSpan  => 2,
        EndTime   => '2020-11-17 09:00:00',
    },
    {
        Name => 'Test H-05: Calendar 2 different that OTRSTimeZone add 2 hours out of working time with round up time',
        StartTime        => '2020-11-16 20:15:00',
        StartTimeRoundUp => '1',
        TimeUnit         => 'h',
        Calendar         => '2',
        TimeSpan         => 2,
        EndTime          => '2020-11-17 09:00:00',
    },
    {
        Name      => 'Test H-06: Calendar 2  different that OTRSTimeZone add 10 hours in working time',
        StartTime => '2020-11-16 10:15:00',
        TimeUnit  => 'h',
        Calendar  => '2',
        TimeSpan  => 10,
        EndTime   => '2020-11-17 11:15:00',
    },
    {
        Name      => 'Test H-07: Calendar 2  different that OTRSTimeZone add 10 hours out of working time',
        StartTime => '2020-11-16 20:15:00',
        TimeUnit  => 'h',
        Calendar  => '2',
        TimeSpan  => 10,
        EndTime   => '2020-11-18 08:00:00',
    },
    {
        Name      => 'Test H-08: Calendar 2  different that OTRSTimeZone add 120 minutes in working time',
        StartTime => '2020-11-16 10:15:00',
        TimeUnit  => 'm',
        Calendar  => '2',
        TimeSpan  => 120,
        EndTime   => '2020-11-16 12:15:00',
    },
    {
        Name      => 'Test H-09: Calendar 2  different that OTRSTimeZone add 120 minutes out of working time',
        StartTime => '2020-11-16 20:15:00',
        TimeUnit  => 'm',
        Calendar  => '2',
        TimeSpan  => 120,
        EndTime   => '2020-11-17 09:00:00',
    },
    {
        Name => 'Test H-10: Calendar 2  different that OTRSTimeZone add 120 minutes in working time with round up time',
        StartTime        => '2020-11-16 10:15:10',
        StartTimeRoundUp => '1',
        TimeUnit         => 'm',
        Calendar         => '2',
        TimeSpan         => 120,
        EndTime          => '2020-11-16 12:16:00',
    },
    {
        Name => 'Test H-11: Calendar 3  different that OTRSTimeZone add 3 hours in working time without round up time',
        StartTime        => '2020-11-16 13:20:00',
        StartTimeRoundUp => '1',
        TimeUnit         => 'h',
        Calendar         => '3',
        TimeSpan         => 3,

        # End time is always in OTRSTimeZone in this case UTC+1, so it will be local time
        # '2020-11-18 11:00:00' and in OTRSTimeZone for DB '2020-11-16 18:00:00'
        EndTime => '2020-11-16 18:00:00',
    },
    {
        Name      => 'Test H-12: Calendar 3  different that OTRSTimeZone add 2 days in working time with round up time',
        StartTime => '2020-11-16 11:20:10',
        StartTimeRoundUp => '0',
        TimeUnit         => 'd',
        Calendar         => '3',
        TimeSpan         => 2,

        # End time is always in OTRSTimeZone in this case UTC+1, so it will be local time
        # '2020-11-18 17:00:00' and in OTRSTimeZone for DB '2020-11-18 00:00:00'
        EndTime => '2020-11-18 00:00:00',
    },
);

my $Times = {
    'm' => 60,
    'h' => 3600,
};

# get escalation time object
my $EscalationTimeObject = $Kernel::OM->Get('Kernel::System::EscalationTime');

# EscalationTime test
TESTS:
for my $Test (@EscalationTime) {

    # get system time
    my $StartDateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Test->{StartTime},
        },
    );
    my $EndDateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String => $Test->{EndTime},
        },
    );
    my $StartSystemTime = $StartDateTimeObject->ToEpoch();
    my $EndSystemTime   = $EndDateTimeObject->ToEpoch();

    if ( $Test->{TimeUnit} ) {

        # check system time
        if ( $Test->{StartTimeSystem} ) {
            $Self->Is(
                $StartSystemTime,
                $Test->{StartTimeSystem},
                "TimeStamp2SystemTime() - $Test->{Name}",
            );
        }

        # get system destination time based on calendar settings
        my $TargetTimeCalculate = $EscalationTimeObject->TargetTimeCalculate(
            StartDateTime    => $StartDateTimeObject,
            StartTimeRoundUp => $Test->{StartTimeRoundUp},
            TimeUnit         => $Test->{TimeUnit},
            Calendar         => $Test->{Calendar},
            TimeSpan         => $Test->{TimeSpan},
            NoCalendar       => $Test->{NoCalendar},
        )->ToEpoch();

        # check time stamp destination time
        my $DestinationDateTimeObject = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                Epoch => $TargetTimeCalculate,
            },
        );
        $Self->Is(
            $DestinationDateTimeObject->ToString(),
            $Test->{EndTime},
            "EscalationTime() - $Test->{Name} Timestamp",
        );

        # check system destination time
        if ( $Test->{EndTimeSystem} ) {
            $Self->Is(
                $TargetTimeCalculate,
                $Test->{EndTimeSystem},
                "EscalationTime() - $Test->{Name} System time",
            );
        }

        if ( $Test->{EndTimeMinus} ) {

            # get system destination time based on calendar settings
            my $DestinationMinusDateTimeObject = $EscalationTimeObject->TargetTimeCalculate(
                StartDateTime    => $EndDateTimeObject,
                StartTimeRoundUp => $Test->{StartTimeRoundUp},
                TimeUnit         => $Test->{TimeUnit},
                Calendar         => $Test->{Calendar},
                TimeSpan         => $Test->{TimeSpan} * -1,
                NoCalendar       => $Test->{NoCalendar},
            );

            $Self->Is(
                $DestinationMinusDateTimeObject->ToString(),
                $Test->{EndTimeMinus} ? $Test->{EndTimeMinus} : $Test->{StartTime},
                "EscalationTime() - Minus - $Test->{Name}",
            );

        }

        # if ( $Test->{Sleep} ){
        #     sleep 1000;
        # }

        next TESTS if $Test->{TimeUnit} eq 'd';
    }

    if ( $Test->{RemainingTime} ) {

        # calculate remaining time
        my $RemainingTime = $EscalationTimeObject->RemainingTimeCalculate(
            StartTime  => $StartSystemTime,
            StopTime   => $EndSystemTime,
            Calendar   => $Test->{Calendar},
            NoCalendar => $Test->{NoCalendar},
        );

        my $ExpectedRemainingTime = $Test->{RemainingTime}
            || $Test->{TimeSpan} * $Times->{ $Test->{TimeUnit} };

        $Self->Is(
            $RemainingTime,
            $ExpectedRemainingTime,
            "RemainingTime() - $Test->{Name}",
        );

        # calculate remaining time
        my $RemainingTimeMinus = $EscalationTimeObject->RemainingTimeCalculate(
            StartTime  => $EndSystemTime,
            StopTime   => $StartSystemTime,
            Calendar   => $Test->{Calendar},
            NoCalendar => $Test->{NoCalendar},
        );

        my $ExpectedRemainingTimeMinus = $Test->{RemainingTimeMinus}
            || $Test->{TimeSpan} * $Times->{ $Test->{TimeUnit} } * -1;

        $Self->Is(
            $RemainingTimeMinus,
            $ExpectedRemainingTimeMinus,
            "RemainingTime() - Minus - $Test->{Name}",
        );
    }
}

# Test RemainingTimeCalculate when StartTime or StopTime is 0.
my $NoRemainingTime1 = $EscalationTimeObject->RemainingTimeCalculate(
    StartTime => 0,
    StopTime  => '2020-08-06 12:00:00',
);
$Self->False(
    $NoRemainingTime1,
    'RemainingTime is 0 when StartTime is 0.',
);

my $NoRemainingTime2 = $EscalationTimeObject->RemainingTimeCalculate(
    StartTime => '2020-08-06 12:00:00',
    StopTime  => 0,
);
$Self->False(
    $NoRemainingTime2,
    'RemainingTime is 0 when StopTime is 0.',
);

1;
