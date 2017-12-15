 #!/bin/bash
# read latex files as argument or from stdin, write an xml representation to stdout
echo '<fromLatex>';
cat $* | \
iconv -f utf-8 -t utf-8 | \
perl -pe '					# one paragraph per line
	s/\r//gs;
	s/\%[^\n]*\n/ /g;
	s/^[ \t]*\n/<BR>/gs;
	s/\n/ /g;
	s/<BR>/\n\n/g;' | \
perl -pe '
	s/\\beginnumbering//g;
	s/\\endnumbering//g;
	s/\\pstartueber/<p type="ueber">/g;
	s/\\pendueber/<\/p>/g;
	s/\\pstart/<p>/g;
	s/\\pend/<\/p>/g;
	s/\\endinput//g;
	s/\{\\pfeilr\}/→/g;
	s/\\kr/◦/g;
	s/\\flq /‘/g;
	s/\\frq /’/g;
	s/\\flq/‘/g;
	s/\\frq/’/g;
	s/\\flqq /“/g;
	s/\\frqq /”/g;
	s/\\frq\\ /’ /g;
	s/\{\\dots\}/…/g;
	s/\\-//g;
	s/\\,/ /g;
	s/\\ / /g;
	s/--/-/g;
	s/\\linebreak/ /g;
	s/\\oe\ /œ/g;
	s/\\ae\ /æ/g;
	s/\\~\{n\}/ñ/g;
	s/\\\x27\{E\}/É/g;
	s/[ \t]+/ /g;
	s/\\ProvidesFile\{.*\}\[.*\]//g;
	s/\\begin\{.*\}\{.*\}//g;
	s/\\markboth\{.*\}\{.*\}//g;
	s/\\end\{edition}//g;

	while(m/.*\\(textbf|emph|hoch|textsc|text|fnb|lemma|mbox)\{([^{}]*)}.*/) {
		s/\\textbf\{([^{}]*)}/<b>$1<\/b>/g;
		s/\\emph\{([^{}]*)}/<i>$1<\/i>/g;
		s/\\hoch\{o}/°/g;
		s/\\hoch\{([^{}]*)}/<sup>$1<\/sup>/g;
		s/\\textsc\{([^{}]*)}/<sc>$1<\/sc>/g;
		s/\\text\{([^{}]*)}/\n<edmactext>$1<\/edmactext>/g;
		s/\\fnb\{([^{}]*)}\//<edmacfn>$1<\/edmacfn>/g;
		s/\\lemma\{([^{}]*)}/<edmacentry>$1<\/edmacentry>/g;
		s/\\mbox\{([^{}]*)}/$1/g;
	}

	s/<edmactext>(.*)<\/edmactext><edmacfn>(.*)<\/edmacfn>\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<edmac-item><edmactext>$1<\/edmactext><edmacfn>$2<\/edmacfn>\n<wdx><orth>$1<\/orth><lemma>$3<\/lemma><gloss>$4<\/gloss><var>$5<\/var><\/wdx>\n<\/edmac-item>/g;
	s/<edmactext>(.*)<\/edmactext><edmacentry>(.*)<\/edmacentry><edmacfn>(.*)<\/edmacfn>\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<edmac-item><edmactext>$1<\/edmactext><edmacentry>$2<\/edmacentry><edmacfn>$3<\/edmacfn>\n<wdx><orth>$1<\/orth><lemma>$4<\/lemma><gloss>$5<\/gloss><var>$6<\/var><\/wdx>\n<\/edmac-item>/g;
	s/([a-z]*<i>[a-z]*<\/i>[a-z]*)\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/\n<wdx><orth>$1<\/orth><lemma>$2<\/lemma><gloss>$3<\/gloss><var>$4<\/var><\/wdx>/g;
	s/([^ <>]* *)\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/\n<wdx><orth>$1<\/orth><lemma>$2<\/lemma><gloss>$3<\/gloss><var>$4<\/var><\/wdx>/g;

	s/<edmactext>(.*)<\/edmactext><edmacfn>(.*)<\/edmacfn>\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/<edmac-item><edmactext>$1<\/edmactext><edmacfn>$2<\/edmacfn>\n<adx><orth>$1<\/orth><person>$3<\/person><personvar>$4<\/personvar><\/adx>\n<\/edmac-item>/g;
	s/<edmactext>(.*)<\/edmactext><edmacentry>(.*)<\/edmacentry><edmacfn>(.*)<\/edmacfn>\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/<edmac-item><edmactext>$1<\/edmactext><edmacentry>$2<\/edmacentry><edmacfn>$3<\/edmacfn>\n <adx><orth>$1<\/orth><person>$4<\/person><personvar>$5<\/personvar><\/adx>\n<\/edmac-item>/g;
	s/([a-z]*<i>[a-z]*<\/i>[a-z]*)\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/\n<adx><orth>$1<\/orth><person>$2<\/person><personvar>$3<\/personvar><\/adx>/g;
	s/([^ <>]* *)\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/\n<adx><orth>$1<\/orth><person>$2<\/person><personvar>$3<\/personvar><\/adx>/g;

	s/\[(.*°[a-b])\]/<pb n="$1"\/>/g;';

echo '</fromLatex>'
