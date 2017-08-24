<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-23 -->

<xsl:output method="text"/>
<xsl:preserve-space elements="*"/>


<xsl:template match="article">
<xsl:text disable-output-escaping="yes"><![CDATA[@prefix :        <http://deaf-server.adw.uni-heidelberg.de/lemme/> .
@prefix deaf:    <http://deaf-server.adw.uni-heidelberg.de#> .
@prefix ontolex: <http://www.w3.org/ns/lemon/ontolex#> .
@prefix dbpedia: <http://www.dbpedia.org/resource/> .
@prefix dct:     <http://purl.org/dc/terms/>.
@prefix rdfs:    <http://www.w3.org/2001/02/rdf-schema#>.
@prefix lexinfo: <http://www.lexinfo.net/ontology/2.0/lexinfo#>.
@prefix foaf:    <http://xmlns.com/foaf/0.1/>.
@prefix xsd:     <http://www.w3.org/2001/XMLSchema#> .
@prefix olia:    <http://purl.org/olia/olia.owl#>.
@prefix decomp:  <http://purl.org/kdict/decomp#>.]]>
</xsl:text>

# language register
deaf:TechReg a olia:TechnicalRegister .

# metadata annotation
:corpus dct:creator [
	foaf:name "<xsl:value-of select="@author"/>" ;
	foaf:homepage "http://www.deaf-page.de/"
	] ;
	dct:license "https://creativecommons.org/licenses/by-nc/4.0/" ;
    dct:date "<xsl:value-of  select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>"^^xsd:date .

    <xsl:apply-templates select="part"/>
</xsl:template>


<xsl:template match="part[@type='mainpart']">
	<xsl:apply-templates select="title"/>
     <xsl:apply-templates select="etymology"/>
     <xsl:apply-templates select="variants"/>
     <xsl:apply-templates select="senses"/>
</xsl:template>

<xsl:template match="part/title">
# lexical entry
:<xsl:value-of select="lemma"/> a ontolex:LexicalEntry ,
	ontolex:Word ;
	lexinfo:partOfSpeech "<xsl:value-of select="pos"/>" ,
	<xsl:choose><xsl:when test="pos='m.'">lexinfo:noun ;
	lexinfo:gender lexinfo:masculine
  </xsl:when>
  <xsl:when test="pos='f.'">lexinfo:noun ;
    lexinfo:gender lexinfo:feminine</xsl:when>
  <xsl:otherwise>TODO</xsl:otherwise></xsl:choose>
  <xsl:choose><xsl:when test="lemma/@developed='false'">  ;
    ontolex:canonicalForm :<xsl:value-of select="lemma"/>_form_<xsl:value-of select="lemma"/>
	[ a ontolex:Form ;
	ontolex:writtenRep "<xsl:value-of select="lemma"/>"@fro
	] .
  </xsl:when>
  <xsl:otherwise> .</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:variable name="lemma_name" select="//part[@type='mainpart']/title/lemma" />

<xsl:template match="part/etymology"/>

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
:<xsl:value-of select="$lemma_name"/> ontolex:otherForm :<xsl:value-of select="$lemma_name"/>_form_<xsl:value-of select="."/>
	[ a ontolex:Form ;
	ontolex:writtenRep "<xsl:value-of select="."/>"@fro
	] .
</xsl:for-each>
</xsl:template>

<xsl:template match="part/senses">
# --- senses ----------------
	<xsl:apply-templates select="sense"/>
</xsl:template>

<xsl:template match="part/senses/sense">
# main sense number <xsl:number format="1"/>
:<xsl:value-of select="$lemma_name"/> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept .
  <xsl:apply-templates select="description"/>
  <xsl:apply-templates select="sense"/>
</xsl:template>

<xsl:template match="part/senses/sense/description">
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> a ontolex:LexicalSense ;
    ontolex:isLexicalizedSenseOf :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept ;
    ontolex:reference dbpedia: -?- ;<xsl:if test="m:terminology">
    dct:subject "<xsl:value-of select="m:terminology/@type"/>", dbpedia: -?- ;
    olia:hasRegister deaf:TechReg , "<xsl:value-of select="m:terminology"/>" ;</xsl:if>
    <xsl:if test="m:usage">
    ontolex:usage "<xsl:value-of select="m:usage"/>", dbpedia: -?- ;</xsl:if>
    rdfs:comment "DEAF article /<xsl:value-of select="$lemma_name"/>/ main sense number <xsl:number count="part/senses/sense" format="1"/>" .

<!-- this part is not touched by terminology and usage -->
:<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/>_lexConcept a ontolex:LexicalConcept ;
    ontolex:isConceptOf dbpedia: -?- ;
    ontolex:definition "<xsl:apply-templates select="m:definition" mode="italics"/>"@fr ;
    ontolex:lexicalizedSense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number count="part/senses/sense" format="1"/> .
</xsl:template>

<xsl:template match="/m:definition">
  <xsl:apply-templates select="m:cited-word"/>
</xsl:template>
<xsl:template match="m:cited-word" mode="italics">/<xsl:value-of select="."/>/</xsl:template>


<!-- sub senses -->

<xsl:template match="part/senses/sense/sense">
# sub sense number <xsl:number level="multiple" format="1.a"/>
:<xsl:value-of select="$lemma_name"/> ontolex:sense :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/> ;
  ontolex:evokes :<xsl:value-of select="$lemma_name"/>_sense<xsl:number level="multiple" format="1.a"/>_lexConcept .
  <xsl:apply-templates select="description"/>
</xsl:template>

<xsl:template match="part/senses/sense/sense/description">
  description level, d.h. alle sub senses
<xsl:value-of select="m:definition"/>
<xsl:apply-templates select="m:idem"/>
</xsl:template>

<xsl:template match="part/senses/sense/sense/description/m:idem">
 idem level
  <xsl:apply-templates select="m:definition"/>
</xsl:template>

<!-- delete all sublemmata... for the moment -->

<xsl:template match="part[@type='subpart']"/>

</xsl:stylesheet>
