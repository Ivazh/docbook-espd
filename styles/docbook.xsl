<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="1.1">

    <xsl:import href="../docbook-xsl-ns/fo/docbook.xsl"/>

    <xsl:param name="paper.type">A4</xsl:param>
    <xsl:param name="page.margin.inner">20mm</xsl:param>
    <xsl:param name="page.margin.outer">5mm</xsl:param>
    <xsl:param name="page.margin.top">5mm</xsl:param>
    <xsl:param name="page.margin.bottom">5mm</xsl:param>
    <xsl:param name="region.before.extent">10mm</xsl:param>
    <xsl:param name="body.margin.top">15mm</xsl:param>
    <xsl:param name="region.after.extent">5mm</xsl:param>
    <xsl:param name="body.margin.bottom">10mm</xsl:param>
    <xsl:param name="body.font.master">14</xsl:param>
    <xsl:param name="body.font.size">14</xsl:param>
    <xsl:param name="line-height">1.0</xsl:param>


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

    <xsl:param name="generate.toc">
        book
    </xsl:param>

    <xsl:param name="fop1.extensions">1</xsl:param>
</xsl:stylesheet>