package LTaskerApp::Action::Auth::Logout;

use strict;
use warnings;
use utf8;


sub main {
	my ($class, $params) = @_;

	my $auth_failed_redirect = $params->{auth_failed} || 0;

	$auth_failed_redirect = 1 if $action eq "in";

	my $ltasker = $params->{ltasker}(auth_failed_redirect => $auth_failed_redirect);

	my $error_msg = $auth_failed_redirect ? "Необходимо прологиниться!" : undef;

	if ($ltasker->success_in) {
		if ($action eq "out") {
			return $ltasker->logout;
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

	return {
		error_msg => $error_msg,
		auth_failed_redirect => $auth_failed_redirect
	};
}

1;
