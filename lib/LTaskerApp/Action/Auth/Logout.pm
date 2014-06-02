package LTaskerApp::Action::Auth::Logout;

use strict;
use warnings;
use utf8;


sub main {
	my ($class, $params) = @_;

	my $ltasker = $params->{ltasker};
	
	return $ltasker->logout;
}

1;
