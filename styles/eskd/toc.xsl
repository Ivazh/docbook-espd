<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСКД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Оформление содержания -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="d"
    version="1.1">

<!-- По левому краю все уровни -->
    <xsl:param name="toc.indent.width">0</xsl:param>

<!-- Точка после номера в оглавлении -->
    <xsl:param name="autotoc.label.separator"></xsl:param>

    <xsl:template match="d:*[@role = 'NotInToc']" mode="toc"/>

<!-- Добавляется слово «Приложение» для номера приложений
    и для Apache FOP ровное выравнивание номеров страниц. -->
    <xsl:template name="toc.line">
        <xsl:param name="toc-context" select="NOTANODE"/>

        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="label">
            <xsl:choose>
                <xsl:when test="self::d:appendix">
                    <xsl:call-template name="gentext">
                        <xsl:with-param name="key">appendix</xsl:with-param>
                    </xsl:call-template>
                    <xsl:apply-templates select="." mode="label.markup"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="." mode="label.markup"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:block xsl:use-attribute-sets="toc.line.properties"
                  text-align="justify"
                  text-align-last="justify"
                  white-space-collapse="false">

            <fo:basic-link internal-destination="{$id}">
                <xsl:if test="$label != ''">
                    <xsl:copy-of select="$label"/>
                    <xsl:value-of select="$autotoc.label.separator"/>
                    <xsl:call-template name="space"/>
                </xsl:if>
                <xsl:apply-templates select="." mode="title.markup"/>
            </fo:basic-link>
            <fo:inline keep-with-next.within-line="always">
                <fo:leader leader-pattern="dots"
                           leader-length.minimum="10pt"
                           leader-alignment="page"
                />
            </fo:inline>
            <fo:basic-link internal-destination="{$id}" keep-together.within-line="always">
                <fo:page-number-citation ref-id="{$id}"/>
            </fo:basic-link>
        </fo:block>
    </xsl:template>

    <xsl:template name="page.number.format">1</xsl:template>

    <xsl:template name="initial.page.number">
        <xsl:choose>
            <!-- double-sided output -->
            <xsl:when test="$double.sided != 0">auto-odd</xsl:when>
            <!-- single-sided output -->
            <xsl:otherwise>auto</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="d:gloss">
        <xsl:variable name="term" select="@term"/>
        <xsl:if test="@mean">
            <xsl:choose>
                <xsl:when test="count(preceding::d:gloss[@term = $term])>0">
                    <xsl:value-of select="@term"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@mean"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@term"/>
                    <xsl:text>)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="d:gloss" mode="glossary">
        <xsl:param name="width"/>
        <fo:list-item>
            <fo:list-item-label>
                <fo:block>
                    <xsl:attribute name="end-indent"><xsl:value-of select="$width"/>mm
                    </xsl:attribute>
                    <xsl:value-of select="@term"/>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body>
                <fo:block>
                    <xsl:attribute name="start-indent"><xsl:value-of select="$width"/>mm
                    </xsl:attribute>
                    <fo:list-block>
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>&#x2013;</fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <xsl:value-of select="@def"/>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:key name="glossitem" match="//d:gloss" use="@term"/>

    <xsl:template match="d:glossary">
        <xsl:param name="width">
            <xsl:choose>
                <xsl:when test="@width">
                    <xsl:value-of select="@width"/>
                </xsl:when>
                <xsl:otherwise>30</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:if test="count(//d:gloss)>0">
            <fo:list-block>
                <xsl:for-each select="//d:gloss">
                    <xsl:sort select="@term"/>
                    <xsl:if test="generate-id() = generate-id(key('glossitem',@term)[1])">
                        <xsl:apply-templates select="." mode="glossary">
                            <xsl:with-param name="width">
                                <xsl:value-of select="$width"/>
                            </xsl:with-param>
                        </xsl:apply-templates>
                    </xsl:if>

                </xsl:for-each>
                <!--                <xsl:apply-templates select="$gs" mode="glossary">-->
                <!--                    <xsl:with-param name="width">-->
                <!--                        <xsl:value-of select="$width"/>-->
                <!--                    </xsl:with-param>-->

                <!--                </xsl:apply-templates>-->
            </fo:list-block>
        </xsl:if>
    </xsl:template>

    <xsl:template name="space">
        <fo:inline-container width="2mm">
            <fo:block width="2mm"/>
        </fo:inline-container>
    </xsl:template>

</xsl:stylesheet>
