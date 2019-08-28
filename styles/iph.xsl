<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Times New Roman,OpenSymbol" font-size="14"
                 text-align="justify" line-height="1.0" font-selection-strategy="character-by-character"
                 line-height-shift-adjustment="disregard-shifts" writing-mode="lr-tb" language="ru">
            <fo:layout-master-set>
                <fo:simple-page-master
                        master-name="page"
                        page-height="297mm"
                        page-width="210mm"
                        margin-top="0mm"
                        margin-bottom="0mm"
                        margin-left="0mm"
                        margin-right="0mm">
                    <!--Макет основной области -->
                    <fo:region-body margin-top="15mm" margin-left="23mm" margin-bottom="15mm" margin-right="8mm"
                    />
                    <!--Макет верхнего колонтитула -->
                    <fo:region-before extent="5mm"/>
                    <!--Макет нижнего колонтитула -->
                    <fo:region-after region-name="xsl-region-after" extent="5mm"/>
                    <fo:region-start extent="20mm"/>
                    <fo:region-end extent="5mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="page" language="ru" format="1" initial-page-number="auto"
                              force-page-count="no-force" hyphenation-character="-" hyphenation-push-character-count="2"
                              hyphenation-remain-character-count="2">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="8pt" text-align="right">Сформировано с помощью cbs</fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" hyphenate="false" font-size="11pt" line-height="1.1em">
                    <fo:block text-align="center" font-size="14pt" font-weight="700">
                        ИНФОРМАЦИОННО-ПОИСКОВАЯ ХАРАКТЕРИСТИКА
                    </fo:block>
                    <fo:block margin-top="10mm">Обозначение: <fo:inline font-weight="700"><xsl:value-of select="/iph/number"/></fo:inline></fo:block>
                    <fo:block>Наименование: <fo:inline><xsl:value-of select="/iph/name"/></fo:inline></fo:block>
                    <fo:block margin-top="1em">Первичное применение _____________________________</fo:block>
                    <fo:block>Аннотация _____________________________</fo:block>
                    <fo:block>Литера _____________________________</fo:block>
                    <fo:block><fo:inline padding-right="20mm">Вид диска</fo:inline> Подлинник, копия</fo:block>
                    <fo:block>Изменение _____________________________</fo:block>
                    <fo:block>№ извещения ____________________________</fo:block>
                    <fo:block>Инв. №: ____________________________</fo:block>
                    <fo:block>Контрольная сумма:  <fo:inline padding-left="10mm"><xsl:value-of select="/iph/checksum"/></fo:inline></fo:block>

                    <fo:table border="solid 0.2mm" margin-top="1em" margin-bottom="3mm" font-size="11pt">
                        <fo:table-column column-width="89mm" border="solid 0.2mm"/>
                        <fo:table-column column-width="25mm" border="solid 0.2mm"/>
                        <fo:table-column column-width="25mm" border="solid 0.2mm"/>
                        <fo:table-column column-width="20mm" border="solid 0.2mm"/>
                        <fo:table-column column-width="20mm" border="solid 0.2mm"/>
                        <fo:table-header display-align="center" text-align="center">
                            <fo:table-row border="solid 0.2mm">
                                <fo:table-cell number-columns-spanned="3"><fo:block>Образец-эталон (дубликат)</fo:block></fo:table-cell>
                                <fo:table-cell number-columns-spanned="2"><fo:block>Копии на твердом носителе</fo:block></fo:table-cell>
                            </fo:table-row>
                            <fo:table-row border="solid 0.2mm">
                                <fo:table-cell><fo:block>Имя файла/каталога</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Объем, байт</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Дата</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Формат</fo:block></fo:table-cell>
                                <fo:table-cell><fo:block>Листов</fo:block></fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <xsl:if test="count(/iph/content/element)>0">
                        <fo:table-body>
                            <xsl:for-each select="/iph/content/element">
                                <fo:table-row border="solid 0.2mm">
                                    <fo:table-cell padding="1mm 2mm"><fo:block><xsl:value-of select="./name"/></fo:block></fo:table-cell>
                                    <fo:table-cell text-align="center" padding="1mm 2mm"><fo:block><xsl:value-of select="./size"/></fo:block></fo:table-cell>
                                    <fo:table-cell text-align="center" padding="1mm 2mm"><fo:block><xsl:value-of select="./date"/></fo:block></fo:table-cell>
                                    <fo:table-cell text-align="center" padding="1mm 2mm"><fo:block><xsl:value-of select="./format"/></fo:block></fo:table-cell>
                                    <fo:table-cell text-align="center" padding="1mm 2mm"><fo:block><xsl:value-of select="./sheets"/></fo:block></fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                        </xsl:if>
                    </fo:table>
                    <fo:block><fo:inline padding-right="10mm">Защита ЛД:</fo:inline> Только чтение</fo:block>
                    <fo:block margin-top="10mm">
                        <xsl:for-each select="/iph/signatures/signature">
                            <fo:block margin-bottom="1em">
                                <fo:inline-container width="50mm">
                                    <fo:block width="50mm"><xsl:value-of select="./position"/></fo:block>
                                </fo:inline-container>
                                <fo:inline>___________________</fo:inline>

                                <fo:inline padding-left="5mm">/<xsl:call-template name="person.name"/>/</fo:inline>
                            </fo:block>
                        </xsl:for-each>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="person.name">
        <xsl:param name="node" select="."/>

        <xsl:choose>
            <xsl:when test="$node/personname">
                <xsl:call-template name="person.name" mode="initials">
                    <xsl:with-param name="node" select="$node/personname"/>
                </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
                <xsl:if test="$node//firstname">
                    <xsl:apply-templates select="$node//firstname[1]"/>
                    <xsl:text> </xsl:text>
                </xsl:if>

                <xsl:if test="$node//othername">
                    <xsl:apply-templates select="$node//othername[1]"/>
                    <xsl:text> </xsl:text>
                </xsl:if>

                <xsl:apply-templates select="$node//surname[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="firstname|othername">
        <xsl:value-of select="substring(string(.), 1, 1)"/>
        <xsl:text>.</xsl:text>
    </xsl:template>

</xsl:stylesheet>
