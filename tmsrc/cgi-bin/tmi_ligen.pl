#!/usr/bin/perl

=head1 NAME
	tmi_ligen.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';
use TMSession;
my $session = TMSession::getSession();
my $trainer = $session->getUser();
my $leut    = $trainer;

use CGI;
$rr_ligen = 203;
@old2new  = (
	0,   1,   2,   3,   4,   9,   10,  11,  12,  17,  18,  19,  20,  25,  26,  27,  28,  33,  34,  35,
	36,  39,  40,  41,  42,  45,  46,  47,  48,  51,  52,  53,  54,  57,  58,  59,  60,  63,  64,  65,
	66,  69,  70,  71,  72,  75,  76,  79,  80,  83,  84,  87,  88,  91,  92,  95,  96,  99,  100, 103,
	104, 107, 108, 111, 112, 171, 172, 115, 116, 119, 120, 123, 124, 127, 128, 131, 132, 135, 136, 174,
	175, 192, 193, 139, 140, 143, 144, 147, 148, 151, 152, 177, 178, 180, 181, 183, 184, 155, 156, 159,
	160, 194, 195, 196, 197, 198, 199, 163, 164, 200, 201, 167, 168, 186, 187, 189, 190, 202, 203
);

@liga_namen = (
	"---",
	"Italien Serie A",
	"Italien Serie B",
	"Italien Amateurliga A",
	"Italien Amateurliga B",
	"Italien Amateurklasse A",
	"Italien Amateurklasse B",
	"Italien Amateurklasse C",
	"Italien Amateurklasse D",
	"England Premier League",
	"England 1.Division",
	"England Amateurliga A",
	"England Amateurliga B",
	"England Amateurklasse A",
	"England Amateurklasse B",
	"England Amateurklasse C",
	"England Amateurklasse D",
	"Spanien Primera Division",
	"Spanien Segunda Division",
	"Spanien Amateurliga A",
	"Spanien Amateurliga B",
	"Spanien Amateurklasse A",
	"Spanien Amateurklasse B",
	"Spanien Amateurklasse C",
	"Spanien Amateurklasse D",
	"Frankreich Ligue Une",
	"Frankreich Ligue Deux",
	"Frankreich Amateurliga A",
	"Frankreich Amateurliga B",
	"Frankreich Amateurklasse A",
	"Frankreich Amateurklasse B",
	"Frankreich Amateurklasse C",
	"Frankreich Amateurklasse D",
	"Niederlande Ehrendivision",
	"Niederlande 1.Division",
	"Niederlande Amateurliga A",
	"Niederlande Amateurliga B",
	"Niederlande Amateurklasse A",
	"Niederlande Amateurklasse B",
	"Portugal 1.Divisao",
	"Portugal 2.Divisao",
	"Portugal Amateurliga A",
	"Portugal Amateurliga B",
	"Portugal Amateurklasse A",
	"Portugal Amateurklasse B",
	"Belgien 1.Division",
	"Belgien 2.Division",
	"Belgien Amateurliga A",
	"Belgien Amateurliga B",
	"Belgien Amateurklasse A",
	"Belgien Amateurklasse B",
	"Schweiz Nationalliga A",
	"Schweiz Nationalliga B",
	"Schweiz Amateurliga A",
	"Schweiz Amateurliga B",
	"Schweiz Amateurklasse A",
	"Schweiz Amateurklasse B",
	"Oesterreich Bundesliga",
	"Oesterreich 1.Division",
	"Oesterreich Amateurliga A",
	"Oesterreich Amateurliga B",
	"Oesterreich Amateurklasse A",
	"Oesterreich Amateurklasse B",
	"Schottland 1.Liga",
	"Schottland 2.Liga",
	"Schottland Amateurliga A",
	"Schottland Amateurliga B",
	"Schottland Amateurklasse A",
	"Schottland Amateurklasse B",
	"Tuerkei 1.Liga",
	"Tuerkei 2.Liga",
	"Tuerkei Amateurliga A",
	"Tuerkei Amateurliga B",
	"Tuerkei Amateurklasse A",
	"Tuerkei Amateurklasse B",
	"Irland 1.Liga",
	"Irland 2.Liga",
	"Irland Amateurliga A",
	"Irland Amateurliga B",
	"Nord Irland 1.Liga",
	"Nord Irland 2.Liga",
	"Nord Irland Amateurliga A",
	"Nord Irland Amateurliga B",
	"Wales 1.Liga",
	"Wales 2.Liga",
	"Wales Amateurliga A",
	"Wales Amateurliga B",
	"Daenemark 1.Liga",
	"Daenemark 2.Liga",
	"Daenemark Amateurliga A",
	"Daenemark Amateurliga B",
	"Norwegen 1.Liga",
	"Norwegen 2.Liga",
	"Norwegen Amateurliga A",
	"Norwegen Amateurliga B",
	"Schweden 1.Liga",
	"Schweden 2.Liga",
	"Schweden Amateurliga A",
	"Schweden Amateurliga B",
	"Finnland 1.Liga",
	"Finnland 2.Liga",
	"Finnland Amateurliga A",
	"Finnland Amateurliga B",
	"Island 1.Liga",
	"Island 2.Liga",
	"Island Amateurliga A",
	"Island Amateurliga B",
	"Polen 1.Liga",
	"Polen 2.Liga",
	"Polen Amateurliga A",
	"Polen Amateurliga B",
	"Tschechien 1.Liga",
	"Tschechien 2.Liga",
	"Tschechien Amateurliga A",
	"Tschechien Amateurliga B",
	"Ungarn 1.Liga",
	"Ungarn 2.Liga",
	"Ungarn Amateurliga A",
	"Ungarn Amateurliga B",
	"Rumaenien 1.Liga",
	"Rumaenien 2.Liga",
	"Rumaenien Amateurliga A",
	"Rumaenien Amateurliga B",
	"Slowenien 1.Liga",
	"Slowenien 2.Liga",
	"Slowenien Amateurliga A",
	"Slowenien Amateurliga B",
	"Kroatien 1.Liga",
	"Kroatien 2.Liga",
	"Kroatien Amateurliga A",
	"Kroatien Amateurliga B",
	"Jugoslawien 1.Liga",
	"Jugoslawien 2.Liga",
	"Jugoslawien Amateurliga A",
	"Jugoslawien Amateurliga B",
	"Bosnien-Herz. 1.Liga",
	"Bosnien-Herz. 2.Liga",
	"Bosnien-Herz. Amateurliga A",
	"Bosnien-Herz. Amateurliga B",
	"Bulgarien 1.Liga",
	"Bulgarien 2.Liga",
	"Bulgarien Amateurliga A",
	"Bulgarien Amateurliga B",
	"Griechenland 1.Liga",
	"Griechenland 2.Liga",
	"Griechenland Amateurliga A",
	"Griechenland Amateurliga B",
	"Russland 1.Liga",
	"Russland 2.Liga",
	"Russland Amateurliga A",
	"Russland Amateurliga B",
	"Estland 1.Liga",
	"Estland 2.Liga",
	"Estland Amateurliga A",
	"Estland Amateurliga B",
	"Ukraine 1.Liga",
	"Ukraine 2.Liga",
	"Ukraine Amateurliga A",
	"Ukraine Amateurliga B",
	"Moldawien 1.Liga",
	"Moldawien 2.Liga",
	"Moldawien Amateurliga A",
	"Moldawien Amateurliga B",
	"Israel 1.Liga",
	"Israel 2.Liga",
	"Israel Amateurliga A",
	"Israel Amateurliga B",
	"Luxemburg 1.Liga",
	"Luxemburg 2.Liga",
	"Luxemburg Amateurliga A",
	"Luxemburg Amateurliga B",
	"Slowakei 1.Liga",
	"Slowakei 2.Liga",
	"Slowakei Amateurliga",
	"Mazedonien 1.Liga",
	"Mazedonien 2.Liga",
	"Mazedonien Amateurliga",
	"Litauen 1.Liga",
	"Litauen 2.Liga",
	"Litauen Amateurliga",
	"Lettland 1.Liga",
	"Lettland 2.Liga",
	"Lettland Amateurliga",
	"Weissrussland 1.Liga",
	"Weissrussland 2.Liga",
	"Weissrussland Amateurliga",
	"Malta 1.Liga",
	"Malta 2.Liga",
	"Malta Amateurliga",
	"Zypern 1.Liga",
	"Zypern 2.Liga",
	"Zypern Amateurliga",
	"Albanien 1.Liga",
	"Albanien 2.Liga",
	"Georgien 1.Liga",
	"Georgien 2.Liga",
	"Armenien 1.Liga",
	"Armenien 2.Liga",
	"Aserbaidschan 1.Liga",
	"Aserbaidschan 2.Liga",
	"Andorra 1.Liga",
	"Andorra 2.Liga",
	"Faeroer Inseln 1.Liga",
	"San Marino 1.Liga"
);

