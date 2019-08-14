<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.1">

  <xsl:template match="d:image">
    <xsl:variable name="src">
      <xsl:call-template name="mediaobject.filename">
        <xsl:with-param name="object" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <xsl:variable name="content">
      <fo:external-graphic>
        <xsl:attribute name="src"><xsl:value-of select="$src"/></xsl:attribute>
      </fo:external-graphic>
      <xsl:call-template name="formal.object.heading">
        <xsl:with-param name="placement" select="'after'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="keep.together">
      <xsl:call-template name="pi.dbfo_keep-together"/>
    </xsl:variable>
    <fo:block id="{$id}" xsl:use-attribute-sets="figure.properties">
      <xsl:if test="$keep.together != ''">
        <xsl:attribute name="keep-together.within-column"><xsl:value-of select="$keep.together"/></xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="$content"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="d:image" mode="xref-to">
    <xsl:param name="referrer"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="verbose" select="1"/>

    <xsl:apply-templates select="." mode="object.xref.markup">
      <xsl:with-param name="purpose" select="'xref'"/>
      <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
      <xsl:with-param name="referrer" select="$referrer"/>
      <xsl:with-param name="verbose" select="$verbose"/>
    </xsl:apply-templates>
  </xsl:template>


</xsl:stylesheet>