<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"
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
                        <h2>First treatise of the <em>Grande Chirurgie</em> by Gui de Chauliac</h2>
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
        <a href="{span[@property]/@resource}" target="_blank" property="rdfs:label">
            <xsl:value-of select="w"/>
            <span class="gloss">
                <xsl:value-of select="gloss[node()]"/>
            </span>
        </a>
        <xsl:copy-of select="span[@property]" exclude-result-prefixes="#all"/>
    </xsl:template>
    <xsl:template match="gloss"/>
    <xsl:template match="interp"/>
    <xsl:template match="note[parent::seg]"/>
    <xsl:template match="name[@type eq 'standard']"/>
    <xsl:template match="app">
        <xsl:value-of select="lem"/>
        <span class="apparatus">
            <xsl:value-of select="note"/>
        </span>
    </xsl:template>
    <xsl:template match="pb"/>
</xsl:stylesheet>
