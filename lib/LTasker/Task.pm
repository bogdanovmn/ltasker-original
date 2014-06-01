package LTasker::Task;

use strict;
use warnings;
use ERRORS;
use TEXT;

use constant STATUS_OPEN => 1;
use constant STATUS_CLOSE => 2;

use base "LTasker::History";

sub choose {
	my ($class, $id) = @_;

	my $self = LTasker::History::init($class, task_id => $id);
	
	return $self;
}
#
#
#
sub info {
	my ($self, %p) = @_;
	
	my $info = $self->query(qq|
		SELECT 
			t.id t_id,
			t.name t_name,
			t.description t_description,
			t.owner t_owner,
			t.performer t_performer,
			
			t.status t_status,
			hts.name t_status_name,
			
			t.type t_type,
			htt.name t_type_name,
			
			t.component t_component,
			c.name t_component_name,
			
			t.priority t_priority,
			htp.name t_priority_name,
			
			p.id p_id,
			p.name p_name
		FROM task t
		JOIN project p ON p.id = t.project_id
		JOIN helper_task_type htt ON htt.id = t.type
		JOIN helper_task_status hts ON hts.id = t.status
		JOIN helper_task_priority htp ON htp.id = t.priority
		LEFT JOIN component c ON c.id = t.component
		WHERE t.id = ? |,
		$self->{task_id}
	);
	
	if ($p{for_html}) {
		for (my $i = 0; $i < scalar @$info; $i++) {
			$info->[$i]->{t_description} = TEXT::convert_to_html($info->[$i]->{t_description});
		}
	}
	
	return $info->[0];
}
#
#
#
sub update {
	my ($self, %p) = @_;
	#debug(\%p);
	$self->query(qq|
		UPDATE task 
		SET name = ?,
			description = ?,
			priority = ?,
			type = ?,
			component = ?
		WHERE id = ?
			
		|,
		$p{name}, $p{description}, $p{priority}, $p{type}, $p{component}, $self->{task_id}
	);
}
#
#
#
sub set_status {
	my ($self, $status) = @_;
	
	my $close_value = $status eq STATUS_CLOSE ? ", close_date = NOW()" : "";
	
	$self->query(qq|
		UPDATE task 
		SET status = ?
			$close_value
		WHERE id = ?
		|,
		$status, $self->{task_id}
	);
}
#
#
#
sub close {
	my ($self) = @_;
	$self->set_status(STATUS_CLOSE);
}
#
#
#
sub open {
	my ($self) = @_;
	$self->set_status(STATUS_OPEN);
}
#
#
#
sub helper {
	my ($self, %p) = @_;
	
	my $helper = $self->query(qq|
		SELECT id, name
		FROM helper_task_$p{name}
		|
	);
	#debug($helper) if $p{name} eq "status";
	if (defined $p{selected}) {
		for (my $i = 0; $i < @$helper; $i++) {
			$helper->[$i]->{selected} = $helper->[$i]->{id} eq $p{selected} ? 1 : undef;
		}
	}
	return $helper;
}
#
#
#
sub components {
	my ($self, %p) = @_;
	
	my $result = $self->query(qq|
		SELECT c.id, c.name, c.project_id
		FROM component c
		JOIN task t ON c.project_id = t.project_id
		WHERE t.id = ? 
		|,
		$self->{task_id}
	);
	
	if (defined $p{selected}) {
		for (my $i = 0; $i < @$result; $i++) {
			$result->[$i]->{selected} = $result->[$i]->{id} eq $p{selected} ? 1 : undef;
		}
	}
	return $result;
}


1;
