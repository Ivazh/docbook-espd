<?xml version="1.0" encoding="UTF-8"?>
<!--
     Стиль для форматирования документов в формате DocBook 5.

     © Лаборатория 50, 2013-2018.

     Распространяется на условиях лицензии GPL 3.

     http://lab50.net
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.1">

    <xsl:import href="../docbook-xsl-ns/fo/docbook.xsl"/>

    <xsl:include href="eskdsp/params.xsl"/>
    <xsl:include href="eskdsp/text.xsl"/>
    <xsl:include href="eskdsp/tables.xsl"/>
    <xsl:include href="eskdsp/titles.xsl"/>
    <xsl:include href="eskdsp/images.xsl"/>
    <xsl:include href="espd/headings.xsl"/>
    <xsl:include href="eskdsp/list.xsl"/>
    <xsl:include href="common/object.xsl"/>
    <xsl:include href="eskdsp/l10n.xsl"/>
    <xsl:include href="common/titlepage.xsl"/>
    <xsl:include href="eskdsp/titlepage.xsl"/>
    <xsl:include href="eskdsp/lu.xsl"/>
    <xsl:include href="eskdsp/admonitions.xsl"/>
    <xsl:include href="common/verbatim.xsl"/>
    <xsl:include href="eskdsp/toc.xsl"/>
    <xsl:include href="eskdsp/lri.xsl"/>
    <xsl:include href="eskdsp/design.xsl"/>

    <!-- Шрифт основного текста -->
    <xsl:param name="body.font.family">Times New Roman</xsl:param>
    <!-- Шрифт без засечек, где-то используется... -->
    <xsl:param name="sans.font.family">Times New Roman</xsl:param>
    <!-- Шрифт заголовков -->
    <xsl:param name="title.font.family">Times New Roman</xsl:param>
    <!-- Шрифт символов (псевдографики) -->
    <xsl:param name="symbol.font.family">OpenSymbol</xsl:param>
    <!-- Шрифт моноширинный (computeroutput, programlisting) -->
    <xsl:param name="monospace.font.family">Courier New</xsl:param>
    <!--<xsl:param name="body.font.master">12</xsl:param>-->

    <xsl:param name="fop1.extensions">1</xsl:param>

</xsl:stylesheet>
