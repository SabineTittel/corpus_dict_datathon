<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output method="html" indent="no" version="5.0" omit-xml-declaration="yes"/>
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
                    <div
                        prefix="rdfs: http://www.w3.org/2000/01/rdf-schema# foaf: http://xmlns.com/foaf/0.1/
                        skos: http://www.w3.org/2004/02/skos/core#">
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
        <xsl:element name="span">
            <xsl:attribute name="about">
                <xsl:value-of
                    select="replace(@about, 'guichaul:', 'http://www.deaf-page.de/guichaul.html/#')"
                />
            </xsl:attribute>
            <xsl:if test="@resource">
                <xsl:attribute name="property">
                    <xsl:value-of select="@property"/>
                </xsl:attribute>
                <xsl:attribute name="resource">
                    <xsl:value-of
                        select="replace(@resource, 'deaf:', 'https://deaf-server.adw.uni-heidelberg.de/lemme/')"
                    />
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@resource">
                    <span property="rdfs:label">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="replace(@resource, 'deaf:', 'https://deaf-server.adw.uni-heidelberg.de/lemme/')"
                                />
                            </xsl:attribute>
                            <xsl:attribute name="target">_blank</xsl:attribute>
                            <xsl:apply-templates select="w"/>
                        </xsl:element>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span property="rdfs:label"> <xsl:apply-templates select="w"/></span>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="gloss">
                <span property="{gloss/@property}">
                    <xsl:apply-templates select="gloss"/>
                </span>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="app">
        <xsl:apply-templates select="lem"/>
        <a class="apparatus">&#9632;<span class="apparatus">
                <xsl:if test="rdg"><strong><xsl:apply-templates select="rdg"
                    /></strong><br/></xsl:if>
                <xsl:if test="note"><xsl:apply-templates select="note"/></xsl:if>
            </span></a>
    </xsl:template>
    <xsl:template match="persName">
        <span typeof="{@typeof}" about="{@about}" property="{name[@property]/@property}">
            <xsl:apply-templates select="name[@property]"/>
        </span>
    </xsl:template>
    <xsl:template match="pb">
        <span class="page">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>
    <xsl:template match="span[@type eq 'collocation']">
        <strong>
            <xsl:value-of select="concat(current(), ': ')"/>
        </strong>
    </xsl:template>
    <xsl:template match="hi[@rend eq 'italic']">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="hi[@rend eq 'sc']">
        <span class="sc">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>
