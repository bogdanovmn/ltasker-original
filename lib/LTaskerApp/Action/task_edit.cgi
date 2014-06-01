#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::NAVIGATION;
use LTasker::Project;
use LTasker::Task;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTasker->enter;

my $cgi = CGI->new;
my $action = $params->{action} || "none";
my $task_name = $params->{name} || "";
my $task_description = $params->{description} || "";
my $task_id = $params->{task_id};
my $task_status = $params->{status} || 0;
my $task_component = $params->{component};
my $task_type = $params->{type};
my $task_priority = $params->{priority};
my $project_id = $params->{project_id};

$project_id ?
	$ltasker->permission(project_id => $project_id) :
	$ltasker->permission(task_id => $task_id);

my $project = LTasker::Project->choose($project_id);
my $project_info = $project->info;

my $task = LTasker::Task->choose($task_id);
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
	
