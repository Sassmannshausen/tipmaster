require "dfb_runde1.pl";
require "btm_pokal_ansetzung.pl";
`cp tmi_pokal_leer.txt /tmdata/tmi/pokal/pokal_quote.txt`;
require "tmi_pokal_ansetzung.pl";
`cp pokal_quote_btm.txt /tmdata/btm/pokal/pokal_quote.txt`;

print "\n\n BTM und TMI Pokal neu aufgesetzt !\n";



	#reset rights - problem occurredd fter git trainsition, tp, Aug-24-2105
`chmod -R lighttpd:lighttpd /tmdata`;
`chmod -R 755 /tmdata`;