#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTasker;
use LTasker::NAVIGATION;
use LTasker::User;
use TEMPLATE;
use ERRORS;

my $ltasker = LTasker->enter;

my $tpl = TEMPLATE->new('user.tpl');
$tpl->params(
	user_view => 1,
	%{$ltasker->user_data}
);
$tpl->show;
