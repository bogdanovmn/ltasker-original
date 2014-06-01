#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use LTASKER;
use CGI;
use TEMPLATE;
use ERRORS;

my $cgi = CGI->new;
my $permission_failed = $cgi->param("permission_failed");

my $ltasker = LTASKER->enter;

my $projects = $ltasker->load_projects;
my $tpl = TEMPLATE->new('projects.tpl');
$tpl->params(
	permission_failed => $permission_failed,
	projects => $projects,
	%{$ltasker->user_data}
);
$tpl->show;
