package LTaskerApp::Action::Auth::Logout;

use strict;
use warnings;
use utf8;


sub main {
	my ($self) = @_;

	my $ltasker = $self->params->{ltasker};
	
	return $ltasker->logout;
}

1;
