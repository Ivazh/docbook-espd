<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСКД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Оформление таблиц -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:d="http://docbook.org/ns/docbook"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        exclude-result-prefixes="d"
        version="1.1">

    <xsl:include href="../common/tables.xsl"/>

    <!-- Таблица дожна иметь номер -->
    <!-- без номера раздела (сквозная нумерация)-->
    <xsl:template match="d:table|d:figure|d:image" mode="label.markup">
        <xsl:variable name="pchap"
                      select="(ancestor::d:appendix[ancestor::d:book])[last()]"/>

        <xsl:variable name="prefix">
            <xsl:if test="count($pchap) &gt; 0">
                <xsl:apply-templates select="$pchap" mode="label.markup"/>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@label">
                <xsl:value-of select="@label"/>
            </xsl:when>
            <xsl:otherwise>
<!--                <xsl:choose>-->
<!--                    <xsl:when test="$prefix != ''">-->
<!--                        <xsl:text>П</xsl:text>-->
<!--                        <xsl:apply-templates select="$pchap" mode="label.markup"/>-->
<!--                        <xsl:apply-templates select="$pchap" mode="intralabel.punctuation">-->
<!--                            <xsl:with-param name="object" select="."/>-->
<!--                        </xsl:apply-templates>-->
<!--                        <xsl:number format="1" from="d:appendix" level="any"/>-->
<!--                    </xsl:when>-->
<!--                    <xsl:otherwise>-->
                        <xsl:number format="1" from="d:book|d:article|d:appendix" level="any"/>
<!--                    </xsl:otherwise>-->
<!--                </xsl:choose>-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:attribute-set name="formal.title.properties" use-attribute-sets="normal.para.spacing">
        <xsl:attribute name="text-align">
            <xsl:choose>
                <xsl:when test="self::d:table">left</xsl:when>
                <xsl:otherwise>center</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- отступ между названием таблицы и самой таблицей -->
    <xsl:attribute-set name="table.table.properties">
        <xsl:attribute name="space-after.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0mm</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0mm</xsl:attribute>
        <!--<xsl:attribute name="margin-top">-6mm</xsl:attribute>-->
        <!--<xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>-->
        <!--<xsl:attribute name="border-collapse">collapse</xsl:attribute>-->

    </xsl:attribute-set>

    <xsl:attribute-set name="table.properties">
        <xsl:attribute name="keep-with-previous.within-page">
            <xsl:choose>
                <xsl:when test="preceding-sibling::*[1][local-name()='figure']">auto</xsl:when>
                <xsl:when test="preceding-sibling::*[1][local-name()='table']">auto</xsl:when>
                <xsl:otherwise>always</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="table.cell.block.properties">
        <xsl:if test="ancestor::d:thead">
            <xsl:attribute name="font-weight">normal</xsl:attribute>
        </xsl:if>
        <xsl:if test="ancestor::d:tbody and self::*[not(@align)]">
            <xsl:attribute name="text-align">left</xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!--<xsl:attribute-set name="table.properties">-->
    <!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->
    <!--</xsl:attribute-set>-->

    <xsl:attribute-set name="table.cell.properties">

    <!--<xsl:attribute name="keep-together">always</xsl:attribute>-->
    </xsl:attribute-set>

    <xsl:template name="table.layout">
        <xsl:param name="table.content"/>

        <fo:table>
            <fo:table-footer>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block border-before-style="solid" border-before-color="black" border-before-width="0.5pt"/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-footer>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell >
                        <fo:block>
                            <xsl:copy-of select="$table.content"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <!-- чтобы таблицу не отрывало от заголовка -->
    <xsl:attribute-set name="table.caption.properties">
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
