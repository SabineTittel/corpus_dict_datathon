<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:m="http://www.deaf-page.de/ns/markup"
>

<!-- last change: ST 2017-08-28 -->

<xsl:template name="terminology_extern">
<xsl:choose>
<xsl:when test="./description/m:terminology/@type='medicine' or ./description/m:idem/m:terminology/@type='medicine'">
  dct:subject dbpedia:Medicine ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='astronomy' or ./description/m:idem/m:terminology/@type='astronomy'">
  dct:subject dbpedia:Astronomy ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='grammar' or ./description/m:idem/m:terminology/@type='grammar'">
  dct:subject dbpedia:Grammar ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='histliterature' or ./description/m:idem/m:terminology/@type='histliterature'">
  dct:subject dbpedia:Literature ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='geography' or ./description/m:idem/m:terminology/@type='geography'">
  dct:subject dbpedia:Geography ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='music' or ./description/m:idem/m:terminology/@type='music'">
  dct:subject dbpedia:Music ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='architecture' or ./description/m:idem/m:terminology/@type='architecture'">
  dct:subject dbpedia:Architecture ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='heraldry' or ./description/m:idem/m:terminology/@type='heraldry'">
  dct:subject dbpedia:Heraldry ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='marine' or ./description/m:idem/m:terminology/@type='marine'">
  dct:subject dbpedia:Marine_engineering ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='botany' or ./description/m:idem/m:terminology/@type='botany'">
  dct:subject dbpedia:Botany ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='pharmacy' or ./description/m:idem/m:terminology/@type='pharmacy'">
  dct:subject dbpedia:Pharmacy ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='theology' or ./description/m:idem/m:terminology/@type='theology'">
  dct:subject dbpedia:Theology ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='falconry' or ./description/m:idem/m:terminology/@type='falconry'">
  dct:subject dbpedia:Falconry ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='equitation' or ./description/m:idem/m:terminology/@type='equitation'">
  dct:subject dbpedia:Equitation ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='agriculture' or ./description/m:idem/m:terminology/@type='agriculture'">
  dct:subject dbpedia:Agriculture ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='law' or ./description/m:idem/m:terminology/@type='law'">
  dct:subject dbpedia:Law ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='mathematics' or ./description/m:idem/m:terminology/@type='mathematics'">
  dct:subject dbpedia:Mathematics ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='cooking' or ./description/m:idem/m:terminology/@type='cooking'">
  dct:subject dbpedia:Cooking ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='liturgy' or ./description/m:idem/m:terminology/@type='liturgy'">
  dct:subject dbpedia:Liturgy ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='philosophy' or ./description/m:idem/m:terminology/@type='philosophy'">
  dct:subject dbpedia:Philosophy ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='onomastics' or ./description/m:idem/m:terminology/@type='onomastics'">
  dct:subject dbpedia:Onomastics ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='veterinary' or ./description/m:idem/m:terminology/@type='veterinary'">
  dct:subject dbpedia:Veterinary ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='war' or ./description/m:idem/m:terminology/@type='war'">
  dct:subject dbpedia:War ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='feudalism' or ./description/m:idem/m:terminology/@type='feudalism'">
  dct:subject dbpedia:Feudalism ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='venery' or ./description/m:idem/m:terminology/@type='venery'">
  dct:subject dbpedia:Hunting ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='game' or ./description/m:idem/m:terminology/@type='game'">
  dct:subject dbpedia:Game ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='craft' or ./description/m:idem/m:terminology/@type='craft'">
  dct:subject dbpedia:Craft ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='history' or ./description/m:idem/m:terminology/@type='history'">
  dct:subject dbpedia:History ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='alchemy' or ./description/m:idem/m:terminology/@type='alchemy'">
  dct:subject dbpedia:Alchemy ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='rhetoric' or ./description/m:idem/m:terminology/@type='rhetoric'">
  dct:subject dbpedia:Rhetoric ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:when test="./description/m:terminology/@type='logic' or ./description/m:idem/m:terminology/@type='logic'">
  dct:subject dbpedia:Logic ,
  "<xsl:value-of select="./description/m:terminology/@type"/><xsl:value-of select="./description/m:idem/m:terminology/@type"/>"@eng ;
  olia:hasRegister deaf:TechReg ,
  "<xsl:value-of select="./description/m:terminology"/><xsl:value-of select="./description/m:idem/m:terminology"/>"@fr ;</xsl:when>
<xsl:otherwise>terminology unspecified</xsl:otherwise></xsl:choose>
</xsl:template>
</xsl:stylesheet>
