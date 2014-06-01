#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::NAVIGATION;
use CGI;
use TEMPLATE;
use ERRORS;


my $cgi = CGI->new;
my $action = $params->{action} || "none";
my $name = $params->{name};
my $password = $params->{password};
my $auth_failed_redirect = $params->{auth_failed} || 0;

#debug($cgi);

$auth_failed_redirect = 1 if $action eq "in";

my $ltasker = $params->{ltasker}(auth_failed_redirect => $auth_failed_redirect);

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

