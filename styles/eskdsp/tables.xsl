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

    <xsl:template name="generate.col">
        <!-- generate the table-column for column countcol -->
        <xsl:param name="countcol">1</xsl:param>
        <xsl:param name="colspecs" select="./d:colspec"/>
        <xsl:param name="count">1</xsl:param>
        <xsl:param name="colnum">1</xsl:param>

        <xsl:choose>
            <xsl:when test="$count>count($colspecs)">
                <fo:table-column column-number="{$countcol}" border-width="0.5mm" border-style="solid">
                    <xsl:variable name="colwidth">
                        <xsl:call-template name="calc.column.width"/>
                    </xsl:variable>
                    <xsl:attribute name="column-width">
                        <xsl:value-of select="$colwidth"/>
                    </xsl:attribute>
                </fo:table-column>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="colspec" select="$colspecs[$count=position()]"/>

                <xsl:variable name="colspec.colnum">
                    <xsl:choose>
                        <xsl:when test="$colspec/@colnum">
                            <xsl:value-of select="$colspec/@colnum"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$colnum"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:variable name="colspec.colwidth">
                    <xsl:choose>
                        <xsl:when test="$colspec/@colwidth">
                            <xsl:value-of select="$colspec/@colwidth"/>
                        </xsl:when>
                        <xsl:otherwise>1*</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="$colspec.colnum=$countcol">
                        <fo:table-column column-number="{$countcol}" border-left-width="0.5mm" border-left-style="solid">
                            <xsl:variable name="colwidth">
                                <xsl:call-template name="calc.column.width">
                                    <xsl:with-param name="colwidth">
                                        <xsl:value-of select="$colspec.colwidth"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:attribute name="column-width">
                                <xsl:value-of select="$colwidth"/>
                            </xsl:attribute>
                        </fo:table-column>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="generate.col">
                            <xsl:with-param name="countcol" select="$countcol"/>
                            <xsl:with-param name="colspecs" select="$colspecs"/>
                            <xsl:with-param name="count" select="$count+1"/>
                            <xsl:with-param name="colnum">
                                <xsl:choose>
                                    <xsl:when test="$colspec/@colnum">
                                        <xsl:value-of select="$colspec/@colnum + 1"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$colnum + 1"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Таблица дожна иметь номер -->
    <!-- без номера раздела (сквозная нумерация)-->
    <xsl:template match="d:table|d:figure" mode="label.markup">
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
                <xsl:choose>
                    <xsl:when test="$prefix != ''">
                        <xsl:text>П</xsl:text>
                        <xsl:apply-templates select="$pchap" mode="label.markup"/>
                        <xsl:apply-templates select="$pchap" mode="intralabel.punctuation">
                            <xsl:with-param name="object" select="."/>
                        </xsl:apply-templates>
                        <xsl:number format="1" from="d:appendix" level="any"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:number format="1" from="d:book|d:article" level="any"/>
                    </xsl:otherwise>
                </xsl:choose>
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

    <xsl:attribute-set name="informal.object.properties">
        <xsl:attribute name="space-before.minimum">0</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0</xsl:attribute>
        <xsl:attribute name="hyphenate">false</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="margin-left">0.3mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="table.cell.block.properties">
        <xsl:if test="ancestor::thead">
            <xsl:attribute name="font-weight">normal</xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- отступ между названием таблицы и самой таблицей -->
    <xsl:attribute-set name="table.table.properties">
        <!--        <xsl:attribute name="margin-top">-6mm</xsl:attribute>-->
    </xsl:attribute-set>

    <!-- продолжение в таблице -->
    <xsl:template name="table.layout">
        <xsl:param name="table.content"/>
        <xsl:choose>
            <xsl:when test="self::d:informaltable">
                <xsl:copy-of select="$table.content"/>
                <!--                <fo:table margin-left="-1.3mm">-->
                <!--                    <fo:table-body>-->
                <!--                        <fo:table-row>-->
                <!--                            <fo:table-cell border="0.2mm solid red">-->
                <!--                                <fo:block margin-top="-17mm">-->
                <!--                                    <xsl:copy-of select="$table.content"/>-->
                <!--                                </fo:block>-->
                <!--                            </fo:table-cell>-->
                <!--                        </fo:table-row>-->
                <!--                    </fo:table-body>-->
                <!--                </fo:table>-->
            </xsl:when>
            <xsl:otherwise>
                <fo:table>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="table.caption.properties">
                                    <fo:retrieve-table-marker
                                            retrieve-class-name="table-title"
                                            retrieve-position-within-table="first-starting"
                                            retrieve-boundary-within-table="table-fragment"/>&#x00A0;
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-footer>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block border-before-style="solid" border-before-color="black"
                                          border-before-width="0.5pt"/>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-footer>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="table.caption.properties">
                                    <fo:marker marker-class-name="table-title"></fo:marker>
                                </fo:block>
                                <fo:block>
                                    <fo:marker marker-class-name="table-title">
                                        <fo:inline font-style="normal">
                                            <xsl:text>П р о д о л ж е н и е&#160;&#160;&#160;т а б л и ц ы&#160;&#160;&#160;</xsl:text>
                                            <xsl:call-template name="substitute-markup">
                                                <xsl:with-param name="allow-anchors" select="0"/>
                                                <xsl:with-param name="template" select="'%n'"/>
                                            </xsl:call-template>
                                        </fo:inline>
                                    </fo:marker>
                                    <xsl:copy-of select="$table.content"/>
                                </fo:block>
                                <fo:block keep-with-previous.within-column="always">
                                    <fo:marker marker-class-name="table-title">
                                        <fo:inline font-style="normal">
                                            <xsl:text>О к о н ч а н и е&#160;&#160;&#160;т а б л и ц ы&#160;&#160;&#160;</xsl:text>
                                            <xsl:call-template name="substitute-markup">
                                                <xsl:with-param name="allow-anchors" select="0"/>
                                                <xsl:with-param name="template" select="'%n'"/>
                                            </xsl:call-template>
                                        </fo:inline>
                                    </fo:marker>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- чтобы таблицу не отрывало от заголовка -->
    <xsl:attribute-set name="table.caption.properties">
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <!-- Заголовок таблицы отделен двойной линией -->
    <xsl:template name="table.row.properties">
        <xsl:choose>
            <xsl:when
                    test="ancestor::d:thead and not (following-sibling::d:row) and not (ancestor::d:thead[@role='notdouble'])">
                <xsl:attribute name="border-after-style">double</xsl:attribute>
                <xsl:attribute name="border-after-width">0.5mm</xsl:attribute>
                <xsl:attribute name="text-align">center</xsl:attribute>
                <xsl:attribute name="display-align">center</xsl:attribute>
                <xsl:attribute name="hyphenate">true</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='double'">
                <xsl:attribute name="border-after-style">double</xsl:attribute>
                <xsl:attribute name="border-after-width">0.5mm</xsl:attribute>
                <xsl:attribute name="text-align">center</xsl:attribute>
                <xsl:attribute name="display-align">center</xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="d:table" mode="xref-to-prefix">
        <xsl:param name="referrer"/>
        <xsl:choose>
            <xsl:when test="$referrer/@name">
                <xsl:value-of select="$referrer/@name"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>таблица</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#160;</xsl:text>
    </xsl:template>


</xsl:stylesheet>
