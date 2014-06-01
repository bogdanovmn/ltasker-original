package Text;

use strict;
use warnings;
use utf8;


#
# Replace new lines with <br>
#
sub convert_to_html {
	my ($text) = @_;
	
	$text = replace_multi_spaces($text);
	$text = replace_html_direct_symbols($text);
	$text =~ s/\r\n/<br>/g;

	return $text;
}
#
# Replace some symbols for inserting into HTML
#
sub replace_html_direct_symbols {
	my ($text) = @_;
	
	$text =~ s/"/&quot;/g;
	$text =~ s/'/&#39;/g;
	$text =~ s/</&lt;/g;
	$text =~ s/>/&gt;/g;
	
	return $text;
}
#
# Replace some words =)
#
sub replace {
	my ($text, $from, $to) = @_;
	
	$text =~ s/$from/$to/sg;

	return $text;
}
#
# Replace multi-spaces with &nbsp;
#
sub replace_multi_spaces {
	my ($text) = @_;
	
	my @lines = split(/\n/, $text);
	my $lines_count = @lines;
	for (my $i = 0; $i < $lines_count; $i++) {
		my @chars = split(//, $lines[$i]);
		my $chars_count = @chars;
		my $already_spaces = 0;
		for (my $j = 0; $j < $chars_count; $j++) {
			if ($chars[$j] eq ' ') {
				if ($already_spaces or $j == 0) {
					$chars[$j] = '&nbsp;';
				}
				else {
					$already_spaces = 1;
				}
			}
			else {
				$already_spaces = 0;
			}
		}
		$lines[$i] = join("", @chars);
	}
	
	return join("\n", @lines);
}

1;
