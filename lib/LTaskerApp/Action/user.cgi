#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::NAVIGATION;
use LTASKER::USER;
use TEMPLATE;
use ERRORS;

my $ltasker = LTASKER->enter;

my $tpl = TEMPLATE->new('user.tpl');
$tpl->params(
	user_view => 1,
	%{$ltasker->user_data}
);
$tpl->show;
