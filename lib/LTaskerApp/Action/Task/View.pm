#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::Task;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = $params->{ltasker};

my $cgi = CGI->new;
my $task_id = $params->{task_id};

$ltasker->permission(task_id => $task_id);
my $task = LTasker::Task->choose($task_id);

my $tpl = TEMPLATE->new('task.tpl');
return {
	%{$task->info(for_html => 1)},
	%{$ltasker->user_data}
);
$tpl->show;