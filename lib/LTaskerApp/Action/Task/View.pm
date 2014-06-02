package LTaskerApp::Action::Task::View;

use strict;
use warnings;
use utf8;

use LTasker::Task;

sub main {
	my ($class, $params) = @_;

	my $ltasker = $params->{ltasker};
	my $task_id = $params->{task_id};

	return undef unless $ltasker->permission(task_id => $task_id);

	my $task = LTasker::Task->choose($task_id);

	return {
		%{$task->info(for_html => 1)},
	};
}

1;
