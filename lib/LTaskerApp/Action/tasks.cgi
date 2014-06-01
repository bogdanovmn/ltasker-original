#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use LTasker;
use LTasker::NAVIGATION;
use LTasker::Project;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTasker->enter;

my $cgi = CGI->new;
my $action = $params->{action} || "none";
my $project_id = $params->{project_id};

$ltasker->permission(project_id => $project_id);

my $project = LTasker::Project->choose($project_id);
my $tasks = $project->tasks(for_html => 1);
my $tpl = TEMPLATE->new('tasks.tpl');
#debug($cgi);
#debug($project->info);
$tpl->params(
	project_id => $project_id,
	tasks => $tasks,
	tasks_list => 1,
	%{$project->info},
	%{$ltasker->user_data}
);
$tpl->show;