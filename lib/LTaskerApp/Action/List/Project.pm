package LTaskerApp::Action::List::Project;

use strict;
use warnings;
use utf8;

sub main {
	my ($self) = @_;
	
	return {
		projects => $self->params->{ltasker}->load_projects
	};
}

1;
