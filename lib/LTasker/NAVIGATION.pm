package LTasker::NAVIGATION;

use strict;
use warnings;

use CGI;
use ERRORS;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
	URL_LOGIN 
	URL_PROJECTS
	URL_PROJECT_VIEW
	URL_TASKS
	URL_TASK_VIEW
	URL_USER
	URL_USER_EDIT
	web_root
	lt_goto
	goto_back
);

#
# URLs
#
use constant URL_LOGIN => "login.cgi";
use constant URL_PROJECTS => "projects.cgi";
use constant URL_PROJECT_VIEW => "project_view.cgi";
use constant URL_TASKS => "tasks.cgi";
use constant URL_TASK_VIEW => "task.cgi";
use constant URL_USER => "user.cgi";
use constant URL_USER_EDIT => "user_edit.cgi";
#
# Static methods
#
sub web_root {
	return $ENV{SERVER_NAME} =~ /rednikov|forest/ ?
		"http://". $ENV{SERVER_NAME}. "/ltasker/" :
		"http://ltasker/";
}

sub lt_goto {
	my ($url, %params) = @_;
	my $goto_url = web_root(). $url;

	my $params_string = "";
	while (my ($name, $value) = each %params) {
		$params_string .= $name. "=". $value. "&";
	}
	if ($params_string) {
		chop $params_string;
		$params_string = "?". $params_string;
	}
	print CGI::redirect(-url => $goto_url. $params_string);
	exit;
}

sub goto_back {
	my $goto_url = $ENV{HTTP_REFERER};
	print CGI::redirect(-url => $goto_url);
	exit;
}

1;
