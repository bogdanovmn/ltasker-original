#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::NAVIGATION;
use LTASKER::PROJECT;
use LTASKER::TASK;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTASKER->enter;

my $cgi = CGI->new;
my $action = $cgi->param('action') || "none";
my $task_name = $cgi->param('name') || "";
my $task_description = $cgi->param('description') || "";
my $task_id = $cgi->param('task_id');
my $task_status = $cgi->param('status') || 0;
my $task_component = $cgi->param('component');
my $task_type = $cgi->param('type');
my $task_priority = $cgi->param('priority');
my $project_id = $cgi->param('project_id');

$project_id ?
	$ltasker->permission(project_id => $project_id) :
	$ltasker->permission(task_id => $task_id);

my $project = LTASKER::PROJECT->choose($project_id);
my $project_info = $project->info;

my $task = LTASKER::TASK->choose($task_id);
my $task_info = $task->info;

my %task_info_input = (
	name => $task_name,
	description => $task_description,
	type => $task_type,
	status => $task_status,
	priority => $task_priority,
	component => $task_component,
	owner => $ltasker->user_data->{user_id}
);

my %helpers = (
	types => $task->helper(name => "type", selected => $task_info->{t_type}),
	statuses => $task->helper(name => "status", selected => $task_info->{t_status}),
	priorities => $task->helper(name => "priority", selected => $task_info->{t_priority}),
	components => $task->components(selected => $task_info->{t_component})
);

#debug($cgi);	
#debug(\%helpers);
#debug(\%task_info);
#debug($project_info);

if ($action eq "add") {
	$project->add_task(%task_info_input);
	lt_goto(URL_TASKS, project_id => $project_id);
}
elsif ($action eq "edit") {
	#debug(\%helpers);
	#debug($task->info);
	my $tpl = TEMPLATE->new('task_edit.tpl');
	$tpl->params(
		%helpers,
		%{$task->info},
		%{$ltasker->user_data}
	);
	$tpl->show;
}
elsif ($action eq "update") {
	$task->update(%task_info_input);
	lt_goto(URL_TASK_VIEW, task_id => $task_id);
}
elsif ($action eq "close") {
	$task->close;
	lt_goto(URL_TASKS, project_id => $project_id);
}
elsif ($action eq "open") {
	$task->open;
	lt_goto(URL_TASKS, project_id => $project_id);
}
else {
	my $tpl = TEMPLATE->new('task_new.tpl');
	#debug($project->info);
	$helpers{components} = $project->components;
	$tpl->params(
		%helpers,
		%{$project_info},
		%{$ltasker->user_data}
	);
	$tpl->show;
}
	
