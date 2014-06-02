package LTaskerApp::Action::User::View;

use strict;
use warnings;
use utf8;

use LTasker::User;


sub main {
	my ($class, $params) = @_;

	my $ltasker = $params->{ltasker};

	return {
		user_view => 1,
	};
}

1;
