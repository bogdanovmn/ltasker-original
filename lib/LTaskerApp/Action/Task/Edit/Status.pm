package LTaskerApp::Action::Task::Edit::Status;

use strict;
use warnings;
use utf8;

use LTasker::Task;


sub main {
	my ($class, $params) = @_;

	my $ltasker          = $params->{ltasker};
	my $task_id          = $params->{task_id};
	my $action           = $params->{action};
	my $project_id       = $params->{project_id};

	unless ($ltasker->permission(project_id => $project_id)) {
		return $ltasker->error("Доступ запрещен");
	}

	my $task = LTasker::Task->choose($task_id);

	if ($action eq "close") {
		$task->close;
	}
	elsif ($action eq "open") {
		$task->open;
	}

	return not $ltasker->error;
}

1;
