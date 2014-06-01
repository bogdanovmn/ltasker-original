package LTaskerApp::Project::View;

use strict;
use warnings;
use utf8;

use LTASKER::PROJECT;


sub main {
	my ($class, $params) = @_;

	my $project_id = $param->{id};
	my $project    = LTASKER::PROJECT->choose($project_id);

	return {
		p_components => $project->components,
		%{$project->info(for_html => 1)},
	};
}

1;
