<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСКД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->
<!-- Перечисления -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:d="http://docbook.org/ns/docbook"
    exclude-result-prefixes="d"
    version="1.1">


    <xsl:include href="../common/list.xsl"/>

    <!-- Ширина символов перечислений. -->
    <xsl:param name="orderedlist.label.width">0mm</xsl:param>
    <xsl:param name="itemizedlist.label.width">0mm</xsl:param>

    <!-- Отбивка и отступы перечислений -->
    <xsl:attribute-set name="list.block.spacing">
        <xsl:attribute name="space-before.optimum">6pt</xsl:attribute>
        <xsl:attribute name="space-before.minimum">6pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">6pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0mm</xsl:attribute>
        <xsl:attribute name="text-indent">
            <xsl:choose>
                <xsl:when test="count(ancestor::d:orderedlist)=1">25mm</xsl:when>
                <xsl:otherwise>13mm</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <!--<xsl:attribute name="text-indent"><xsl:value-of select="$espd.text-indent"/></xsl:attribute>-->
        <xsl:attribute name="margin-left">0mm</xsl:attribute>
    </xsl:attribute-set>


    <!-- Отбивка пунктов перечислений. -->
    <xsl:attribute-set name="list.item.spacing">
        <xsl:attribute name="space-before.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0mm</xsl:attribute>
        <xsl:attribute name="text-indent">
            <xsl:choose>
                <xsl:when test="count(ancestor::d:orderedlist|ancestor::d:itemizedlist)=1">12.5mm</xsl:when>
                <xsl:when test="count(ancestor::d:orderedlist|ancestor::d:itemizedlist)=2">25mm</xsl:when>
                <xsl:when test="count(ancestor::d:orderedlist|ancestor::d:itemizedlist)=3">30mm</xsl:when>
                <xsl:otherwise>13mm</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <!--<xsl:attribute name="text-indent"><xsl:value-of select="$espd.text-indent"/></xsl:attribute>-->
        <xsl:attribute name="margin-left">0mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="list.block.properties">
        <xsl:attribute name="provisional-label-separation">0mm</xsl:attribute>
        <xsl:attribute name="provisional-distance-between-starts">0mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match="d:itemizedlist/d:listitem|d:orderedlist/d:listitem">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="keep.together">
            <xsl:call-template name="pi.dbfo_keep-together"/>
        </xsl:variable>

        <xsl:variable name="item.contents">
            <fo:list-item-label end-indent="label-end()" xsl:use-attribute-sets="itemizedlist.label.properties">
                <fo:block>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="parent::*/@spacing = 'compact'">
                <fo:list-item id="{$id}" xsl:use-attribute-sets="compact.list.item.spacing">
                    <xsl:if test="$keep.together != ''">
                        <xsl:attribute name="keep-together.within-column">
                            <xsl:value-of
                                    select="$keep.together"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:copy-of select="$item.contents"/>
                </fo:list-item>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
                    <xsl:if test="$keep.together != ''">
                        <xsl:attribute name="keep-together.within-column">
                            <xsl:value-of
                                    select="$keep.together"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:copy-of select="$item.contents"/>
                </fo:list-item>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="d:itemizedlist/d:listitem/d:para">
        <xsl:call-template name="anchor"/>
        <fo:inline padding-right="2mm">-</fo:inline>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:orderedlist/d:listitem/d:para">
        <xsl:call-template name="anchor"/>
        <fo:inline padding-right="2mm">
            <xsl:apply-templates select="parent::*" mode="item-number"/>
        </fo:inline>
        <xsl:apply-templates/>
    </xsl:template>


</xsl:stylesheet>
