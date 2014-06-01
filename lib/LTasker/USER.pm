package LTASKER::USER;

use strict;
use warnings;
use ERRORS;

use base "LTASKER::DB";
#
# User object constructor
sub choose {
	my ($class, $id) = @_;

	my $self = LTASKER::DB::connect($class);
	$self->{user_id} = $id;

	return $self;
}
#
# Get user info
#
sub info {
	my ($self, %p) = @_;
	
	my $info = $self->query(qq|
		SELECT *
		FROM user
		WHERE id = ? |,
		$self->{user_id}
	);
	
	return $info->[0];
}
#
# Add new user
#
sub add {
	my ($self, %p) = @_;
	
	$self->query(qq|
		INSERT INTO user 
		SET name = ?,
			email = ?,
			password_hash = MD5(?)
		|,
		$p{name}, $p{email}, $p{password}
	);
}
#
# Update user info
#
sub update {
	my ($self, %p) = @_;
	#debug(\%p);
	$self->query(qq|
		UPDATE user 
		SET name = ?,
			email = ?
		WHERE id = ?
			
		|,
		$p{name}, $p{email}, $self->{user_id}
	);
}

1;
