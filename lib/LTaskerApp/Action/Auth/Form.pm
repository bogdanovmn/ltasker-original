package LTaskerApp::Action::Auth::Form;

use strict;
use warnings;
use utf8;


sub main {
	my ($class, $params) = @_;

	return {
		error_msg => $params->{ltasker}->last_error,
	};
}

1;
