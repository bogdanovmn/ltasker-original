package TEXT;

use strict;
use warnings;

use locale;
use POSIX qw(setlocale LC_ALL LC_CTYPE);
setlocale(LC_CTYPE, "ru_RU.CP1251");

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
# Cut text for preview
#
sub cut_top_lines { 
    my ($text, $show_lines) = @_;

    my @tmp = split(/<br>/, $text);
    if (scalar @tmp > $show_lines) {
        @tmp = @tmp[0..$show_lines - 1];
        return join("<br>", @tmp);
    }
    else {
        return $text;
    }
}
#
# Cut text by max chars length
#
sub cut_first_chars {
	my ($text, $show_chars) = @_;
	
	return $text if length($text) <= $show_chars;
	
	my @new_text = ();
	
	my @lines = split(/<br>/, $text);
	for my $line (@lines) {
		my $new_line = '';
		my $new_text_current_length = length join("", @new_text);
		my @words = split(/ /, $line);
		for my $word (@words) {
			if ( ($new_text_current_length + length($new_line .' '. $word) ) >= $show_chars) {
				push(@new_text, $new_line);
				return join("<br>", @new_text);
			}
			else {
				$new_line .= ' '. $word;
			}
		}
		push(@new_text, $new_line);
	}
	
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
