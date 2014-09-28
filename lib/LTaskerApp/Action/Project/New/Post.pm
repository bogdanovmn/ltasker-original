package LTaskerApp::Action::Project::New::Post;

use strict;
use warnings;
use utf8;


sub main {
	my ($self) = @_;
	
	my $ltasker = $self->params->{ltasker};

	my $project_name        = $self->params->{name} || "";
	my $project_description = $self->params->{description} || "";
	my $new_components      = $self->params->{new_components};

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
