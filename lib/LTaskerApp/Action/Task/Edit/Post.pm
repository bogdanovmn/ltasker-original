package LTaskerApp::Action::Task::Edit::Post;

use strict;
use warnings;
use utf8;

use LTasker::Project;
use Utils;

sub main {
	my ($class, $params) = @_;

	my $ltasker          = $params->{ltasker};
	my $project_id       = $params->{project_id};
	my $task_id          = $params->{task_id};
	
	my $task_name        = $params->{name} || "";
	my $task_description = $params->{description} || "";
	my $task_component   = $params->{component};
	my $task_type        = $params->{type};
	my $task_priority    = $params->{priority};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $task = LTasker::Task->choose($task_id);

	my %task_info_input = (
		name        => $task_name,
		description => $task_description,
		type        => $task_type,
		priority    => $task_priority,
		component   => $task_component,
		owner       => $ltasker->user_data->{user_id}
	);
	$task->update(%task_info_input);
	
	return not $ltasker->error;
}

1;
