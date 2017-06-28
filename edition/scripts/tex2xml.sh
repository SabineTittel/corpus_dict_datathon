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
	s/\\linebreak/ /g;
	s/\\oe\ /œ/g;
	s/\\ae\ /æ/g;
	s/\\~\{n\}/ñ/g;
	s/\\\x27\{E\}/É/g;
	s/[ \t]+/ /g;
	while(m/.*\\(textbf|emph|hoch|textsc|text|fnb|lemma|mbox)\{([^{}]*)}.*/) {
		s/\\textbf\{([^{}]*)}/<b>$1<\/b>/g;
		s/\\emph\{([^{}]*)}/<i>$1<\/i>/g;
		s/\\hoch\{([^{}]*)}/<sup>$1<\/sup>/g;
		s/\\textsc\{([^{}]*)}/<sc>$1<\/sc>/g;
		s/\\text\{([^{}]*)}/<edmactext>$1<\/edmactext>/g;
		s/\\fnb\{([^{}]*)}\//<edmacfn>$1<\/edmacfn>/g;
		s/\\lemma\{([^{}]*)}/<edmacentry>$1<\/edmacentry>/g;
		s/\\mbox\{([^{}]*)}/$1/g;
	}
		# Der Befehl \wdx erzeugt einen Indexeintrag und besitzt drei Parameter
		# ({#1}{#2}{#3}): der erste enthält das Lemma, der zweite POS und Definition
		# des Belegs inkl. fachsprachlicher Markierung (evtl. durchnummeriert,
		# wenn das Lexem in GuiChaulmT in mehreren lexikalischen
		# Einheiten belegt ist), der dritte die graphische Variante.
		# p.c.: bezieht sich immer auf genau das Wort davor
		# ST: im Prinzip ja, aber immer wenn eine edmacfn davor steht, geht das schief. 
		# Ich habe in den Fällen <orth> leer gelassen, da sonst eh nur Quatsch drin steht
	
	s/([^ <>]* *)\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/\n<wdx><orth>$1<\/orth><lemma>$2<\/lemma><gloss>$3<\/gloss><var>$4<\/var><\/wdx>/g;
	s/<\/wdx>\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<\/wdx>\n<wdx><orth><\/orth><lemma>$1<\/lemma><gloss>$2<\/gloss><var>$3<\/var><\/wdx>/g;
	s/<\/wdx>\ \\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<\/wdx>\n<wdx><orth><\/orth><lemma>$1<\/lemma><gloss>$2<\/gloss><var>$3<\/var><\/wdx>/g;
	s/<\/edmacfn>\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<\/edmacfn>\n<wdx><orth><\/orth><lemma>$1<\/lemma><gloss>$2<\/gloss><var>$3<\/var><\/wdx>/g;
	s/<\/edmacfn>\ \\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<\/edmacfn>\n<wdx><orth><\/orth><lemma>$1<\/lemma><gloss>$2<\/gloss><var>$3<\/var><\/wdx>/g;
	s/<\/i>\\wdx\{([^\{}]*)}\{([^\{}]*)}\{([^\{}]*)}/<\/i>\n<wdx><orth><\/orth><lemma>$1<\/lemma><gloss>$2<\/gloss><var>$3<\/var><\/wdx>/g;
	
	s/<\/edmacfn>\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/<\/edmacfn>\n<adx><orth><\/orth><person>$1<\/person><personvar>$2<\/personvar><\/adx>/g;
	s/<\/i>\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/<\/i>\n<adx><orth><\/orth><person>$1<\/person><personvar>$2<\/personvar><\/adx>/g;
	s/<\/wdx>\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/<\/wdx>\n<adx><orth><\/orth><person>$1<\/person><personvar>$2<\/personvar><\/adx>/g;
	s/([^ <>]+ *)\\adx\{([^\{}]*)}\{}\{([^\{}]*)}/\n<adx><orth>$1<\/orth><person>$2<\/person><personvar>$3<\/personvar><\/adx>/g;
	
	s/<orth> <\/orth>/<orth><\/orth>/g;';
	
echo '</fromLatex>'                               

