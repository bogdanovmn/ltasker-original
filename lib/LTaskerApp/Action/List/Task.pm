package LTaskerApp::Action::List::Task;

use strict;
use warnings;
use utf8;
use LTasker::Project;


sub main {
	my ($self) = @_;
	
	my $ltasker    = $self->params->{ltasker};
	my $project_id = $self->params->{project_id};

	return undef unless $ltasker->permission(project_id => $project_id);

	my $project = LTasker::Project->choose($project_id);
	my $tasks   = $project->tasks(for_html => 1);
	
	return {
		project_id => $project_id,
		tasks      => $tasks,
		tasks_list => 1,
		%{$project->info},
	};
}

1;