@liga_kuerzel = (
	"---",
	"ITA I",
	"ITA II",
	"ITA III/A",
	"ITA III/B",
	"ITA IV/A",
	"ITA IV/B",
	"ITA IV/C",
	"ITA IV/D",
	"ENG I",
	"ENG II",
	"ENG III/A",
	"ENG III/B",
	"ENG IV/A",
	"ENG IV/B",
	"ENG IV/C",
	"ENG IV/D",
	"SPA I",
	"SPA II",
	"SPA III/A",
	"SPA III/B",
	"SPA IV/A",
	"SPA IV/B",
	"SPA IV/C",
	"SPA IV/D",
	"FRA I",
	"FRA II",
	"FRA III/A",
	"FRA III/B",
	"FRA IV/A",
	"FRA IV/B",
	"FRA IV/C",
	"FRA IV/D",
	"NED I",
	"NED II",
	"NED III/A",
	"NED III/B",
	"NED IV/A",
	"NED IV/B",
	"POR I",
	"POR II",
	"POR III/A",
	"POR III/B",
	"POR IV/A",
	"POR IV/B",
	"BEL I",
	"BEL II",
	"BEL III/A",
	"BEL III/B",
	"BEL IV/A",
	"BEL IV/B",
	"SUI I",
	"SUI II",
	"SUI III/A",
	"SUI III/B",
	"SUI IV/A",
	"SUI IV/B",
	"AUT I",
	"AUT II",
	"AUT III/A",
	"AUT III/B",
	"AUT IV/A",
	"AUT IV/B",
	"SCO I",
	"SCO II",
	"SCO III/A",
	"SCO III/B",
	"SCO IV/A",
	"SCO IV/B",
	"TUR I",
	"TUR II",
	"TUR III/A",
	"TUR III/B",
	"TUR IV/A",
	"TUR IV/B",
	"IRL I",
	"IRL II",
	"IRL III/A",
	"IRL III/B",
	"NIR I",
	"NIR II",
	"NIR III/A",
	"NIR III/B",
	"WAL I",
	"WAL II",
	"WAL III/A",
	"WAL III/B",
	"DEN I",
	"DEN II",
	"DEN III/A",
	"DEN III/B",
	"NOR I",
	"NOR II",
	"NOR III/A",
	"NOR III/B",
	"SWE I",
	"SWE II",
	"SWE III/A",
	"SWE III/B",
	"FIN I",
	"FIN II",
	"FIN III/A",
	"FIN III/B",
	"ISL I",
	"ISL II",
	"ISL III/A",
	"ISL III/B",
	"POL I",
	"POL II",
	"POL III/A",
	"POL III/B",
	"TCH I",
	"TCH II",
	"TCH III/A",
	"TCH III/B",
	"UNG I",
	"UNG II",
	"UNG III/A",
	"UNG III/B",
	"RUM I",
	"RUM II",
	"RUM III/A",
	"RUM III/B",
	"SLO I",
	"SLO II",
	"SLO III/A",
	"SLO III/B",
	"KRO I",
	"KRO II",
	"KRO III/A",
	"KRO III/B",
	"JUG I",
	"JUG II",
	"JUG III/A",
	"JUG III/B",
	"BoH I",
	"BoH II",
	"BoH III/A",
	"BoH III/B",
	"BUL I",
	"BUL II",
	"BUL III/A",
	"BUL III/B",
	"GRI I",
	"GRI II",
	"GRI III/A",
	"GRI III/B",
	"RUS I",
	"RUS II",
	"RUS III/A",
	"RUS III/B",
	"EST I",
	"EST II",
	"EST III/A",
	"EST III/B",
	"UKR I",
	"UKR II",
	"UKR III/A",
	"UKR III/B",
	"MOL I",
	"MOL II",
	"MOL III/A",
	"MOL III/B",
	"ISR I",
	"ISR II",
	"ISR III/A",
	"ISR III/B",
	"LUX I",
	"LUX II",
	"LUX III/A",
	"LUX III/B",
	"SLK I",
	"SLK II",
	"SLK III",
	"MAZ I",
	"MAZ II",
	"MAZ III",
	"LIT I",
	"LIT II",
	"LIT III",
	"LET I",
	"LET II",
	"LET III",
	"WRU I",
	"WRU II",
	"WRU III",
	"MAL I",
	"MAL II",
	"MAL III",
	"ZYP I",
	"ZYP II",
	"ZYP III",
	"ALB I",
	"ALB II",
	"GEO I",
	"GEO II",
	"ARM I",
	"ARM II",
	"ASE I",
	"ASE II",
	"AND I",
	"AND II",
	"FAE I",
	"SaM I"
);

