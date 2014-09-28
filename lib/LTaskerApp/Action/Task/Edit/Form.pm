package LTaskerApp::Action::Task::Edit::Form;

use strict;
use warnings;
use utf8;

use LTasker::Project;
use LTasker::Task;

sub main {
	my ($self) = @_;

	my $ltasker    = $self->params->{ltasker};
	my $project_id = $self->params->{project_id};
	my $task_id    = $self->params->{task_id};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $project = LTasker::Project->choose($project_id);
	my $project_info = $project->info;

	my $task = LTasker::Task->choose($task_id);
	my $task_info = $task->info;


	my %helpers = (
		types      => $task->helper(name => "type", selected => $task_info->{t_type}),
		statuses   => $task->helper(name => "status", selected => $task_info->{t_status}),
		priorities => $task->helper(name => "priority", selected => $task_info->{t_priority}),
		components => $task->components(selected => $task_info->{t_component})
	);

	return {
		%helpers,
		%{$task->info},
	};
}

1;
