package LTaskerApp::Action::Project::Edit::Form;

use strict;
use warnings;
use utf8;

use LTasker::Project;

sub main {
	my ($self) = @_;
	
	my $ltasker = $self->params->{ltasker};

	my $action = $self->params->{action} || "none";
	my $project_name = $self->params->{name} || "";
	my $project_description = $self->params->{description} || "";
	my $project_id = $self->params->{project_id};
	my $new_components = $self->params->{new_components};
	my $component_id = $self->params->{component_id};
	my $component_submit = $self->params->{component_submit};

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
		return {
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
		return {
			%{$ltasker->user_data}
		);
		$tpl->show;
	}
}

1;
