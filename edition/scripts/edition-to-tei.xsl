<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!--    </wdx>
 <edmactext>les parties</edmactext><edmacfn>Ms. <i>laes parties</i>.</edmacfn>
 <wdx><orth/><lemma>partie</lemma><gloss>f. `élément d'un tout; partie'</gloss><var/></wdx> qui
  appare<i>n</i>-->
    
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="../tei-edition.xml">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Information about the source</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:apply-templates select="fromLatex"/>
                </body>
            </text>
        </TEI>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="p">
        <xsl:element name="p">
            <xsl:if test="current()/@type">
                <xsl:attribute name="type">ueber</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="pb">
        <pb n="{@n}"/>
    </xsl:template>
    <xsl:template match="wdx">
        <xsl:element name="entryFree">
            <xsl:attribute name="corresp">uri</xsl:attribute>
            <orth><xsl:apply-templates select="orth"/></orth>
            <form type="lemma"><xsl:apply-templates select="lemma"/></form>
            <xsl:apply-templates select="gloss"/>
            <xsl:if test="var/node()">
                <form type="variant"><xsl:apply-templates select="var"/></form>
                <!--Inflection?-->
            </xsl:if>
        </xsl:element>
    </xsl:template>
    <xsl:template match="gloss">
        <xsl:analyze-string select="." regex="^(.*)\s+`">
            <xsl:matching-substring>
                <pos><xsl:value-of select="regex-group(1)"/></pos>
            </xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:analyze-string select="." regex="`(.*?)'">
            <xsl:matching-substring>
                <sense><xsl:value-of select="regex-group(1)"/></sense>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template match="var/i">
        <xsl:analyze-string select="." regex="`(.*?)'">
            <xsl:matching-substring>
                <sense><xsl:value-of select="regex-group(1)"/></sense>
            </xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:analyze-string select="." regex="^(\w+\.)(\w+\.)*\s+">
            <xsl:matching-substring>
                <pos><xsl:value-of select="concat(regex-group(1), regex-group(2))"/></pos>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template match="b">
        <hi><xsl:apply-templates/></hi>
    </xsl:template>
</xsl:stylesheet>