package LTaskerApp::Action::List::Project;

use strict;
use warnings;
use utf8;

sub main {
	my ($class, $params) = @_;
	
	return {
		projects => $params->{ltasker}->load_projects
	};
}

1;
