package LTaskerApp::Action::Auth::Form;

use strict;
use warnings;
use utf8;


sub main {
	my ($self) = @_;

	return {
		error_msg => $self->params->{ltasker}->last_error,
	};
}

1;
