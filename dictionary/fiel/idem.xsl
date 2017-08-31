<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-28 -->

<xsl:template name="idem_extern">
<xsl:for-each select="./description/m:idem">
<xsl:choose>
<xsl:when test="contains(current(), 'id., ')">"<xsl:apply-templates select="substring-after(current(),'id., ')" mode="italics"/>"@fr ;
</xsl:when>
<xsl:when test="contains(current(), 'id.”, ')">"<xsl:apply-templates select="substring-after(current(),'id.”, ')" mode="italics"/>"@fr ;
</xsl:when>
<xsl:when test="contains(current(), 'id.” ')">"<xsl:apply-templates select="substring-after(current(),'id.” ')" mode="italics"/>"@fr ;
</xsl:when>
<xsl:when test="contains(current(), 'id. ')">"<xsl:apply-templates select="substring-after(current(),'id. ')" mode="italics"/>"@fr ;
</xsl:when>
<xsl:otherwise>"<xsl:apply-templates select="substring-after(current(),'&lt;/m:definition&gt;')" mode="italics"/>"@fr ;
</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
