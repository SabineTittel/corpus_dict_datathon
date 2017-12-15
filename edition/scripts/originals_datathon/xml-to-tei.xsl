<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0" xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:function name="functx:escape-for-regex" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>

        <xsl:sequence select="
            replace($arg,
            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
            "/>

    </xsl:function>

    <xsl:function name="functx:substring-after-last" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select="
            replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
            "/>
    </xsl:function>

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
                <xsl:attribute name="rendition">ueber</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="edmactext">
        <app>
            <lem>
                <xsl:value-of select="."/>
            </lem>
            <note>
                <xsl:value-of select="following-sibling::edmacfn[1]"/>
            </note>
        </app>
    </xsl:template>
    <xsl:template match="edmacentry"/>
    <xsl:template match="edmacfn"/>
    <xsl:template match="pb">
        <pb n="{@n}"/>
    </xsl:template>
    <xsl:template match="wdx">
        <xsl:variable name="lemma" select="functx:substring-after-last(replace(lemma, '\*', ''), '\s')"/>
        <xsl:variable name="lemmaFixed" select="iri-to-uri($lemma)"/>
        <seg  resource="http://deaf-server.adw.uni-heidelberg.de/corpus#{count(preceding::wdx) +1}">
            <xsl:element name="w">
                <xsl:attribute name="about"><xsl:value-of select="concat('http://deaf-server.adw.uni-heidelberg.de/lemme/', $lemmaFixed)"/></xsl:attribute>
                <xsl:attribute name="property">rdfs:label</xsl:attribute>
            <xsl:attribute name="lemma"><xsl:value-of select="lemma"/></xsl:attribute>
                <xsl:analyze-string select="gloss" regex="^(.*)\s+`">
                    <xsl:matching-substring>
                        <xsl:if test="not(contains(regex-group(1), 'terme'))">
                        <xsl:attribute name="type"><xsl:value-of select="replace(regex-group(1), '\s', '')"/></xsl:attribute>
                            </xsl:if>
                    </xsl:matching-substring>
                </xsl:analyze-string>
                 <xsl:apply-templates select="orth"/>
            </xsl:element>

            <xsl:element name="gloss">
                <xsl:variable name="apos">&apos;</xsl:variable>
                <xsl:value-of select="replace(substring-after(gloss, '`'), '$apos', '')"/>
            </xsl:element>

            <xsl:choose>
                <xsl:when test="var/node()">
                    <xsl:if test="var eq orth"/>
                    <xsl:if test="var ne orth">
                        <note><xsl:apply-templates select="var"/></note>
                    </xsl:if>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="gloss[matches(., '\.\s+terme\s+d')]"/>
            </seg>
    </xsl:template>
    <xsl:template match="gloss">
        <interp>
            <xsl:value-of
                select="concat('terme', substring-before(substring-after(., 'terme'), '`'))"/>
        </interp>
    </xsl:template>
    <xsl:template match="var/i">
        <xsl:analyze-string select="." regex="`(.*?)'">
            <xsl:matching-substring>
                <gloss>
                    <xsl:value-of select="regex-group(1)"/>
                </gloss>
            </xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:analyze-string select="." regex="^(\w+\.)(\w+\.)*\s+">
            <xsl:matching-substring>
                <xsl:if test="not(contains(., 'terme d'))">
                    <span type="POS">
                        <xsl:value-of select="concat(regex-group(1), regex-group(2))"/>
                    </span>
                </xsl:if>
                <xsl:if test="contains(., 'terme d')">
                    <span type="POS">
                        <xsl:value-of
                            select="substring-before(concat(regex-group(1), regex-group(2)), 'terme')"
                        />
                    </span>
                    <interp>
                        <xsl:value-of
                            select="concat('terme', substring-after(concat(regex-group(1), regex-group(2)), 'terme'))"
                        />
                    </interp>
                </xsl:if>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template match="b">
        <span type="collocation">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="adx[person]">
        <persName>
            <name>
                <xsl:value-of select="orth"/>
            </name>
            <name type="standard">
                <xsl:value-of select="person"/>
            </name>
        </persName>
    </xsl:template>
</xsl:stylesheet>
