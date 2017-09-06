<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-31 -->

<xsl:output method="text"/>
<xsl:preserve-space elements="*"/>
<xsl:import href="pos.xsl"/>
<xsl:import href="terminology.xsl"/>
<xsl:import href="usage.xsl"/>
<xsl:import href="locution.xsl"/>
<xsl:import href="idem.xsl"/>
<!-- set /old french words/ (<m:cited-word>) as part of definitions in /.../ -->
<xsl:template match="/m:definition">
  <xsl:apply-templates select="m:cited-word"/>
</xsl:template>
<xsl:template match="m:cited-word" mode="italics">/<xsl:value-of select="."/>/</xsl:template>
<xsl:template match="m:footnote"/>
<!-- delete all sublemmata... for the moment -->
<xsl:template match="part[@type='subpart']"/>


<xsl:template match="article">
<xsl:text disable-output-escaping="yes"><![CDATA[@prefix :         <http://dag.adw.uni-heidelberg.de/lemme/> .
@prefix deaf:     <http://deaf-server.adw.uni-heidelberg.de#> .
@prefix hw:       <http://deaf-server.adw.uni-heidelberg.de/hw#> .
@prefix ontolex:  <http://www.w3.org/ns/lemon/ontolex#> .
@prefix vartrans: <http://www.w3.org/ns/lemon/vartrans#> .
@prefix dbpedia:  <http://www.dbpedia.org/resource/> .
@prefix dct:      <http://purl.org/dc/terms/> .
@prefix rdf:      <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:     <http://www.w3.org/2001/02/rdf-schema#> .
@prefix lexinfo:  <http://www.lexinfo.net/ontology/2.0/lexinfo#> .
@prefix foaf:     <http://xmlns.com/foaf/0.1/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .
@prefix olia:     <http://purl.org/olia/olia.owl#> .
@prefix decomp:   <http://purl.org/kdict/decomp#> .]]>
</xsl:text>

# language register
deaf:TechReg a olia:TechnicalRegister .

# semantic and onomasiologic specification properties
deaf:idem rdf:type rdf:Property .
deaf:onomCat rdf:type rdf:Property .
hw:onomCat rdf:type rdf:Property .
hw:name rdf:type rdf:Property .

# metadata annotation
:corpus dct:creator
  [
	foaf:name "<xsl:value-of select="@author"/>" ;
	foaf:homepage "http://www.deaf-page.de/"
	] ;
	dct:license "https://creativecommons.org/licenses/by-nc/4.0/" ;
  dct:date "<xsl:value-of select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>"^^xsd:date .

<xsl:apply-templates select="part"/>
</xsl:template>


<xsl:template match="part[@type='mainpart']">
	<xsl:apply-templates select="title"/>
     <xsl:apply-templates select="etymology"/>
     <xsl:apply-templates select="variants"/>
     <xsl:apply-templates select="senses"/>
</xsl:template>

<!-- ..............................................................
      lexical entry
................................................................... -->

<xsl:template match="part/title">
# lexical entry
:<xsl:value-of select="lemma"/> a ontolex:LexicalEntry ,
	ontolex:Word ;
  <xsl:if test="pos">
  <xsl:call-template name="pos_extern"/>
  </xsl:if>
  <xsl:choose><xsl:when test="lemma/@developed='false'"> ;
  ontolex:canonicalForm :<xsl:value-of select="lemma"/>_form_<xsl:value-of select="lemma"/> .
:<xsl:value-of select="lemma"/>_form_<xsl:value-of select="lemma"/>	a ontolex:Form ;
	ontolex:writtenRep "<xsl:value-of select="lemma"/>"@pro .
  </xsl:when>
  <xsl:otherwise> .</xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:variable name="lemma_name" select="//part[@type='mainpart']/title/lemma" />

<xsl:template match="part/etymology"/>

<!-- ..............................................................
      graphical variants
................................................................... -->

<xsl:template match="part/variants">
# --- graphical variants ----------------
	<xsl:apply-templates select="variant"/>
</xsl:template>

<xsl:template match="part/variants/variant">
	<xsl:apply-templates select="description"/>
</xsl:template>

<xsl:template match="part/variants/variant/description">
<xsl:for-each select="m:cited-word[not(. = $lemma_name)]">
# graphical variant
:<xsl:value-of select="$lemma_name"/> ontolex:otherForm :<xsl:value-of select="$lemma_name"/>_form_<xsl:value-of select="."/> .
:<xsl:value-of select="$lemma_name"/>_form_<xsl:value-of select="."/> a ontolex:Form ;
	ontolex:writtenRep "<xsl:value-of select="."/>"@pro .
</xsl:for-each>
</xsl:template>

<!-- ..............................................................
      main senses
................................................................... -->

<xsl:template match="part/senses">
# --- senses ----------------
<xsl:apply-templates select="sense"/>
</xsl:template>


<xsl:template match="part/senses/sense">
# main sense number <xsl:number format="1"/>
<xsl:choose>
<!-- collocation -->
<xsl:when test="./description/m:collocation">
# collocation "<xsl:value-of select="./description/m:collocation[1]"/>"
:<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  vartrans:senseRelation lexinfo:collocation ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
 </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:collocation[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ main sense number <xsl:number count="part/senses/sense" format="1"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="m:designation[1]"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> .
</xsl:when>

<!-- locution -->
<xsl:when test="./description/m:locution">
# locution "<xsl:value-of select="./description/m:locution[1]"/>"
:<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  <xsl:call-template name="locution_extern"/> ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:locution[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ main sense number <xsl:number count="part/senses/sense" format="1"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="m:designation[1]"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> .
</xsl:when>

<!-- compound -->
<xsl:when test="./description/m:compound">
# compound "<xsl:value-of select="./description/m:compound[1]"/>"
:<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  lexinfo:TermType lexinfo:compound ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:compound[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ main sense number <xsl:number count="part/senses/sense" format="1"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="m:designation[1]"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> .
</xsl:when>

<!-- default: non of the above -->
<xsl:otherwise>
:<xsl:value-of select="$lemma_name"/> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept .
<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ main sense number <xsl:number count="part/senses/sense" format="1"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> .
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="sense"/>
</xsl:template>




<!-- ..............................................................
      sub senses
................................................................... -->

<xsl:template match="part/senses/sense/sense">
# sub sense number <xsl:number level="multiple" format="1.a"/>
<xsl:choose>
<!-- collocation -->
<xsl:when test="./description/m:collocation">
# collocation "<xsl:value-of select="./description/m:collocation[1]"/>"
:<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  vartrans:senseRelation lexinfo:collocation ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:collocation[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>

<!-- inside idem -->
<xsl:when test="./description/m:idem/m:collocation">
# collocation inside idem "<xsl:value-of select="./description/m:idem/m:collocation[1]"/>"
<!-- alle pfade anpassen -->
:<xsl:for-each select="tokenize(./description/m:idem/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  vartrans:senseRelation lexinfo:collocation ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:idem/m:collocation[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:idem/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:idem/m:collocation[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:idem/m:collocation[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  deaf:idem "<xsl:call-template name="idem_extern"/>"@fr ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology or ./description/m:idem/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage or ./description/m:idem/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>
<!-- end collocation -->

<!-- locution -->
<xsl:when test="./description/m:locution">
# locution "<xsl:value-of select="./description/m:locution[1]"/>"
:<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  <xsl:call-template name="locution_extern"/> ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:locution[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>

<!-- inside idem -->
<xsl:when test="./description/m:idem/m:locution">
# collocation "<xsl:value-of select="./description/m:idem/m:locution[1]"/>"
:<xsl:for-each select="tokenize(./description/m:idem/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  vartrans:senseRelation lexinfo:collocation ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:idem/m:locution[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:idem/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:idem/m:locution[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:idem/m:locution[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  deaf:idem "<xsl:call-template name="idem_extern"/>"@fr ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology or ./description/m:idem/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage or ./description/m:idem/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>
<!-- end locution -->

<!-- compound -->
<xsl:when test="./description/m:compound">
# compound "<xsl:value-of select="./description/m:compound[1]"/>"
:<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  lexinfo:TermType lexinfo:compound ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:compound[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>

<!-- inside idem -->
<xsl:when test="./description/m:idem/m:compound">
# collocation "<xsl:value-of select="./description/m:idem/m:compound[1]"/>"
:<xsl:for-each select="tokenize(./description/m:idem/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:LexicalEntry ,
  ontolex:MultiwordExpression ;
  decomp:subterm :<xsl:value-of select="$lemma_name"/> ;
  vartrans:senseRelation lexinfo:collocation ;
  ontolex:canonicalForm :form_<xsl:for-each select="tokenize(./description/m:idem/m:compound[1],' ')">
    <xsl:sequence select="."/>
    <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> .
:form_<xsl:for-each select="tokenize(./description/m:idem/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> a ontolex:Form ;
  ontolex:writtenRep "<xsl:value-of select="./description/m:idem/m:compound[1]"/>"@pro .

:<xsl:for-each select="tokenize(./description/m:idem/m:compound[1],' ')">
  <xsl:sequence select="."/>
  <xsl:if test="not(position() eq last())">_</xsl:if>
  </xsl:for-each> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  deaf:idem "<xsl:call-template name="idem_extern"/>"@fr ;
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology or ./description/m:idem/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage or ./description/m:idem/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:when>
<!-- end compound -->

<!-- default: non of the above -->
<xsl:otherwise>
:<xsl:value-of select="$lemma_name"/> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .

<!-- this part defines m:terminology and m:usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> a ontolex:LexicalSense ;
  ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept ;
  <xsl:if test="./description/m:idem">deaf:idem "<xsl:call-template name="idem_extern"/>"@fr ;</xsl:if>
  ontolex:reference dbpedia:XXX ;<xsl:if test="./description/m:terminology or ./description/m:idem/m:terminology">
  <xsl:call-template name="terminology_extern"/></xsl:if>
  <xsl:if test="./description/m:usage or ./description/m:idem/m:usage">
  <xsl:call-template name="usage_extern"/></xsl:if>
  rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ sub sense number <xsl:number level="multiple" format="1.a"/>"@eng .

<!-- m:definition -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept a ontolex:LexicalConcept ;
  ontolex:isConceptOf dbpedia:XXX ;
  ontolex:definition "<xsl:apply-templates select="./description/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:idem/m:definition[1]" mode="italics"/><xsl:apply-templates select="./description/m:designation[1]"/><xsl:apply-templates select="./description/m:idem/m:designation[1]" mode="italics"/>"@fr ;
  deaf:onomCat
  [
  hw:conceptCat "<xsl:value-of select="./description/m:cat-onomas/@cat"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@cat"/>" ;
  hw:conceptName "<xsl:value-of select="./description/m:cat-onomas/@concept"/><xsl:value-of select="./description/m:idem/m:cat-onomas/@concept"/>"@fr
  ] ;
  ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> .
</xsl:otherwise>

</xsl:choose>
 <xsl:apply-templates select="part/senses/sense/sense/description"/>
</xsl:template>

<xsl:template match="part/senses/sense/sense/description">
 <xsl:apply-templates select="part/senses/sense/sense/description/m:idem"/>
</xsl:template>


</xsl:stylesheet>
