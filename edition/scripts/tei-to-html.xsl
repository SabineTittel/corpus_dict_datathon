<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xalan="http://xml.apache.org/xslt"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
<xsl:output method="xml" indent="no" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="../edition.html">
            <html>
                <head>
                    <title>Anathomie</title>
                    <meta charset="utf-8" lang="fr"/>
                    <link href="edition.css" rel="stylesheet" type="text/css"/>
                </head>
                <body>
                    <header>
                        <h1>
                            <em>Anathomie</em>
                        </h1>
                        <h2>First treatise of the <em>Grande Chirurgie</em> by Gui de Chauliac
                        </h2>
                        <h3>Critical edition of manuscript Montpellier Bibliothèque de la Faculté de Médecine n<sup>o</sup>184 [2<sup>nd</sup> third 15<sup>th</sup> c.], by Sabine Tittel
                        </h3>
                    </header>
                    <div>
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
    <xsl:template match="seg[@resource]">
       <a href="{w/@about}" target="_blank" property="rdfs:label">
            <xsl:value-of select="w"/>
            <span class="gloss">
               <xsl:value-of select="gloss[node()]"/>
            </span>
       </a>
       <span property="rdfs:seeAlso" resource="{w/@about}">
       </span>
    </xsl:template>
    <xsl:template match="gloss"/>
    <xsl:template match="interp"/>
    <xsl:template match="note[parent::seg]"/>
    <xsl:template match="name[@type eq 'standard']"/>
    <xsl:template match="app-item">
      <xsl:value-of select="normalize-space(app/lem)"/>
      <a class="apparatus"> &#9632; <span class="apparatus">
          <xsl:value-of select="app/note"/>
      </span></a>
    </xsl:template>
    <xsl:template match="app">
        <xsl:value-of select="lem"/>
        <a class="apparatus"> &#9632; <span class="apparatus">
            <xsl:value-of select="note"/>
        </span></a>
    </xsl:template>
    <xsl:template match="persName">
      <xsl:value-of select="normalize-space(name[not(@*)])"/>
    </xsl:template>
    <xsl:template match="pb">
      <font color="#328bbc">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@n"/>
      <xsl:text>]</xsl:text>
    </font>
    </xsl:template>
</xsl:stylesheet>
