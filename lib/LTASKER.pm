package LTASKER;

use strict;
use warnings;
use CGI;
use ERRORS;
use LTASKER::NAVIGATION;
use LTASKER::PROJECT;
use LTASKER::VERSION;
#
# Parent
#
use base 'LTASKER::AUTH';
#
# LTasker Object constructor 
#
sub enter {
	my ($class, %p) = @_;

	my $self = LTASKER::AUTH::info($class);
	if ($self->success_in) {
		return $self;
	}
	else {
		if ($p{auth_failed_redirect}) {
			return $self;
		}
		else {
			lt_goto(URL_LOGIN, auth_failed => 1);
		}
	}
}
#
# Return system version
#
sub version {
	return LTASKER::VERSION::get();
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
			$p{project_id}, $self->{user_id} 
		)};
	}
	if ($p{task_id}) {
		$result = scalar @{$self->query(qq|
			SELECT 1 FROM task WHERE id = ? AND owner = ? |,
			$p{task_id}, $self->{user_id} 
		)};
	}
	if ($p{user_id}) {
		$result = $p{user_id} eq $self->{user_id};#debug($result);
	}

	lt_goto(URL_PROJECTS, permission_failed => 1) unless $result;
	
	return 0;
}
#
#
#
sub load_projects {
	my ($self, %p) = @_;
	
	my $projects = $self->query(qq|
		SELECT * FROM project WHERE owner = ? ORDER BY id DESC |,
		$self->{user_id}
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
		$p{name}, $p{description}, $self->{user_id}
	);

	my $project_id = $self->_last_add_id;
	my $project = LTASKER::PROJECT->choose($project_id);
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
