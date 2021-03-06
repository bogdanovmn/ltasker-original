package LTaskerApp::Action::Task::New::Form;

use strict;
use warnings;
use utf8;

use LTasker::Project;
use LTasker::Helper;

sub main {
	my ($self) = @_;

	my $ltasker          = $self->params->{ltasker};
	my $project_id       = $self->params->{project_id};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $project = LTasker::Project->choose($project_id);
	my $project_info = $project->info;
	my $helper = LTasker::Helper->new;

	my %helpers = (
		types      => $helper->task(name => "type"),
		statuses   => $helper->task(name => "status"),
		priorities => $helper->task(name => "priority"),
		components => $project->components
	);

	return {
		error_msg => $ltasker->last_error,
		%helpers,
		%{$project->info}
	};
}

1;
