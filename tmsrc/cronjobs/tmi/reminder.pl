#!/usr/bin/perl

print "Content-Type: text/html \n\n";
$mailprog = '/usr/sbin/sendmail';
require "/tmapp/tmsrc/cgi-bin/tmi_ligen.pl";
require "/tmapp/tmsrc/cgi-bin/runde.pl";

$xx = ( ( $rrunde - 2 ) * 4 ) + 1;
$datei = "/tmdata/tmi/zat" . $xx . ".txt";
open( D, "<$datei" );
while (<D>) {
	@zat = split( /&/, $_ );
	$verwarnung{ $zat[0] } = 1;
}
close(D);

$e = 0;
$y = 0;

open( D2, "/tmdata/tmi/history.txt" );
while (<D2>) {
	@vereine = ();
	$e++;

	@vereine = split( /&/, $_ );

	$ya = 0;
	for ( $x = 1 ; $x < 19 ; $x++ ) {
		$ya++;
		$y++;
		chomp $vereine[$ya];
		$datq[$y] = $vereine[$ya];
		$ya++;
		chomp $vereine[$ya];
		$datb[$y] = $vereine[$ya];

		$team{ $datq[$y] } = $datq[$y];

		$ya++;
		chomp $vereine[$ya];
		$datc[$y] = $vereine[$ya];
		$liga[$y] = $e;
	}

}
close(D2);

open( D2, "/tmdata/hashedPasswords.txt" );
while (<D2>) {
	@data               = split( /&/, $_ );
	$trainer            = $data[1];
	$passwort{$trainer} = $data[2];
	$mail{$trainer}     = $data[3];
}
close(D2);

for ( $x = 1 ; $x <= 3654 ; $x++ ) {

	$datei  = $x;
	$nummer = $x;

	if ( $x < 1000 ) { $datei = '0' . $datei }
	if ( $x < 100 )  { $datei = '0' . $datei }
	if ( $x < 10 )   { $datei = '0' . $datei }

	$sp1 = ( $rrunde * 4 ) - 3;
	$sp2 = $sp1 + 3;
	if ( $sp2 > 34 ) { $sp2 = 34 }

	$dot = '/tmdata/tmi/tips/' . $sp1 . '/' . $datei . '.txt';

	$reminder[$x] = 0;

	if ( -e "$dot" ) { $reminder[$x] = 1 }

}

$tt = 0;

$runde = $rrunde;
for ( $x = 1 ; $x <= $y ; $x++ ) {

	if ( $reminder[$x] ne "1" ) {
		if ( $datb[$x] ne "Trainerposten frei" ) {
			$tt++;

			#print "$reminder[$x] $datb[$x]<br>\n";
			if ( $reminder[$x] eq "" ) { $reminder[$x] = 1 }
			if ( $reminder[$x] == 0 ) {

				$oo = 0;
				print "$mail{$datb[$x]} -> $datq[$x]\n";

				open( MAIL, "|$mailprog -t" );
				print MAIL "To: $mail{$datb[$x]}\n";
				print MAIL "From: noreply\@tipmaster.de\n";
				print MAIL "Subject: Tip - Reminder [TMI] $datq[$x] \n";

				print MAIL "*** TipMaster international ***\nhttp://www.tipmaster.de \n\n";
				print MAIL <<"(END ERROR HTML)";
Guten Tag $datb[$x] ,

diese Mail ist eine Erinnerung an ihre Tipabgabe beim
TipMaster international fuer Spieltag $sp1 bis $sp2 . Bisher 
haben wir leider noch keine Tipabgabe von Ihnen fuer
ihren aktuellen Verein $datq[$x] in 
der $liga_namen[$liga[$x]] empfangen 
( Stand Donnerstag morgen 10.oo Uhr).

Noch bis Freitag 18.oo Uhr haben sie die Moeglichkeit
Ihre Tipabgabe unter http://www.tipmaster.de/ zu taetigen.

Wenn es Probleme mit dem Login gibt fordern Sie hier bitte ein neues Passwort an:
http://www.tipmaster.de/url.shtml

Anmerkung : Auch wenn Sie einen Blankotip fuer die aktuelle
Tiprunde abgegeben haben erhalten Sie diesen Tip-Reminder.

Mit sportlichen Gruessen
Ihr TipMaster - Team

**************************************************************************
Wenn Sie diese Mail erhalten haben obwohl Sie keine
Registrierung beim TipMaster vorgenommen haben schreiben
Sie bitte eine kurze Mail an info\@tipmaster.net mit der Bitte
zur Loeschung des mit Ihrer E-Mail Adresse angelegten Accounts .
**************************************************************************
(END ERROR HTML)
				sleep .3;

			}
		}
	}
}

