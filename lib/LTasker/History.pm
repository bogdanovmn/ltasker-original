package LTasker::History;

use strict;
use warnings;
use utf8;
use LTasker;

use constant H_EVENT => { 
	comment => 1,
	edit => 2,
	status_change => 3
};

use base 'LTasker::DB';

#
# Hystory object constructor
#
sub init {
	my ($class, %p) = @_;

	my $self = LTasker::DB::connect($class);
	$self->{task_id} = $p{task_id};

	return $self;
}
#
# New event for task
#
sub add {
	my ($self, %p) = @_;
	
	$self->query(qq|
		INSERT INTO task_history
		SET task_id = ?,
			event = ?,
			comment = ?
		|,
		$self->{task_id}, $p{event}, $p{comment}
	);
}
#
# Load all events for task
#
sub load {
	my ($self, %p) = @_;
	
	my $events = $self->query(qq|
		SELECT *
		FROM task_history th
		WHERE task_id = ?
		ORDER BY th.id DESC
		|,
		$self->{task_id}
	);

	return $events;
}

1;
