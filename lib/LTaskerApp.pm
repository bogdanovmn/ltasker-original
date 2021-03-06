package LTaskerApp;

use Dancer ':syntax';
use Dancer::Plugin::Controller '0.152';

use LTasker;
use Utils;

use LTaskerApp::Action::Auth::Form; 
use LTaskerApp::Action::Auth::Post; 
use LTaskerApp::Action::Auth::Logout; 

#use LTaskerApp::Action::User::View; 
#use LTaskerApp::Action::User::Edit::Form; 
#use LTaskerApp::Action::User::Edit::Post;

use LTaskerApp::Action::Task::View; 
use LTaskerApp::Action::Task::New::Form; 
use LTaskerApp::Action::Task::New::Post; 
use LTaskerApp::Action::Task::Edit::Form; 
use LTaskerApp::Action::Task::Edit::Post;
use LTaskerApp::Action::Task::Edit::Status;

use LTaskerApp::Action::Project::View; 
#use LTaskerApp::Action::Project::Edit::Form; 
#use LTaskerApp::Action::Project::Edit::Post;

use LTaskerApp::Action::List::Task; 
use LTaskerApp::Action::List::Project; 


our $VERSION = '0.1';


sub show_error { controller(template => 'error', action => 'Error') }


hook 'before' => sub {
	var ltasker => LTasker->enter(
		session => sub { Dancer::session(@_) }
	);
	
	#unless (vars->{ltasker}->success_in and request->path ne '/login/') {
	#	redirect '/login/'; 
	#}


};

hook 'before_template_render' => sub {
	my ($template_params) = @_;
	
	my $user_data = vars->{ltasker}->user_data;
	while (my ($k, $v) = each %$user_data) {
		$template_params->{$k} = $v;
	}
};


get '/login/' => sub {
	controller(template => 'login', action => 'Auth::Form') 
};

post '/login/' => sub {
	if (controller(action => 'Auth::Post')) {
		redirect '/projects/';
	}
	else {
		controller(template => 'login', action => 'Auth::Form');
	}
};

get '/projects/' => sub {
	controller(template => 'projects', action => 'List::Project') 
};

get '/new_project/' => sub {
	controller(template => 'project_new') 
};

get '/project_view/:id/' => sub {
	controller(template => 'project_view', action => 'Project::View') 
};

get '/tasks/:project_id/' => sub {
	controller(template => 'tasks', action => 'List::Task') 
};

get '/new_task/:project_id/' => sub {
	controller(template => 'task_new', action => 'Task::New::Form');
};

get '/task_view/:project_id/:task_id/' => sub {
	controller(template => 'task', action => 'Task::View');
};

post '/new_task/' => sub {
	if (controller(action => 'Task::New::Post')) {
		redirect sprintf('/tasks/%s/', params->{project_id});
	}
	else {
		controller(template => 'task_new', action => 'Task::New::Form');
	}
};

get qr#/task_edit/(close|open)/(\d+)/(\d+)/# => sub {
	my ($action, $project_id, $task_id) = splat;

	var action     => $action;
	var project_id => $project_id;
	var task_id    => $task_id;

	if (controller(action => 'Task::Edit::Status')) {
		redirect sprintf('/tasks/%d/', $project_id);
	}
	else {
		show_error;
	}
};

get '/task_edit/:project_id/:task_id/' => sub {
	controller(template => 'task_edit', action => 'Task::Edit::Form');
};

post '/task_edit/' => sub {
	if (controller(action => 'Task::Edit::Post')) {
		redirect sprintf('/task_view/%d/%d/', params->{project_id}, params->{task_id});
	}
	else {
		controller(template => 'task_edit', action => 'Task::Edit::Form');
	}
};

true;
