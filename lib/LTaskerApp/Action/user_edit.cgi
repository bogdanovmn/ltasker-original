#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::NAVIGATION;
use LTASKER::AUTH;
use LTASKER::USER;
use CGI;
use TEMPLATE;
use ERRORS;

my %error_codes = (
	1 => "Пароль введен неверно!",
	2 => "Необходимо заполнить все поля!"
);

my $cgi = CGI->new;
my $action = $cgi->param('action') || "none";
my $user_id= $cgi->param('user_id');
my $name = $cgi->param('login');
my $email = $cgi->param('email');
my $password = $cgi->param('password');
my $password_verify = $cgi->param('password_verify');
my $error_code = $cgi->param('error');

#debug($cgi);

my $auth = LTASKER::AUTH->info;
my $user = LTASKER::USER->choose($auth->user_data->{user_id});

if ($auth->success_in) {
	if ($action eq "update") {
		$user->update(
			name => $name,
			email => $email
		);
		lt_goto(URL_USER);
	}
	else {
		my $tpl = TEMPLATE->new('user_edit.tpl');
		$tpl->params(
			user_view => 1,
			new => $action eq "edit" ? undef : 1,
			error_msg => $error_codes{$error_code},
			%{$auth->user_data}
		);
		$tpl->show;
		exit;
	}
}
else {
	if ($action eq "add") {
		lt_goto(URL_USER_EDIT, error => 1) if ($password_verify ne $password);
		lt_goto(URL_USER_EDIT, error => 2) if (!$name or !$email or !$password);
		
		$user->add(name => $name, email => $email, password => $password);
		lt_goto(URL_LOGIN);
	}
}

my $tpl = TEMPLATE->new('user_edit.tpl');
$tpl->params(
	user_view => 1,
	new => $action eq "edit" ? undef : 1,
	error_msg => $error_codes{$error_code},
	%{$auth->user_data}
);
$tpl->show;
