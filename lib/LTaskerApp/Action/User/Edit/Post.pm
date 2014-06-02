package LTaskerApp::Action::User::Edit::Post;

use strict;
use warnings;
use utf8;

use LTasker::User;


sub main {
	my ($class, $params) = @_;
	
	my $ltasker  = $params->{ltasker};
	my $user_id  = $params->{user_id};
	my $name     = $params->{login};
	my $email    = $params->{email};
	my $password = $params->{password};
	my $password_verify = $params->{password_verify};

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
