<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-28 -->

<xsl:template name="pos_extern">
<xsl:choose><xsl:when test="pos='m.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine</xsl:when>
<xsl:when test="pos='f.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:feminine</xsl:when>
<xsl:when test="pos='s.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun</xsl:when>
<xsl:when test="pos='s.m.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine</xsl:when>
<xsl:when test="pos='s.f.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:feminine</xsl:when>
<xsl:when test="pos='f. et m.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine , lexinfo:feminine</xsl:when>
<xsl:when test="pos='f. et m. (?)'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine , lexinfo:feminine</xsl:when>
<xsl:when test="pos='f. et m.pl.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine , lexinfo:feminine ;
  lexinfo:Number lexinfo:plural</xsl:when>
<xsl:when test="pos='m.pl.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:masculine ,
  lexinfo:Number lexinfo:plural</xsl:when>
<xsl:when test="pos='f.pl.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Gender lexinfo:feminine ;
  lexinfo:Number lexinfo:plural</xsl:when>
<xsl:when test="pos='s.pl.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:Number lexinfo:plural</xsl:when>

<xsl:when test="pos='adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective</xsl:when>
<xsl:when test="pos='adj. f.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective ;
  lexinfo:Gender lexinfo:feminine</xsl:when>
<xsl:when test="pos='adj. m.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective ;
  lexinfo:Gender lexinfo:masculine</xsl:when>
<xsl:when test="pos='adj. poss.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective</xsl:when>
<xsl:when test="pos='adj. substantivé'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun</xsl:when>
  <xsl:when test="pos='adj. num.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective , lexinfo:numeral</xsl:when>

<xsl:when test="pos='adv.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adverb</xsl:when>
<xsl:when test="pos='art. déf.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:definiteArticle</xsl:when>
<xsl:when test="pos='art. indéf.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:indefiniteArticle</xsl:when>
<xsl:when test="pos='prép.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Preposition</xsl:when>
<xsl:when test="pos='interj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Interjection</xsl:when>
<xsl:when test="pos='conj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Conjunction</xsl:when>

<xsl:when test="pos='v.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb</xsl:when>
<xsl:when test="pos='v.tr.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:TransitiveFrame</xsl:when>
  <xsl:when test="pos='v.abs.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:Case lexinfo:absolutiveCase</xsl:when>
<xsl:when test="pos='v.intr.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:IntransitiveFrame</xsl:when>
<xsl:when test="pos='v.pron.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:ReflexiveFrame</xsl:when>
<xsl:when test="pos='v.pron. à valeur neutre'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:ReflexiveFrame</xsl:when>
<xsl:when test="pos='v.pron. à valeur réfléchie'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:ReflexiveFrame</xsl:when>
<xsl:when test="pos='v.pron. à valeur réciproque'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:ReflexiveFrame</xsl:when>
<xsl:when test="pos='v.pron. à valeur passive'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:VerbFrame lexinfo:ReflexiveFrame</xsl:when>
<xsl:when test="pos='v.tr. + c.o.i.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:Case lexinfo:dativeCase</xsl:when>
<xsl:when test="pos='v.tr. + c.o.d.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:Case lexinfo:accusativeCase</xsl:when>
<xsl:when test="pos='emploi abs.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:Case lexinfo:absolutiveCase</xsl:when>
<xsl:when test="pos='inf. substantivé'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
    lexinfo:Noun</xsl:when>
<xsl:when test="pos='p.p.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ;
  lexinfo:VerbFormMood lexinfo:participle</xsl:when>
<xsl:when test="pos='p.p. comme adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:pastParticipleAdjective</xsl:when>
<xsl:when test="pos='p.p. pris comme adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:pastParticipleAdjective</xsl:when>
<xsl:when test="pos='p.prés.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ;
  lexinfo:VerbFormMood lexinfo:participle</xsl:when>
<xsl:when test="pos='p.prés. comme adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:presentParticipleAdjective</xsl:when>
<xsl:when test="pos='p.prés. pris comme adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:presentParticipleAdjective</xsl:when>

<xsl:when test="pos='pron.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Pronoun</xsl:when>
<xsl:when test="pos='pron. pers.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:personalPronoun</xsl:when>
<xsl:when test="pos='pron. dém.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:demonstrativePronoun</xsl:when>
<xsl:when test="pos='pron. indéfini'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:indefinitePronoun</xsl:when>
<xsl:when test="pos='pron. interrog.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:interrogativePronoun</xsl:when>
<xsl:when test="pos='pron. poss.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:possessivePronoun</xsl:when>
<xsl:when test="pos='pron. rel.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:relativePronoun</xsl:when>
<xsl:when test="pos='pron. adv.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:adverbialPronoun</xsl:when>
<xsl:when test="pos='pron. adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Pronoun</xsl:when>

<xsl:when test="pos='loc.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. adj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adjective ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. adv.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Adverb ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. verb.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:verb ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. subst.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Noun ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. interj.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Interjection ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. prép.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Preposition ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='loc. pron.'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
  lexinfo:Pronoun ;
  lexinfo:TermType lexinfo:phraseologicalUnit</xsl:when>
<xsl:when test="pos='nom propre'">lexinfo:PartOfSpeech "<xsl:value-of select="pos"/>" ,
    lexinfo:properNoun</xsl:when>
<xsl:otherwise>PartOfSpeech unspecified</xsl:otherwise></xsl:choose>
</xsl:template>

</xsl:stylesheet>