@liga_kat = (
	0, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 1, 3, 5, 5, 7, 7, 7, 7, 2,
	4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8, 8, 2, 4, 6, 6, 8,
	8, 2, 4, 6, 6, 8, 8, 4, 6, 8, 8, 4, 6, 8, 8, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 3, 5, 7, 7, 4, 6, 8,
	8, 5, 7, 9, 9, 4, 6, 8, 8, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 4,
	6, 8, 8, 4, 6, 8, 8, 3, 5, 7, 7, 3, 5, 7, 7, 4, 6, 8, 8, 3, 5, 7, 7, 5, 7, 9, 9, 4, 6, 8, 8, 5, 7, 9,
	9, 4, 6, 8, 5, 7, 9, 4, 6, 8, 4, 6, 8, 4, 6, 8, 5, 7, 9, 5, 7, 9, 5, 7, 4, 6, 5, 7, 5, 7, 5, 7, 5, 5
);

# (1) = 1.LIga 3.Absteiger / (2) = 2.LIga 2/4 / (3) 3/3 / (4) 2/4 / (5) 2/3
@liga_art = (
	0, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 1,
	2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2, 2, 1, 2, 4, 4, 2,
	2, 1, 2, 4, 4, 2, 2, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1,
	2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3,
	3, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 5, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1
);

