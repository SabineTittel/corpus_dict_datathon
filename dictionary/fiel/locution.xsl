<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-28 -->
<xsl:template name="locution_extern">
<xsl:choose>
<xsl:when test="./description/m:locution/@type='adj'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Adjective ,
  "locution adjectivale"@fr</xsl:when>
<xsl:when test="./description/m:locution/@type='adv'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Adverb ,
  "locution adverbiale"@fr</xsl:when>
<xsl:when test="./description/m:locution/@type='verb'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:verb ,
  "locution verbale"@fr</xsl:when>
<xsl:when test="./description/m:locution/@type='interjection'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Interjection ,
  "locution interjective"@fr</xsl:when>
<xsl:when test="./description/m:locution/@type='noun'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Noun ,
  "locution nominale"</xsl:when>
<xsl:when test="./description/m:locution/@type='prep'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Preposition ,
  "locution prépositive"@fr</xsl:when>
<xsl:when test="./description/m:locution/@type='pronoun'">lexinfo:TermType lexinfo:phraseologicalUnit ;
  lexinfo:PartOfSpeech lexinfo:Pronoun ,
  "locution pronominale"@fr</xsl:when>
<xsl:otherwise>locution unspecified</xsl:otherwise></xsl:choose>
</xsl:template>

</xsl:stylesheet>
