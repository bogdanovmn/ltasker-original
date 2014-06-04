package LTaskerApp::Action::Project::View;

use strict;
use warnings;
use utf8;

use LTasker::Project;


sub main {
	my ($class, $params) = @_;

	my $project_id = $params->{id};
	my $project    = LTasker::Project->choose($project_id);

	return {
		p_components => $project->components,
		%{$project->info(for_html => 1)},
	};
}

1;
