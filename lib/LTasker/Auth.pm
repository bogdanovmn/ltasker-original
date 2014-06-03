package LTasker::Auth;

use strict;
use warnings;
use utf8;

use Digest::MD5 qw( md5_hex );
use LTasker::User;

use base 'LTasker::DB';

#
# Get login info
#
sub info {
	my ($class, %p) = @_;

	my $self = LTasker::DB::connect($class);

	$self->{user_auth} = 0;
	$self->{user_id}   = 0;
	$self->{session}   = $p{session};

	if ($self->{session}("user_id")) {
		my $user = LTasker::User->choose($self->{session}("user_id"));
		my $user_info = $user->info;
		$self->{user_auth}  = $self->{session}("user_auth"),
		$self->{user_id}    = $self->{session}("user_id"),
		$self->{user_name}  = $user_info->{name},
		$self->{user_email} = $user_info->{email}
	}

	return $self;
}
#
# Login to the system
#
sub login {
	my ($self, %p) = @_;

	if (not $p{user_name} or not $p{password}) {
		return $self->error("Введите логин и пароль!");
	}

	my $user_query_result = $self->query(
		qq| SELECT * FROM user WHERE name = ? AND password_hash = ? |,
		[ $p{user_name}, md5_hex($p{password}) ]
	);	

	if (@$user_query_result) {
		my $user = $user_query_result->[0];
		$self->{session}("user_id", $user->{id});
		$self->{session}("user_auth", 1);
	}
	else {
		return $self->error("Неправильный логин/пароль");
	}

	return 1;
}
#
# Logout from the system
#
sub logout {
	my ($self, %p) = @_; 
	
	$self->{session}->()->destroy;

	return 1;
}
#
#
#
sub success_in {
	my ($self, %p) = @_;
	return $self->{user_auth};
}
#
#
#
sub user_data {
	my ($self, %p) = @_;
	return {
		user_auth  => $self->{user_auth},
		user_id    => $self->{user_id},
		user_name  => $self->{user_name},
		user_email => $self->{user_email}
	};
}

1;
