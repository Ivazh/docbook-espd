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

    <!--<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/fo/docbook.xsl"/>-->
    <xsl:import href="../docbook-xsl-ns/fo/docbook.xsl"/>
    <!-- <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/fo/profile-docbook.xsl"/> -->

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


    <xsl:include href="common/params.xsl"/>
    <xsl:include href="common/text.xsl"/>
    <xsl:include href="espd/tables.xsl"/>
    <xsl:include href="espd/titles.xsl"/>
    <xsl:include href="espd/headings.xsl"/>
    <xsl:include href="espd/list.xsl"/>
    <xsl:include href="common/object.xsl"/>
    <xsl:include href="espd/l10n.xsl"/>
    <xsl:include href="common/titlepage.xsl"/>
    <xsl:include href="espd/titlepage.xsl"/>
    <xsl:include href="espd/lu.xsl"/>
    <xsl:include href="espd/lri.xsl"/>
    <xsl:include href="espd/admonitions.xsl"/>
    <xsl:include href="common/lri.xsl"/>
    <xsl:include href="common/verbatim.xsl"/>
    <xsl:include href="espd/toc.xsl"/>
    <xsl:include href="common/qandaset.xsl"/>
    <xsl:include href="espd/image.xsl"/>

</xsl:stylesheet>
