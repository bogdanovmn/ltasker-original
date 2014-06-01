#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::NAVIGATION;
use LTasker::User;
use TEMPLATE;
use ERRORS;

my $ltasker = $params->{ltasker};

my $tpl = TEMPLATE->new('user.tpl');
return {
	user_view => 1,
	%{$ltasker->user_data}
);
$tpl->show;
