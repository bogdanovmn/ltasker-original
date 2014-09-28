package LTaskerApp::Action::Task::View;

use strict;
use warnings;
use utf8;

use LTasker::Task;

sub main {
	my ($self) = @_;

	my $ltasker = $self->params->{ltasker};
	my $task_id = $self->params->{task_id};

	unless ($ltasker->permission(task_id => $task_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $task = LTasker::Task->choose($task_id);

	return {
		%{$task->info(for_html => 1)},
	};
}

1;
