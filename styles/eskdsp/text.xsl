<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСПД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Основной текст. -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:date="http://exslt.org/dates-and-times"
        xmlns:d="http://docbook.org/ns/docbook"
        version="1.1">

    <xsl:template name="set.flow.properties">
        <xsl:attribute name="hyphenate">false</xsl:attribute>
    </xsl:template>

    <!-- Параметры абзаца: отбивка -->
    <xsl:attribute-set name="normal.para.spacing">
        <xsl:attribute name="space-before.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0mm</xsl:attribute>
        <xsl:attribute name="text-indent">0mm</xsl:attribute>
        <xsl:attribute name="text-align">
            <xsl:choose>
                <xsl:when test="@align">
                    <xsl:value-of select="@align"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="parent::d:entry">left</xsl:when>
                        <xsl:otherwise>justify</xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:choose>
                <xsl:when test="@font-size">
                    <xsl:value-of select="@font-size"/>
                </xsl:when>
                <xsl:otherwise>inherit</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="line-height">
            <xsl:choose>
                <xsl:when test="@line-height">
                    <xsl:value-of select="@line-height"/>
                </xsl:when>
                <xsl:otherwise>inherit</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- Параметры абзаца: абзацный отступ -->
    <xsl:attribute-set name="indent.para.spacing"
                       use-attribute-sets="normal.para.spacing">
        <xsl:attribute name="text-indent">
            <xsl:value-of select="$espd.text-indent"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- Абзацный отступ -->
    <xsl:attribute-set name="para.properties"
                       xsl:use-attribute-sets="normal.para.spacing">
        <xsl:attribute name="text-indent">
            <xsl:choose>
                <xsl:when test="parent::d:simplesect
                   |parent::d:section
                   |parent::d:sect1
                   |parent::d:sect2
                   |parent::d:sect3
                   |parent::d:sect4
                   |parent::d:sect5
                   |parent::d:part
                   |parent::d:preface
                   |parent::d:appendix
                   |parent::d:dedication
                   |parent::d:tip
                   |parent::d:chapter
                   |parent::d:abstract
                   |parent::d:paranum
                   |parent::d:note
                   |parent::d:acknowledgements">
                    <xsl:value-of select="$espd.text-indent"/>
                </xsl:when>
                <xsl:when test="count(ancestor::d:listitem)=1">
                    18mm
                </xsl:when>
                <xsl:when test="count(ancestor::d:listitem)=2">
                    30mm
                </xsl:when>
                <xsl:otherwise>0mm</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <!--  <xsl:attribute name="margin-top">1em</xsl:attribute>-->
    </xsl:attribute-set>

    <xsl:template match="d:para[@role = 'statute']|d:paranum">
        <fo:block xsl:use-attribute-sets="para.properties">
          <xsl:if test="@keep">
            <xsl:attribute name="keep-with-next">always</xsl:attribute>
          </xsl:if>
            <xsl:call-template name="anchor"/>
            <xsl:choose>
                <xsl:when test="parent::d:chapter">
                    <xsl:apply-templates select="parent::d:chapter" mode="label.markup"/>
                    <xsl:text>.</xsl:text>
                    <xsl:number from="d:chapter" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
                </xsl:when>
                <xsl:when test="parent::d:section">
                    <xsl:apply-templates select="parent::d:section" mode="label.markup"/>
                    <xsl:text>.</xsl:text>
                    <xsl:number from="d:section" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
                </xsl:when>
                <xsl:when test="parent::d:paranum">
                    <xsl:apply-templates select="parent::d:paranum" mode="label.markup"/>
                    <xsl:text>.</xsl:text>
                    <xsl:number from="parent" count="d:paranum" level="single"/>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="space"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="d:paranum" mode="label.markup">
        <xsl:choose>
            <xsl:when test="parent::d:chapter">
                <xsl:apply-templates select="parent::d:chapter" mode="label.markup"/>
                <xsl:text>.</xsl:text>
                <xsl:number from="d:chapter" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
            </xsl:when>
            <xsl:when test="parent::d:section">
                <xsl:apply-templates select="parent::d:section" mode="label.markup"/>
                <xsl:text>.</xsl:text>
                <xsl:number from="d:section" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
            </xsl:when>
            <xsl:when test="parent::d:paranum">
                <xsl:apply-templates select="parent::d:paranum" mode="label.markup"/>
                <xsl:text>.</xsl:text>
                <xsl:number from="parent" count="d:paranum|d:section" level="single"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="d:para[@role = 'statute']|d:paranum" mode="xref-to">
        <!--    <xsl:text>п.&#160;</xsl:text>-->
        <xsl:choose>
            <xsl:when test="parent::d:chapter">
                <xsl:apply-templates select="parent::d:chapter" mode="label.markup"/>.
                <xsl:number from="d:chapter" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
            </xsl:when>
            <xsl:when test="parent::d:section">
                <xsl:apply-templates select="parent::d:section" mode="label.markup"/>.
                <xsl:number from="d:section" count="d:para[@role='statute']|d:paranum|d:section" level="single"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="d:pararight">
        <fo:block xsl:use-attribute-sets="para.properties" text-align="right">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="processing-instruction('decimal')">
        <xsl:value-of select="/d:book/d:info/d:decimal"/>
    </xsl:template>

    <xsl:template match="processing-instruction('productname')">
        <xsl:value-of select="/d:book/d:info/d:title"/>
    </xsl:template>

    <xsl:template match="processing-instruction('crc')">
        <xsl:value-of select="/d:book/d:info/d:crc"/>
    </xsl:template>

    <xsl:template match="d:subline">
        <xsl:param name="text" select="@text"/>
        <xsl:param name="width" select="@width"/>
        <fo:inline-container>
            <xsl:attribute name="width">
                <xsl:choose>
                    <xsl:when test="$width">
                        <xsl:value-of select="$width"/>
                    </xsl:when>
                    <xsl:otherwise>5cm</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <fo:block>
                <xsl:text>&#160;</xsl:text>
            </fo:block>
            <fo:block text-indent="0mm" text-align="center" text-align-last="center" font-size="12pt"
                      border-top-width="0.2mm" border-top-style="solid">
                <xsl:attribute name="width">
                    <xsl:choose>
                        <xsl:when test="$width">
                            <xsl:value-of select="$width"/>
                        </xsl:when>
                        <xsl:otherwise>5cm</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="$text">
                        <xsl:value-of select="$text"/>
                    </xsl:when>
                    <xsl:otherwise>подпись</xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </fo:inline-container>
    </xsl:template>

    <xsl:template match="d:dateline">
        <fo:inline>
            <xsl:text>«___»___________</xsl:text>
            <xsl:call-template name="datetime.format">
                <xsl:with-param name="date" select="date:date-time()"/>
                <xsl:with-param name="format" select="'Y'"/>
            </xsl:call-template>
            <xsl:text> г.</xsl:text>
        </fo:inline>
    </xsl:template>

    <xsl:template match="d:underline">
        <fo:leader leader-pattern="use-content" leader-length.optimum="100%"
                   leader-alignment="reference-area">_
        </fo:leader>
    </xsl:template>
    <xsl:template match="d:spaceline">
        <fo:leader leader-pattern="space" leader-length.optimum="100%"
                   leader-alignment="reference-area"/>
    </xsl:template>
    <xsl:template match="d:twoblock">
        <fo:block text-align-last="justify">
            <fo:inline>
                <xsl:apply-templates select="d:left"/>
            </fo:inline>
            <fo:leader leader-pattern="space" leader-length.optimum="100%"
                       leader-alignment="reference-area"/>
            <fo:inline>
                <xsl:apply-templates select="d:right"/>
            </fo:inline>
        </fo:block>
    </xsl:template>
    <xsl:template match="d:twoblock/d:left|d:twoblock/d:right">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:phrase">
        <fo:inline keep-together.within-line="always">
            <xsl:call-template name="anchor"/>
            <xsl:call-template name="inline.charseq"/>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>
