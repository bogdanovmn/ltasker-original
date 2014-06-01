package LTasker;

use strict;
use warnings;
use utf8;

use LTasker::Project;
#
# Parent
#
use base 'LTasker::Auth';
#
# LTasker Object constructor 
#
sub enter {
	my ($class, %p) = @_;

	return LTasker::Auth::info($class);
}
#
# Check permission
#
sub permission {
	my ($self, %p) = @_;
	
	my $result = 0;
	if ($p{project_id}) {
		$result = scalar @{$self->query(qq|
			SELECT 1 FROM project WHERE id = ? AND owner = ? |,
			[ $p{project_id}, $self->{user_id} ] 
		)};
	}
	if ($p{task_id}) {
		$result = scalar @{$self->query(qq|
			SELECT 1 FROM task WHERE id = ? AND owner = ? |,
			[ $p{task_id}, $self->{user_id} ]
		)};
	}
	if ($p{user_id}) {
		$result = $p{user_id} eq $self->{user_id};#debug($result);
	}

	return $result;
}
#
#
#
sub load_projects {
	my ($self, %p) = @_;
	
	my $projects = $self->query(qq|
		SELECT * FROM project WHERE owner = ? ORDER BY id DESC |,
		[ $self->{user_id} ]
	);
	return $projects;
}
#
#
#
sub add_project {
	my ($self, %p) = @_;

	$self->query(qq|
		INSERT INTO project SET
			name = ?,
			description = ?,
			owner = ? 
		|,
		[ $p{name}, $p{description}, $self->{user_id} ]
	);

	my $project_id = $self->_last_add_id;
	my $project = LTasker::Project->choose($project_id);
	#debug($project);
	my @components = split(/\n/, $p{components});
	for my $component (@components) {
		chomp $component;
		$project->add_component(name => $component);
	}

}
#
# Get last project_id 
#
sub _last_add_id {
	my ($self, %p) = @_;
	return $self->query(qq|
		SELECT MAX(id) id FROM project WHERE owner = ? |,
		$self->{user_id}
	)->[0]->{id};
}

1;
