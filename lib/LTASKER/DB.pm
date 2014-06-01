package LTASKER::DB;

use strict;
use warnings;

use lib 'conf';
use DB_CONF;

use DBI;
use ERRORS;

sub connect {
	my ($class, %p) = @_;

	my $dbh = DBI->connect("dbi:mysql:".DB_CONF::NAME, DB_CONF::USER, DB_CONF::PASS) or ERRORS::html_error("Что то с базой данных...");
	my $self = { dbh => $dbh };

	$dbh->do("SET NAMES cp1251");

	return bless($self, $class);
}
#
#
#
sub query {
	my ($self, $sql, @params) = @_;
	
	my $sth = $self->{dbh}->prepare($sql);
	$sth->execute(@params);
	
	if ($sth->err) {
        ERRORS::html_error("Ошибка sql-запроса");
    }

	#if ($sql =~ /^\s*select/i) { debug("1 ". $sql); } else { debug("2 ". $sql); }
	if ($sql =~ /^\s*select/i) {	
		my @result = ();
		while (my $row = $sth->fetchrow_hashref) {
			push(@result, $row);
		}
		$sth->finish;
		
		return \@result;
	}
		
	return 1;
}
#
# Destructor
#
sub DESTROY {
	my $self = shift;

	$self->{dbh}->disconnect;
}

1;
