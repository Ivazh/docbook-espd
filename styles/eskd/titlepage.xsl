<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСПД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Титульный лист. -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:d="http://docbook.org/ns/docbook"
        version="1.1">

    <xsl:import href="design.xsl"/>

    <xsl:attribute-set name="book.titlepage.verso.style"
                       use-attribute-sets="espd.titlepage.style">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="line-height">1.5</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="book.titlepage.verso">
        <!--<fo:page-sequence master-reference="m" format="00001">-->
        <!--<xsl:attribute name="initial-page-number" select="'1'"/>-->
        <!--</fo:page-sequence>-->
        <!-- УТВЕРЖДЕНО -->
        <fo:block-container absolute-position="fixed" display-align="center"
                            top="1.5cm"
                            left="2cm"
                            right="2cm">

            <fo:block xsl:use-attribute-sets="book.titlepage.verso.style" line-height="1.5"
                      text-align="left" font-size="14pt" margin-left="3mm"
            >
                <fo:block text-align="left">Утвержден</fo:block>
                <fo:block text-align="left">
                    <xsl:value-of select="/d:book/d:info/d:decimal"/>
                    <xsl:if test="not(normalize-space(/d:book/d:info/d:docnumber)='')">
                        <xsl:value-of select="/d:book/d:info/d:docnumber"/>
                    </xsl:if>
                    <xsl:text>-ЛУ</xsl:text>
                </fo:block>
            </fo:block>
        </fo:block-container>

        <xsl:if test="/d:book/d:info/d:dsp">
        <fo:block-container absolute-position="fixed" text-align="right" top="1.5cm"
                            left="2cm"
                            right="1cm">
            <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                      text-align="right" font-size="14pt">
                <fo:block>Для служебного пользования</fo:block>
                <fo:block>Экз. № _______________</fo:block>

            </fo:block>
        </fo:block-container>
        </xsl:if>
        <xsl:if test="/d:book/d:info/d:s">
            <fo:block-container absolute-position="fixed" text-align="right" top="1.5cm"
                                left="2cm"
                                right="1cm">
                <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                          text-align="right" font-size="14pt">
                    <fo:block>Для служебного пользования</fo:block>
                    <fo:block>Экз. № _______________</fo:block>
                </fo:block>
            </fo:block-container>
        </xsl:if>

<!--        <fo:block-container absolute-position="fixed"-->
<!--                            top="28cm"-->
<!--                            right="2cm"-->
<!--                            left="2cm">-->
<!--            <fo:block text-align="right">Литера</fo:block>-->
<!--        </fo:block-container>-->

        <xsl:choose>
            <xsl:when test="d:bookinfo/d:title">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:title"/>
            </xsl:when>
            <xsl:when test="d:info/d:title">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:title"/>
            </xsl:when>
            <xsl:when test="d:title">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:title"/>
            </xsl:when>
        </xsl:choose>

        <xsl:choose>
            <xsl:when test="d:bookinfo/d:subtitle">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:bookinfo/d:subtitle"/>
            </xsl:when>
            <xsl:when test="d:info/d:subtitle">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:subtitle"/>
            </xsl:when>
            <xsl:when test="d:subtitle">
                <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:subtitle"/>
            </xsl:when>
        </xsl:choose>

        <!-- Децимальный -->
        <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                  space-before="0.5cm">
            <xsl:value-of select="/d:book/d:info/d:decimal"/>
            <xsl:value-of
                    select="/d:book/d:info/d:docnumber"/>
        </fo:block>

        <!-- Количество листов -->
        <!--fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                  space-before="0.5cm">
            Листов
            <fo:page-number-citation ref-id="END-OF-DOCUMENT"/>
        </fo:block-->

        <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:author"/>
        <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:edition"/>
        <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="d:info/d:pubdate"/>
    </xsl:template>

    <xsl:template match="d:title" mode="book.titlepage.verso.auto.mode">
        <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                  space-before="8cm" >
            <xsl:call-template name="ucase">
                <xsl:with-param name="string">
                    <xsl:call-template name="division.title">
                        <xsl:with-param name="node" select="ancestor-or-self::d:book[1]"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>

    <xsl:template match="d:subtitle" mode="book.titlepage.verso.auto.mode">
        <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"
                  space-before="5mm">
            <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="d:pubdate" mode="book.titlepage.verso.auto.mode">
<!--        <fo:block-container absolute-position="fixed"-->
<!--                            top="27.5cm"-->
<!--                            left="2cm"-->
<!--                            right="0.5cm">-->
<!--            <fo:block xsl:use-attribute-sets="book.titlepage.verso.style"-->
<!--                      space-before="5mm">-->
<!--                <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>-->
<!--            </fo:block>-->
<!--        </fo:block-container>-->
    </xsl:template>

    <xsl:template match="d:bookinfo/d:pubdate|d:book/d:info/d:pubdate"
                  mode="titlepage.mode" priority="2">
        <fo:block>
            <xsl:apply-templates mode="titlepage.mode"/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>


