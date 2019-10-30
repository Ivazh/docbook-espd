<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСПД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Примечания, важно, предупреждения -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:d="http://docbook.org/ns/docbook"
    version="1.1">

    <xsl:param name="admon.graphics.extension">.svg</xsl:param>
    <xsl:param name="admon.graphics.path">../common/figures/</xsl:param>
    <xsl:param name="admon.graphics">0</xsl:param>

    <xsl:attribute-set name="nongraphical.admonition.properties">
        <xsl:attribute name="padding-right">0</xsl:attribute>
        <xsl:attribute name="padding-left">0</xsl:attribute>
        <xsl:attribute name="margin-left">0</xsl:attribute>
        <xsl:attribute name="margin-right">0</xsl:attribute>
        <xsl:attribute name="space-before.optimum">5mm</xsl:attribute>
        <xsl:attribute name="space-before.minimum">5mm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">5mm</xsl:attribute>
        <xsl:attribute name="space-after.optimum">5mm</xsl:attribute>
        <xsl:attribute name="space-after.minimum">5mm</xsl:attribute>
        <xsl:attribute name="space-after.maximum">5mm</xsl:attribute>
        <xsl:attribute name="text-indent">
            <xsl:value-of select="$espd.text-indent"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="admonition.title.properties">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-size">1em</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="admonition.properties">
        <xsl:attribute name="text-indent"><xsl:value-of select="$espd.text-indent"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="nongraphical.admonition">
        <xsl:param name="content">
            <xsl:apply-templates />
        </xsl:param>
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <fo:block id="{$id}" space-after="5mm"
                  space-before="5mm">
            <fo:block xsl:use-attribute-sets="admonition.properties">
<!--                <fo:inline xsl:use-attribute-sets="admonition.title.properties">-->
<!--                    <xsl:apply-templates select="." mode="object.title.markup"/>-->
<!--                </fo:inline>-->

                <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="d:note/d:para[1]">
        <xsl:variable name="text">
            <xsl:choose>
                <xsl:when test="parent::d:note/@multiple"><xsl:text>П р и м е ч а н и я: </xsl:text></xsl:when>
                <xsl:otherwise><xsl:text>П р и м е ч а н и е &#x2013; </xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:block xsl:use-attribute-sets="admonition.properties">
            <fo:inline xsl:use-attribute-sets="admonition.title.properties">
                <xsl:value-of select="$text"/>
            </fo:inline>
            <fo:inline>
                <xsl:apply-templates/>
            </fo:inline>


        </fo:block>
    </xsl:template>
    <xsl:template match="d:note/d:figure">
        <fo:block text-indent="0">
            <xsl:apply-imports/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>

