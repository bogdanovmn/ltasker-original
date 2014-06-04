package LTasker::Helper;

use strict;
use warnings;
use utf8;

use base "LTasker::DB";


sub new {
	my ($class) = @_;

	my $self = LTasker::DB::connect($class);
	
	return $self;
}

sub task {
	my ($self, %p) = @_;
	
	my $helper = $self->query(qq|
		SELECT id, name
		FROM helper_task_$p{name}
		|
	);
	#debug($helper) if $p{name} eq "status";
	if (defined $p{selected}) {
		for (my $i = 0; $i < @$helper; $i++) {
			$helper->[$i]->{selected} = $helper->[$i]->{id} eq $p{selected} ? 1 : undef;
		}
	}
	return $helper;
}

sub components {
	my ($self, %p) = @_;
	
	my $result = $self->query(qq|
		SELECT c.id, c.name, c.project_id
		FROM component c
		WHERE c.project_id = ? 
		|,
		[ $self->{project_id} ]
	);
	
	if (defined $p{selected}) {
		for (my $i = 0; $i < @$result; $i++) {
			$result->[$i]->{selected} = $result->[$i]->{id} eq $p{selected} ? 1 : undef;
		}
	}
	return $result;
}

1;
