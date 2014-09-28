package LTaskerApp::Action::User::View;

use strict;
use warnings;
use utf8;

use LTasker::User;


sub main {
	my ($self) = @_;

	my $ltasker = $self->params->{ltasker};

	return {
		user_view => 1,
	};
}

1;
