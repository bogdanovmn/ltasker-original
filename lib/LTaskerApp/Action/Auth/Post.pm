package LTaskerApp::Action::Auth::Post;

use strict;
use warnings;
use utf8;


sub main {
	my ($class, $params) = @_;

	my $ltasker  = $params->{ltasker};
	my $name     = $params->{name};
	my $password = $params->{password};

	return $ltasker->login(user_name => $name, password => $password);
}

1;