# league_type
# (1) = 1.LIga 3.Absteiger
# (2) = 2.LIga 2/4 / (3) 3/3 / (4) 2/4 / (5) 2/3
@liga_type = (
	0,

	03, 34, 24, 24, 20, 20, 20, 20,
	03, 34, 24, 24, 20, 20, 20, 20,
	03, 34, 24, 24, 20, 20, 20, 20,
	03, 34, 24, 24, 20, 20, 20, 20,

	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,
	03, 34, 23, 23, 30, 30,

	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,
	03, 34, 20, 20,

	03, 33, 30,
	03, 33, 30,
	03, 33, 30,
	03, 33, 30,
	03, 33, 30,
	03, 33, 30,
	03, 33, 30,

	03, 30,
	03, 30,
	03, 30,
	03, 30,
	03, 30,
	0,
	0
);

sub listOnBoerse() {
	my $ligaIndex = shift;

	#my @boerseKat = ("ENG","FRA","ITA","SPA","ISL","MOL","MAZ","LUX","MAL","ZYP","ALB","ARM","ASE","AND");
	my @boerseKat = ( "ENG", "FRA", "ITA", "SPA" );
	if ( $liga_kat[$ligaIndex] < 7 )  { return 1; }
	if ( $liga_kat[$ligaIndex] == 9 ) { return 0; }
	foreach $kat (@boerseKat) {
		if ( $liga_kuerzel[$ligaIndex] =~ /$kat/ ) { return 1; }
	}
	return 0;
}

1;

