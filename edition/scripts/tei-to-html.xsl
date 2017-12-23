<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="html" indent="no" version="5.0"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="../edition.html">
            <html>
                <head>
                    <title>Anathomie</title>
                    <meta name="keywords" content="medieval french,Gui de Chauliac,Grande Chirurgie"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link href="edition.css" rel="stylesheet" type="text/css"/>
                </head>
                <body>
                    <header>
                        <h1>
                            <em>Anathomie</em>
                        </h1>
                        <h2>First treatise of the <em>Grande Chirurgie</em> by Gui de Chauliac </h2>
                        <h3>Critical edition of manuscript Montpellier Bibliothèque de la Faculté de
                            Médecine n<sup>o</sup>184 [2<sup>nd</sup> third 15<sup>th</sup> c.], by
                            Sabine Tittel </h3>
                    </header>
                    <div prefix="rdfs: http://www.w3.org/2000/01/rdf-schema# foaf: http://xmlns.com/foaf/0.1/ dc: http://purl.org/dc/terms/">
                        <xsl:apply-templates select="//body/p"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="seg[@about]">
        <span about="{replace(@about, 'guichaul:', 'http://www.deaf-page.de/guichaul.html/#')}"><xsl:element name="a">
            <xsl:if test="w/@resource">
                <xsl:attribute name="href">
                    <xsl:value-of select="w/replace(@resource, 'deaf:', 'http://deaf-server.adw.uni-heidelberg.de/lemme/')"/>
                </xsl:attribute>
                <xsl:attribute name="target">_blank</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="property">rdfs:label</xsl:attribute>
            <xsl:value-of select="w"/>
            <span class="gloss"><xsl:apply-templates select="gloss"/></span><span class="hide"><xsl:apply-templates select="note"></xsl:apply-templates></span>
        </xsl:element>
        <xsl:if test="w/@resource">
            <span class="hide" property="rdfs:seeAlso" resource="{w/replace(@resource, 'deaf:', 'http://deaf-server.adw.uni-heidelberg.de/lemme/')}"/>
        </xsl:if></span>
    </xsl:template>
    <xsl:template match="app">
        <xsl:value-of select="lem"/>
        <a class="apparatus"> &#9632; <span class="apparatus">
                <xsl:value-of select="note"/>
            </span></a>
    </xsl:template>
    <xsl:template match="persName">
        <span typeOf="{@typeOf}" property="{name[@property]/@property}"><xsl:apply-templates select="name[@property]"/></span><span class="hide" property="rdfs:seeAlso"><xsl:apply-templates select="name[@type]"></xsl:apply-templates></span>
    </xsl:template>
    <xsl:template match="pb">
        <span class="page">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
</xsl:stylesheet>
