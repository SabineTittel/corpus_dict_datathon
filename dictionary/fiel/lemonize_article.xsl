<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change ST 2017-08-22 -->

<xsl:output method="rdf"/>
<xsl:preserve-space elements="*"/>


<title>
<lemma developed="false" language="afr.">fiel</lemma>
<pos>m.</pos>
</title>


# metadata annotation
:corpus dct:creator _:sabine_tittel ;
        dct:license "https://creativecommons.org/licenses/by-nc/4.0/" ;
        dct:date "2017-06-29"^^xsd:date .

_:sabine_tittel foaf:familyName "Tittel" ;
				foaf:givenName "Sabine" ;
				foaf:homepage "http://www.deaf-page.de/".
<article articleType="normal" author="Sabine Tittel" type="longarticle">
...
</article>
<xsl:template match="article">
  # metadata annotation

</xsl:template>

<xsl:template match="etymologie" />

<variant>
<description>
<m:cited-word index="f" language="afr.">fiel</m:cited-word>
...
</description>
...
</variant>

<xsl:template match="variant">
	<xsl:apply-templates select="description"/>
  <xsl:apply-templates select="m:cited-word">
    mach hier was
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="description">
  <xsl:apply-templates/>
</xsl:template>

<!-- sollte alle variant als solche erhalten; die erste Variante braucht noch type="standard"
hm, geht nicht. Vielleicht so: wenn in title lemma developed="false" dann die Form = Standard, wenn developed="true", dann kein Standard
-->
<xsl:choose>
  <xsl:when test="lemma/@developed='false'">mach erste Variante zu canonicalForm
  </xsl:when>
  <xsl:otherwise>mach erste Variante nicht zu canonicalForm</xsl:otherwise>
</xsl:choose>
<!-- aus language="" noch was machen -->


<sense>
<description>
<m:terminology type="medecine">t. de méd.</m:terminology>
<m:definition>liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
</description>
...
</sense>

<sense>
<description>
<m:idem>
<m:definition visible="false">liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
“id., des animaux”
</m:idem>
</description>
...
</sense>

<sense>
<description>
<m:idem>
<m:definition visible="false">liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
“id., des animaux de boucherie, de la volaille, de la pêche”
</m:idem>
</description>
...
</sense>

<sense>
<description>
<m:definition>liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
, comme
<m:usage type="metaphor">métaph.</m:usage>
pour désigner une substance amère, un venin⁠
</description>
...
</sense>

<sense>
<description>
<m:idem>
<m:definition visible="false">liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
“id.”, dans une expression figurée de l’Ancien Testament
<m:collocation>doner en ma viande fiel</m:collocation>
++/++
<m:collocation>doner a boire aigue de fiel</m:collocation>
et sim. et dans des expressions analogues du Nouveau Testament
<m:collocation>de fiel abevrer</m:collocation>
et sim. qui signifient
<m:definition>infliger une humiliation</m:definition>
</m:idem>
<m:footnote>
Cp.
<m:siglum>Trénel</m:siglum>
393.
</m:footnote>
</description>
...
</sense>

<!-- collocation -->
<sense>
<description>
<m:collocation>fiel de tor</m:collocation>
++/++
<m:collocation>fiel de torel</m:collocation>
<m:idem>
<m:definition visible="false">liquide verdâtre et amer qui est contenu dans la vésicule biliaire, bile</m:definition>
“id., du taureau”
</m:idem>
(dans des recettes médicales) [v. la
<m:remark-reference n="1">rem. no1</m:remark-reference>
ci-dessus]⁠
</description>
...
</sense>

<sense>
<description>
<m:collocation>fiel noir</m:collocation>
<m:terminology type="medecine">t. de méd.</m:terminology>
<m:definition>dans l’humorisme, celle des quatre humeurs cardinales qui est sécrétée par la rate, qui a les qualités ‘froid’ et ‘sec’ et qui gouverne la mélancolie dans le corps, bile noire</m:definition>
<m:footnote>
V. →
<m:link>
<m:cited-word>
froit
<m:sup>1</m:sup>
</m:cited-word>
</m:link>
et
<m:link>
<m:cited-word>sec</m:cited-word>
</m:link>
DEAFpré.
</m:footnote>
</description>
...
</sense>




<!-- löschen -->

<xsl:template match="m:footnote" />
<xsl:template match="etymology" />


</xsl:stylesheet>
