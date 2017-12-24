<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:functx="http://www.functx.com" exclude-result-prefixes="#all" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:function name="functx:escape-for-regex" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>

        <xsl:sequence
            select="
                replace($arg,
                '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))', '\\$1')
                "/>

    </xsl:function>

    <xsl:function name="functx:substring-after-last" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence
            select="
                replace($arg, concat('^.*', functx:escape-for-regex($delim)), '')
                "
        />
    </xsl:function>

    <xsl:variable name="lemmata" select="doc('../ancillary-files/lemmata.xml')//main"/>
    <xsl:template match="/">
        <xsl:result-document href="../tei-edition.xml">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>First treatise of the <title>Grande Chirurgie</title> by Gui de
                                Chauliac</title>
                            <principal>Sabine Tittel</principal>
                        </titleStmt>
                        <publicationStmt>
                            <publisher>Dictionnaire étymologique de l’ancien français</publisher>
                            <authority>uni heidelberg</authority>
                        </publicationStmt>
                        <sourceDesc>
                            <bibl><author>Tittel, Sabine</author>. <date>2004</date>. <title
                                    level="m">Die Anathomie in der Grande Chirurgie des Gui de
                                    Chauliac: Wort- und sachgeschichtliche Untersuchungen und
                                    Edition</title>. <pubPlace>Tübingen</pubPlace>:
                                    <publisher>Niemeyer</publisher>. <note>Critical edition of
                                    manuscript Montpellier Bibliothèque de la Faculté de Médecine n°
                                    184 [2nd third 15th c.], by Sabine Tittel</note></bibl>
                        </sourceDesc>
                    </fileDesc>
                    <profileDesc>
                        <langUsage>
                            <language ident="fr" property="dc:language"/>
                        </langUsage>
                    </profileDesc>
                    <encodingDesc>
                        <listPrefixDef>
                            <prefixDef ident="foaf" matchPattern="([A-Za-z]+)"
                                replacementPattern="http://xmlns.com/foaf/0.1/$1"/>
                            <prefixDef ident="dc" matchPattern="([A-Za-z]+)"
                                replacementPattern="http://purl.org/dc/terms/$1"/>
                            <prefixDef ident="rdfs" matchPattern="([A-Za-z]+)"
                                replacementPattern="http://www.w3.org/2000/01/rdf-schema#$1"/>
                            <prefixDef ident="guichaul" matchPattern="(\d+)"
                                replacementPattern="http://www.deaf-page.de/guichaul.html/#$1"/>
                            <prefixDef ident="deaf" matchPattern="(.+)"
                                replacementPattern="http://deaf-server.adw.uni-heidelberg.de/lemme/$1"
                            />
                        </listPrefixDef>
                    </encodingDesc>
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
            <xsl:apply-templates select="child::node() except (edmacfn | edmacentry)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="edmac-item">
        <app>
            <lem><xsl:apply-templates select="wdx|adx[person]"/></lem>
            <xsl:if test="edmacentry">
                <rdg><xsl:apply-templates select="edmacentry"/></rdg>
            </xsl:if>
            <note><xsl:apply-templates select="edmacfn"/></note>
        </app>
    </xsl:template>
    <xsl:template match="edmactext[not(parent::edmac-item)]">
        <app>
            <lem>
               <xsl:apply-templates select="." mode="node"/>
            </lem>
            <xsl:if test="following-sibling::*[1][name() eq 'edmacfn']">
                <note><xsl:apply-templates select="current()/following-sibling::*[1]"/></note>
            </xsl:if>
            <xsl:if test="following-sibling::*[1][name() eq 'edmacentry']/following-sibling::*[1][name() eq 'edmacfn']">
                <rdg><xsl:apply-templates select="current()/following-sibling::*[1]"/></rdg>
                <note><xsl:apply-templates select="current()/following-sibling::*[2]"/></note>
            </xsl:if>
        </app>
    </xsl:template>
    <xsl:template match="edmactext" mode="node">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="i">
        <hi><xsl:apply-templates/></hi>
    </xsl:template>
    <xsl:template match="pb">
        <pb n="{@n}"/>
    </xsl:template>
    <xsl:template match="wdx">
        <xsl:variable name="lemma"
            select="functx:substring-after-last(replace(lemma, '\*', ''), '\s')"/>
        <seg about="guichaul:{count(preceding::wdx) +1}">
            <xsl:element name="w">
                <xsl:attribute name="property">rdfs:label</xsl:attribute>
                <xsl:if test="$lemma = $lemmata">
                <xsl:attribute name="resource"><xsl:value-of select="concat('deaf:', $lemma)"/></xsl:attribute>
                </xsl:if>
            <xsl:attribute name="lemma"><xsl:value-of select="lemma"/></xsl:attribute>
                <xsl:analyze-string select="string-join(gloss/text(), ' ')" regex="^(.*\.)(\d°)?(.+)?\s+`">
                    <xsl:matching-substring>
                        <xsl:if test="not(contains(regex-group(1), 'terme'))">
                        <xsl:attribute name="type"><xsl:value-of select="replace(regex-group(1), '\s', '')"/></xsl:attribute>
                            </xsl:if>
                        <xsl:if test="regex-group(2)">
                             <xsl:attribute name="type"><xsl:value-of select="concat(replace(regex-group(1), '\s', ''), '_', regex-group(2))"/></xsl:attribute>
                        </xsl:if>
                    </xsl:matching-substring>
                </xsl:analyze-string>
                <xsl:if test="var[count(i) eq 1]">
                            <xsl:analyze-string select="var/i" regex="^(\w+\.)(\w+\.)*\s+">
            <xsl:matching-substring>
                <xsl:if test="not(contains(., 'terme d'))">
                    <xsl:attribute name="subtype"><xsl:value-of select="concat(regex-group(1), regex-group(2))"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="contains(., 'terme d')">
                    <xsl:attribute name="subtype"><xsl:value-of select="substring-before(concat(regex-group(1), regex-group(2)), 'terme')"/></xsl:attribute>
                </xsl:if>
            </xsl:matching-substring>
        </xsl:analyze-string>
                </xsl:if>
                 <xsl:apply-templates select="orth"/>
            </xsl:element>

            <xsl:element name="gloss">
                <xsl:variable name="apos">'</xsl:variable>
                <xsl:value-of select="replace(substring-after(gloss, '`'), $apos, '')"/>
            </xsl:element>

            <xsl:choose>
                <xsl:when test="var/node()">
                    <xsl:if test="var eq orth"/>
                    <xsl:if test="var ne orth">
                        <note><xsl:apply-templates select="var"/>
            <xsl:apply-templates select="gloss[matches(., '\.\s+terme\s+d')]"/></note>
                    </xsl:if>
                </xsl:when>
            </xsl:choose>
            </seg>
    </xsl:template>
    <xsl:template match="gloss">
        <xsl:value-of
            select="concat('(terme', substring-before(substring-after(., 'terme'), '`'), ')')"/></xsl:template>
    <xsl:template match="var/i">
        <xsl:analyze-string select="." regex="`(.*?)'">
            <xsl:matching-substring>
                <gloss>
                    <xsl:value-of select="regex-group(1)"/>
                    <xsl:analyze-string select="." regex="^(\w+\.)(\w+\.)*\s+">
                        <xsl:matching-substring>
                            <xsl:if test="contains(., 'terme d')">
                                <xsl:value-of
                                    select="concat('(terme', substring-after(concat(regex-group(1), regex-group(2)), 'terme'), ')')"
                                /></xsl:if>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </gloss>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template match="b">
        <span type="collocation">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="adx[person]">
        <persName typeof="foaf:Person">
            <name property="foaf:name">
                <xsl:value-of select="orth"/>
            </name>
            <name type="standard">
                <xsl:value-of select="person"/>
            </name>
        </persName>
    </xsl:template>
</xsl:stylesheet>
