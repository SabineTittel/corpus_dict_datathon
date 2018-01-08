<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:heb="www.usc.es/athene"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:function name="heb:expan-uris" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:value-of select="replace(replace(replace($arg, 'guichaul:','http://www.deaf-page.de/guichaul.html/#'),'deaf:', 'https://deaf-server.adw.uni-heidelberg.de/lemme/'), 'viaf', 'https://viaf.org/viaf/')"/>
    </xsl:function>
    <xsl:template match="@* | node()">
        <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>        
    </xsl:template>
    <xsl:template match="listPrefixDef">
        <listPrefixDef>
            <prefixDef ident="foaf" matchPattern="([A-Za-z]+)"
                replacementPattern="http://xmlns.com/foaf/0.1/$1"/>
            <prefixDef ident="dc" matchPattern="([A-Za-z]+)"
                replacementPattern="http://purl.org/dc/terms/$1"/>
            <prefixDef ident="rdfs" matchPattern="([A-Za-z]+)"
                replacementPattern="http://www.w3.org/2000/01/rdf-schema#$1"/>
            <prefixDef matchPattern="([A-Za-z]+)"
                replacementPattern="http://www.w3.org/2004/02/skos/core#$1" ident="skos"/>
        </listPrefixDef>
    </xsl:template>
    <xsl:template match="@about">
        <xsl:attribute name="about"><xsl:value-of select="heb:expan-uris(.)"/></xsl:attribute>
    </xsl:template>
    <xsl:template match="@resource">
        <xsl:attribute name="resource"><xsl:value-of select="heb:expan-uris(.)"/></xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
