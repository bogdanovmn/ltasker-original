package LTaskerApp::Action::Task::New::Post;

use strict;
use warnings;
use utf8;

use LTasker::Project;
use Utils;

sub main {
	my ($self) = @_;

	my $ltasker          = $self->params->{ltasker};
	my $task_name        = $self->params->{name} || "";
	my $task_description = $self->params->{description} || "";
	my $task_component   = $self->params->{component};
	my $task_type        = $self->params->{type};
	my $task_priority    = $self->params->{priority};
	my $project_id       = $self->params->{project_id};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $project = LTasker::Project->choose($project_id);

	my %task_info_input = (
		name        => $task_name,
		description => $task_description,
		type        => $task_type,
		priority    => $task_priority,
		component   => $task_component,
		owner       => $ltasker->user_data->{user_id}
	);
	$project->add_task(%task_info_input);
	
	return not $ltasker->error;
}

1;
