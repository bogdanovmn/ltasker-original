package LTaskerApp::Action::Project::New::Post;

use strict;
use warnings;
use utf8;


sub main {
	my ($class, $params) = @_;
	
	my $ltasker = $params->{ltasker};

	my $project_name        = $params->{name} || "";
	my $project_description = $params->{description} || "";
	my $new_components      = $params->{new_components};

	unless ($project_name) {
		return $ltasker->error("Имя проекта необходимо заполнить!");
	}

	return $ltasker->add_project(
		name        => $project_name,
		description => $project_description,
		components  => $new_components 
	);
}

1;
