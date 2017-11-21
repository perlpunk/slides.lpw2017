#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use YAML::PP::Loader;
use YAML::PP::Dumper;
use YAML::PP::Highlight;

my ($file) = @ARGV;

my $ypp = YAML::PP::Loader->new(
    boolean => 'JSON::PP',
);
my @docs = eval { $ypp->load_file($file) };
my $error = $@;
my $tokens = $ypp->parser->tokens;
if ($error) {
    my $remaining_tokens = $ypp->parser->lexer->next_tokens;
    push @$tokens, map {
        { name => 'ERROR', value => $_->{value} } } @$remaining_tokens;
    my $remaining = $ypp->parser->lexer->reader->read;
    push @$tokens, { name => 'ERROR', value => $remaining };
}

my $high = YAML::PP::Highlight->htmlcolored($tokens);
say $high;
