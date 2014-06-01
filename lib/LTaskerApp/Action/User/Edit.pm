#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::NAVIGATION;
use LTasker::Auth;
use LTasker::User;
use CGI;
use TEMPLATE;
use ERRORS;

my %error_codes = (
	1 => "Пароль введен неверно!",
	2 => "Необходимо заполнить все поля!"
);

my $cgi = CGI->new;
my $action = $params->{action} || "none";
my $user_id= $params->{user_id};
my $name = $params->{login};
my $email = $params->{email};
my $password = $params->{password};
my $password_verify = $params->{password_verify};
my $error_code = $params->{error};

#debug($cgi);

my $auth = LTasker::Auth->info;
my $user = LTasker::User->choose($auth->user_data->{user_id});

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
		return {
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
return {
	user_view => 1,
	new => $action eq "edit" ? undef : 1,
	error_msg => $error_codes{$error_code},
	%{$auth->user_data}
);
$tpl->show;
