#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::TASK;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTASKER->enter;

my $cgi = CGI->new;
my $task_id = $cgi->param('task_id');

$ltasker->permission(task_id => $task_id);
my $task = LTASKER::TASK->choose($task_id);

my $tpl = TEMPLATE->new('task.tpl');
$tpl->params(
	%{$task->info(for_html => 1)},
	%{$ltasker->user_data}
);
$tpl->show;