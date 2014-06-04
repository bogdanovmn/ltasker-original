package LTaskerApp::Action::Task::New::Post;

use strict;
use warnings;
use utf8;

use LTasker::Project;

sub main {
	my ($class, $params) = @_;

	my $ltasker          = $params->{ltasker};
	my $task_name        = $params->{name} || "";
	my $task_description = $params->{description} || "";
	my $task_component   = $params->{component};
	my $task_type        = $params->{type};
	my $task_priority    = $params->{priority};
	my $project_id       = $params->{project_id};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $project = LTasker::Project->choose($project_id);

	my %task_info_input = (
		name        => $task_name,
		description => $task_description,
		type        => $task_type,
		#status      => $task_status,
		priority    => $task_priority,
		component   => $task_component,
		owner       => $ltasker->user_data->{user_id}
	);
	$project->add_task(%task_info_input);
	
	return not $ltasker->error;
}

1;
