package TEMPLATE;

use strict;
use warnings;
use HTML::Template;
use LTASKER::NAVIGATION;

sub new {
	my ($class, $tpl_file) = @_;
	my $tpl = HTML::Template->new(
		filename => 'tpl/'.$tpl_file,
		default_escape => 'HTML',
		loop_context_vars => 1,
		die_on_bad_params => 0
	);
	my %self = (tpl => $tpl);

	return bless(\%self, $class);
}

sub params {
	my ($self, %p) = @_;
	$p{web_root} = LTASKER::NAVIGATION::web_root();
	$self->{tpl}->param(%p);
}

sub show {
	my $self = shift;
	
	print "Content-Type: text/html; charset: windows-1251;\n\n";
	print $self->{tpl}->output;
}

1;
