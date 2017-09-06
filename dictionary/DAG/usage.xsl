<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-31 -->

<xsl:template name="usage_extern">
<xsl:choose>
<xsl:when test="./description/m:usage/@type='image' or ./description/m:idem/m:usage/@type='image'">
  ontolex:usage dbpedia:Trope_(literature) ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='metaphor' or ./description/m:idem/m:usage/@type='metaphor'">
  ontolex:usage dbpedia:Metaphor ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='metonymy' or ./description/m:idem/m:usage/@type='metonymy'">
  ontolex:usage dbpedia:Metonymy ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='allegory' or ./description/m:idem/m:usage/@type='allegory'">
  ontolex:usage dbpedia:Allegory ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='comparison' or ./description/m:idem/m:usage/@type='comparison'">
  ontolex:usage dbpedia:Comparison ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='irony' or ./description/m:idem/m:usage/@type='irony'">
  ontolex:usage dbpedia:Irony ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='euphemism' or ./description/m:idem/m:usage/@type='euphemism'">
  ontolex:usage dbpedia:Euphemism ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='extension' or ./description/m:idem/m:usage/@type='extension'">
  ontolex:usage dbpedia:Extension_(semantics) ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='malediction' or ./description/m:idem/m:usage/@type='malediction'">
  ontolex:usage dbpedia:Malediction ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='salutation' or ./description/m:idem/m:usage/@type='salutation'">
  ontolex:usage dbpedia:Salutation ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='toponym' or ./description/m:idem/m:usage/@type='toponym'">
  ontolex:usage dbpedia:Category:Place_names ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='antroponym' or ./description/m:idem/m:usage/@type='antroponym'">
  ontolex:usage dbpedia:Proper_noun ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='minimal-value' or ./description/m:idem/m:usage/@type='minimal-value'">
  ontolex:usage dbpedia:Maxima_and_minima ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='collective' or ./description/m:idem/m:usage/@type='collective'">
  ontolex:usage dbpedia:Collective ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='insult' or ./description/m:idem/m:usage/@type='insult'">
  ontolex:usage dbpedia:Insult ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='pejorative' or ./description/m:idem/m:usage/@type='pejorative'">
  ontolex:usage dbpedia:Pejorative ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='analogy' or ./description/m:idem/m:usage/@type='analogy'">
  ontolex:usage dbpedia:Analogy ,
  "<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:usage/@type='personification' or ./description/m:idem/m:usage/@type='personification'">
  ontolex:usage dbpedia:Antropomorphism ,
"<xsl:value-of select="./description/m:usage"/><xsl:value-of select="./description/m:idem/m:usage"/>"@fr ;</xsl:when>
<xsl:otherwise>usage unspecified</xsl:otherwise></xsl:choose>
</xsl:template>
</xsl:stylesheet>
