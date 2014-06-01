package LTASKER::AUTH;

use strict;
use warnings;
use lib 'lib';
use CGI;
use CGI::Session;
use Digest::MD5 qw( md5_hex );
use LTASKER;
use LTASKER::NAVIGATION;
use LTASKER::USER;
use ERRORS;

use base 'LTASKER::DB';

#
# Get login info
#
sub info {
	my ($class, %p) = @_;

	my $self = LTASKER::DB::connect($class);

	$self->{user_auth} = 0;
	$self->{user_id} = 0;
	$self->{session} = CGI::Session->new;
	$self->{login_error_msg} = "";

	if (defined $self->{session}->param("user_id")) {
		my $user = LTASKER::USER->choose($self->{session}->param("user_id"));
		my $user_info = $user->info;
		$self->{user_auth} = $self->{session}->param("user_auth"),
		$self->{user_id} = $self->{session}->param("user_id"),
		$self->{user_name} = $user_info->{name},
		$self->{user_email} = $user_info->{email}
	}

	return $self;
}
#
# Login to the system
#
sub login {
	my ($self, %p) = @_;

	if (!$p{user_name} or !$p{password}) {
		$self->{login_error_msg} = "Введите логин и пароль!";
		return 0;
	}

	my $user_query_result = $self->query(
		qq| SELECT * FROM user WHERE name = ? AND password_hash = ? |,
		$p{user_name}, md5_hex($p{password})
	);	

	if (@$user_query_result) {
		my $user = $user_query_result->[0];
		$self->{session}->param("user_id", $user->{id});
		#$self->{session}->param("user_name", $user->{name});
		#$self->{session}->param("user_email", $user->{email});
		$self->{session}->param("user_auth", 1);
		$self->{session}->expire('1M');
	}
	else {
		$self->{login_error_msg} = "Неправильный логин/пароль";
		return 0;
	}

	my @cookie_header = split(/\n/, $self->{session}->header);
	print $cookie_header[0];
	print $cookie_header[1];
	lt_goto(URL_PROJECTS);
	
	return 1;
}

#
# Logout from the system
#
sub logout {
	my ($self, %p) = @_; 
	
	$self->{session}->delete;
	$self->{session}->flush;

	return undef;
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
sub login_error_msg {
	my ($self, %p) = @_;
	return $self->{login_error_msg};
}
#
#
#
sub user_data {
	my ($self, %p) = @_;
	return {
		user_auth => $self->{user_auth},
		user_id => $self->{user_id},
		user_name => $self->{user_name},
		user_email => $self->{user_email}
	};
}
#
# Get all sessions 
#
sub online_list {
	my ($self) = @_;

	my @sessions = ();

	CGI::Session->find( sub { 
		my $ses = shift;
		if (defined $ses->param("user_auth") and ($ses->param("user_auth") eq 1 ) and (not $ses->is_expired)) {
			push(@sessions, { 
				o_user_id => $ses->param("user_id"),
				o_user_name => $ses->param("user_name"),
				o_action_time => time - $ses->atime
			}) if (time - $ses->atime) < 600; 
		}
		else {
			$ses->delete;
			$ses->flush;
		}
	});

	return \@sessions;
}

1;
