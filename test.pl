#!/usr/local/bin/perl -w
use Net::SMTP;

$smtp = Net::SMTP->new(
                    Host => 'mail.s7designcreative.com',
                    Hello => 'my.mail.domain',
                    Timeout => 30,
                    Debug   => 1,
);

$smtp->mail('zilibasic@s7designcreative.com');
$smtp->to('vmajkic@s7designcreative.com');

$smtp->data();

$smtp->datasend("Subject: Test send mail\n");
$smtp->datasend("To: vmajkic\@s7designcreative.com\n");
$smtp->datasend("From: zilibasic\@s7designcreative.com\n");
$smtp->datasend("\n");
$smtp->datasend("A simple test message\n");
$smtp->datasend("A simple test message\n");
$smtp->datasend("A simple test message\n");
$smtp->datasend("A simple test message\n");
$smtp->datasend("A simple test message\n");
$smtp->dataend();

$smtp->message();
$smtp->quit;
1;

