#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::NAVIGATION;
use CGI;
use TEMPLATE;
use ERRORS;


my $cgi = CGI->new;
my $action = $cgi->param('action') || "none";
my $name = $cgi->param('name');
my $password = $cgi->param('password');
my $auth_failed_redirect = $cgi->param('auth_failed') || 0;

#debug($cgi);

$auth_failed_redirect = 1 if $action eq "in";

my $ltasker = LTASKER->enter(auth_failed_redirect => $auth_failed_redirect);

my $error_msg = $auth_failed_redirect ? "Необходимо прологиниться!" : undef;

if ($ltasker->success_in) {
	if ($action eq "out") {
		$ltasker->logout;
		lt_goto(URL_LOGIN);
	}
	else {
		lt_goto(URL_PROJECTS);
	}
}
else {
	unless ($action eq "in" and $ltasker->login(user_name => $name, password => $password)) {
		$error_msg = $ltasker->login_error_msg
	}
}

my $tpl = TEMPLATE->new('login.tpl');
$tpl->params(
	version => $ltasker->version,
	error_msg => $error_msg,
	auth_failed_redirect => $auth_failed_redirect
);
$tpl->show;

