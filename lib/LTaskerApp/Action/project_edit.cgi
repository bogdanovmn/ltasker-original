#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTasker;
use LTasker::NAVIGATION;
use LTasker::Project;
use CGI;
use TEMPLATE;
use ERRORS;

my $ltasker = LTasker->enter;

my $cgi = CGI->new;
my $action = $cgi->param('action') || "none";
my $project_name = $cgi->param('name') || "";
my $project_description = $cgi->param('description') || "";
my $project_id = $cgi->param('project_id');
my $new_components = $cgi->param('new_components');
my $component_id = $cgi->param('component_id');
my $component_submit = $cgi->param('component_submit');

#debug($cgi);

$ltasker->permission(project_id => $project_id) if ($action ne "new" and $action ne "add");

my %project_info = (
	name => $project_name,
	description => $project_description,
	components => $new_components 
);

my $project = LTasker::Project->choose($project_id);

if ($action eq "add") {
	$ltasker->add_project(%project_info);
	lt_goto(URL_PROJECTS);
}
elsif ($action eq "edit") {
	my $tpl = TEMPLATE->new('project_edit.tpl');
	$tpl->params(
		p_components => $project->components,
		%{$project->info},
		%{$ltasker->user_data}
	);
	$tpl->show;
}
elsif ($action eq "update") {
	if ($component_submit) {			
		my @components_list = split(/\n/, $new_components);
		for my $component (@components_list) {
			chomp $component;
			$project->add_component(name => $component);
		}
		goto_back();
	}
	else {
		$project->update(%project_info);
		lt_goto(URL_PROJECT_VIEW, project_id => $project_id);
	}
}
elsif ($action eq "del_component") {
	$project->del_component(id => $component_id);
	goto_back();
}
else {
	my $tpl = TEMPLATE->new('project_new.tpl');
	$tpl->params(
		%{$ltasker->user_data}
	);
	$tpl->show;
}
	
