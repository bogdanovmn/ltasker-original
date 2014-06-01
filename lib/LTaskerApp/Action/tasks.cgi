#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use LTASKER::NAVIGATION;
use LTASKER::PROJECT;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTASKER->enter;

my $cgi = CGI->new;
my $action = $cgi->param('action') || "none";
my $project_id = $cgi->param('project_id');

$ltasker->permission(project_id => $project_id);

my $project = LTASKER::PROJECT->choose($project_id);
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