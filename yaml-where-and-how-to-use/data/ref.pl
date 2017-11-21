# GET /repo/foo/pullrequests/23/comments
use JSON::PP;
use YAML::XS;

# The following shows the data structure returned
my $userA = { id => 1001, nick => 'UserA', followers => 99, repos => 23, fullname => '...' };
my $userB = { id => 1002, nick => 'UserB', followers => 3,  repos => 5,  fullname => '...' };

my @comments = (
    {
        id => 1, user => $userA, content => "comment 1", date => 1234567,
                         # ^ Reference
    },
    {
        id => 2, user => $userA, content => "comment 2", date => 1234567,
                         # ^ Reference
    },
    # ...
);
my $coder = JSON::PP->new->ascii->pretty->allow_nonref->canonical;
say $coder->encode(\@comments);
say YAML::XS::Dump(\@comments);
