package LTaskerApp::Action::User::Edit::Post;

use strict;
use warnings;
use utf8;

use LTasker::User;


sub main {
	my ($self) = @_;
	
	my $ltasker  = $self->params->{ltasker};
	my $user_id  = $self->params->{user_id};
	my $name     = $self->params->{login};
	my $email    = $self->params->{email};
	my $password = $self->params->{password};
	my $password_verify = $self->params->{password_verify};

	my $user = LTasker::User->choose($ltasker->user_data->{user_id});

	if ($ltasker->success_in) {
		return $user->update(
			name  => $name,
			email => $email
		);
	}
	else {
		if ($password_verify ne $password) {
			return $ltasker->error('Пароль подтвержден неверно');
		}

		if (not $name or not $email or not $password) {
			return $ltasker->error('Заполнены не все поля}');
		}
		
		return $user->add(name => $name, email => $email, password => $password);
	}

}

1;
