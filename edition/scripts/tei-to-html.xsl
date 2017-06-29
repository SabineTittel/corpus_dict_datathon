<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="../edition.html">
        <html>
            <head>
                <title>Anathomie</title>
            </head>
            <body>
                <header>
                    <h1><em>Anathomie</em></h1>
                    <h2>First treatise of the <em>Grande Chirurgie</em> by Gui de Chauliac</h2>
                </header>
                <div>
                    <xsl:apply-templates select="//p"/>
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
    <xsl:template match="seg">
        <a href="{w/@lemmaRef}"><xsl:value-of select="w"/></a>
    </xsl:template>
</xsl:stylesheet>