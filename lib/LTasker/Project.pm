package LTasker::Project;

use strict;
use warnings;
use utf8;

use Text;

use base "LTasker::DB";

sub choose {
	my ($class, $project_id) = @_;

	my $self = LTasker::DB::connect($class);
	$self->{id} = $project_id;
	
	return $self;
}
#
#
#
sub info {
	my ($self, %p) = @_;
	
	my $info = $self->query(qq|
		SELECT id p_id,
			name p_name,
			description p_description,
			DATE_FORMAT(create_date, '%Y-%m-%d') p_create_date
		FROM project 
		WHERE id = ? 
		|,
		[ $self->{id} ]
	);
	
	if ($p{for_html}) {
		for (my $i = 0; $i < scalar @$info; $i++) {
			$info->[$i]->{p_description} = Text::convert_to_html($info->[$i]->{p_description});
		}
	}
	
	return $info->[0];
}
#
#
#
sub tasks {
	my ($self, %p) = @_;
	
	my $tasks = $self->query(qq|
		SELECT t.id, t.name, t.description, 
			DATE_FORMAT(t.create_date, '%Y-%m-%d') create_date, 
			IFNULL(DATE_FORMAT(t.close_date, '%Y-%m-%d'), '-') close_date, 
			CASE t.status WHEN 1 THEN 'close' ELSE 'open' END status_action,
			CASE t.status WHEN 1 THEN 'Закрыть' ELSE 'Открыть' END status_action_name,
			t.project_id,
			hts.name status,
			htt.name type,
			htp.name priority,
			c.name component
		FROM task t
		JOIN helper_task_status hts ON t.status = hts.id
		JOIN helper_task_type htt ON t.type = htt.id
		JOIN helper_task_priority htp ON t.priority = htp.id
		LEFT JOIN component c ON t.component = c.id
		WHERE t.project_id = ? 
		|,
		[ $self->{id} ]
	);
	
	if ($p{for_html}) {
		for (my $i = 0; $i < scalar @$tasks; $i++) {
			$tasks->[$i]->{description} = Text::convert_to_html($tasks->[$i]->{description});
		}
	}
	
	return $tasks;
}
#
#
#
sub add_task {
	my ($self, %p) = @_;
	
	$self->query(qq|
		INSERT INTO task 
		SET	name = ?,
			description = ?,
			project_id = ?,
			owner = ?,
			performer = ?,
			status = 1, 
			priority = ?, 
			type = ?, 
			component = ?
		|,
		[ $p{name}, $p{description}, $self->{id}, $p{owner}, $p{owner}, $p{priority}, $p{type}, $p{component} ]
	);
}
#
#
#
sub components {
	my ($self, %p) = @_;
	my $components = $self->query(
		qq| SELECT * FROM component WHERE project_id = ? |,
		[ $self->{id} ]
	);
	return $components;
}
#
#
#
sub add_component {
	my ($self, %p) = @_;
	
	$self->query(qq|
		INSERT INTO component 
		SET	name = ?,
			project_id = ?
		|,
		[ $p{name}, $self->{id} ]
	);
}
#
#
#
sub del_component {
	my ($self, %p) = @_;
	
	$self->query(qq|
		DELETE FROM component
		WHERE id = ?
		AND project_id = ?
		|,
		[ $p{id}, $self->{id} ]
	);
}
#
#
#
sub update {
	my ($self, %p) = @_;
	#debug($self);
	$self->query(qq|
		UPDATE project 
		SET	name = ?,
			description = ?
		WHERE id = ?
		|,
		[ $p{name}, $p{description}, $self->{id} ]
	);
}

1;
