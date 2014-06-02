package LTaskerApp::Action::User::Edit::Form;

use strict;
use warnings;
use utf8;

use LTasker::User;


sub main {
	my ($class, $params) = @_;
	
	my $user_id = $params->{user_id};
	my $ltasker = $params->{ltasker};

	my $user = LTasker::User->choose($ltasker->user_data->{user_id});

	return {
		user_view => 1,
		new       => $ltasker->success_in,
		error_msg => $ltasker->last_error,
	};
}

1;
