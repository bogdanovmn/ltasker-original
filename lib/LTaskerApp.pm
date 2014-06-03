package LTaskerApp;

use Dancer ':syntax';
use Dancer::Plugin::Controller;

use LTasker;
use Utils;

use LTaskerApp::Action::Auth::Form; 
use LTaskerApp::Action::Auth::Post; 
use LTaskerApp::Action::Auth::Logout; 

#use LTaskerApp::Action::User::View; 
#use LTaskerApp::Action::User::Edit::Form; 
#use LTaskerApp::Action::User::Edit::Post;

#use LTaskerApp::Action::Task::View; 
#use LTaskerApp::Action::Task::Edit::Form; 
#use LTaskerApp::Action::Task::Edit::Post;
#use LTaskerApp::Action::Task::Edit::Status;

#use LTaskerApp::Action::Project::View; 
#use LTaskerApp::Action::Project::Edit::Form; 
#use LTaskerApp::Action::Project::Edit::Post;

#use LTaskerApp::Action::List::Task; 
#use LTaskerApp::Action::List::Project; 


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
	return controller(template => 'login', action => 'Auth::Form') 
};

post '/login/' => sub {
	if (controller(action => 'Auth::Post')) {
		redirect '/projects/';
	}
	else {
		controller(template => 'login', action => 'Auth::Form');
	}
};



true;
