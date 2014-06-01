package ERRORS;

use strict;
use warnings;
use TEMPLATE;
use Data::Dumper;

require Exporter;
our @ISA = qw| Exporter |;
our @EXPORT = (qw|
	debug
|);



sub html_error {
	my ($msg) = @_;
	my $tpl = TEMPLATE->new('error.tpl');
	$tpl->params(msg => $msg);
	$tpl->show;
	exit;
}

sub debug {
	my ($msg) = @_;
	my $tpl = TEMPLATE->new('error.tpl');
	$tpl->params(
		msg => "Отладка",
		debug => Dumper($msg)
		);
	$tpl->show;
	exit;
}

1;
