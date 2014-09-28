package LTaskerApp::Action::Auth::Post;

use strict;
use warnings;
use utf8;


sub main {
	my ($self) = @_;

	my $ltasker  = $self->params->{ltasker};
	my $name     = $self->params->{name};
	my $password = $self->params->{password};

	return $ltasker->login(user_name => $name, password => $password);
}

1;
