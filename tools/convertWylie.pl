
use strict;
use warnings;

use Lingua::BO::Wylie;
use HTML::Entities;

# binmode(STDOUT, ":utf8");

my $wl = new Lingua::BO::Wylie();

main();

sub main {
    my $file = $ARGV[0];

    open(INPUTFILE, $file) || die("Could not open input file $file");

    while (<INPUTFILE>) {
        print handleLine($_);
    }

    close INPUTFILE;
}

sub handleLine($) {
    my $line = shift;
    $line =~ s/<BO>(.*?)<\/BO>/convertWylie($1)/ge;
    return $line;
}

sub convertWylie() {
    my $wylie = shift;
    my $unicode = $wl->from_wylie($wylie);
    return "<foreign lang=\"bo\">" . encode_entities($unicode) . "</foreign>";
}

sub test {
    my $unicode =  $wl->from_wylie(
        "sems can thams cad bde ba dang bde ba'i rgyu dang ldan par gyur cig\n" .
        "sdug bsngal dang sdug bsngal gyi rgyu dang bral bar gyur cig\n" .
        "sdug bsngal med pa'i bde ba dam pa dang mi 'bral bar gyur cig\n" .
        "nye ring chags sdang gnyis dang bral ba'i btang snyoms la gnas par gyur cig_/");

    print encode_entities($unicode);
}
