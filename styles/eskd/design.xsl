<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:d="http://docbook.org/ns/docbook">

    <xsl:template match="/">
        <xsl:variable name="document.element" select="*[1]"/>
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="root.properties">
            <xsl:attribute name="language">
                <xsl:call-template name="l10n.language">
                    <xsl:with-param name="target" select="/*[1]"/>
                </xsl:call-template>
            </xsl:attribute>
            <!-- Определение макета страницы, в том числе полей -->
            <fo:layout-master-set>
                <fo:simple-page-master
                        master-name="title-page"
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
                    <fo:region-after extent="5mm"/>
                    <fo:region-start extent="20mm"/>
                    <fo:region-end extent="5mm"/>
                </fo:simple-page-master>
                <!-- Размер страницы и полей -->
                <fo:simple-page-master
                        master-name="eskd-first"
                        page-height="297mm"
                        page-width="210mm"
                        margin-top="0mm"
                        margin-bottom="0mm"
                        margin-left="0mm"
                        margin-right="0mm">
                    <!--Макет основной области -->
                    <fo:region-body margin-top="15mm" margin-left="23mm" margin-bottom="55mm" margin-right="8mm"
                    />
                    <!--Макет верхнего колонтитула -->
                    <fo:region-before extent="5mm"/>
                    <!--Макет нижнего колонтитула -->
                    <fo:region-after extent="45mm"/>
                    <fo:region-start extent="20mm"/>
                    <fo:region-end extent="5mm"/>
                </fo:simple-page-master>
                <fo:simple-page-master
                        master-name="eskd-other"
                        page-height="297mm"
                        page-width="210mm"
                        margin-top="0mm"
                        margin-bottom="0mm"
                        margin-left="0mm"
                        margin-right="0mm">
                    <!--Макет основной области -->
                    <fo:region-body margin-top="15mm" margin-left="23mm" margin-bottom="30mm" margin-right="8mm"
                    />
                    <!--Макет верхнего колонтитула -->
                    <fo:region-before extent="5mm"/>
                    <!--Макет нижнего колонтитула -->
                    <fo:region-after extent="20mm"/>
                    <fo:region-start extent="20mm"/>
                    <fo:region-end extent="5mm"/>
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="eskd">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="eskd-first"
                                                              page-position="first"/>
                        <fo:conditional-page-master-reference master-reference="eskd-other"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <xsl:if test="$fop1.extensions != 0">
                <xsl:call-template name="fop1-document-information"/>
                <xsl:apply-templates select="$document.element" mode="fop1.foxdest"/>
            </xsl:if>
            <xsl:call-template name="generate.bookmarks"/>

            <xsl:apply-templates/>
        </fo:root>
    </xsl:template>

    <xsl:template match="d:book">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>
        <xsl:variable name="preamble"
                      select="d:title|d:subtitle|d:titleabbrev|d:bookinfo|d:info"/>

        <xsl:variable name="content"
                      select="node()[not(self::d:title or self::d:subtitle
                            or self::d:titleabbrev
                            or self::d:info
                            or self::d:bookinfo)]"/>

        <xsl:if test="$preamble">
            <fo:page-sequence master-reference="title-page" force-page-count="no-force">
                <fo:static-content flow-name="xsl-region-start">
                    <!-- Добавление номера страницы к нижнему колонтитулу -->
                    <fo:block-container height="287mm" margin-bottom="5mm" margin-top="5mm" border-right="solid 0.5mm">
                        <fo:block/>
                    </fo:block-container>
                    <fo:block-container reference-orientation="90" absolute-position="fixed" bottom="5mm" left="8mm">
                        <fo:block font-size="11pt" font-family="Times New Roman" text-align="center">
                            <fo:table table-layout="fixed" width="145mm" height="18mm" border-style="solid"
                                      border-width="0.5mm">
                                <!--  border-style="solid" border-width="0.5mm" -->
                                <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="35mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="35mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-body>
                                    <fo:table-row height="4.5mm" border-style="solid" border-width="0.5mm">
                                        <fo:table-cell>
                                            <fo:block margin-left="0.6mm">Инв. № подл.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block margin-left="0.6mm">Подпись и дата</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block margin-left="0.6mm">Взам. инв. №</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block margin-left="0.6mm">Инв. № дубл.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Подпись и дата</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row height="6.8mm" border-style="solid" border-width="0.5mm">
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block>
                    </fo:block-container>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-before">
                    <!-- Вывод адреса компании в верхнем колонтитуле -->
                    <fo:block border-after-style="solid" margin-top="4.5mm" border-bottom="solid 0.5mm"/>
                </fo:static-content>
                <!-- Создание нижнего колонтитула -->
                <fo:static-content flow-name="xsl-region-after">
                    <!-- Добавление номера страницы к нижнему колонтитулу -->
                    <fo:block border-top-style="solid" margin-top="-0.25mm" border-top="solid 0.5mm"/>
                    <fo:block-container position="fixed" top="293mm" left="110mm">
                        <fo:block  font-size="9pt">
                            <fo:inline padding-right="4cm">Копировал</fo:inline>
                            <fo:inline>Формат А4</fo:inline>
                        </fo:block>
                    </fo:block-container>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-end">
                    <!-- Добавление номера страницы к нижнему колонтитулу -->
                    <fo:block-container height="287mm" margin-bottom="5mm" margin-top="5mm" border-left="solid 0.5mm">
                        <fo:block/>
                    </fo:block-container>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block id="{$id}">
                        <xsl:call-template name="book.titlepage"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
        <fo:page-sequence master-reference="eskd" initial-page-number="2">
            <!-- Создание верхнего колонтитула -->
            <fo:static-content flow-name="xsl-region-before">
                <!-- Вывод адреса компании в верхнем колонтитуле -->
                <fo:block border-after-style="solid" margin-top="4.5mm" border-bottom="solid 0.5mm"/>
            </fo:static-content>
            <!-- Создание нижнего колонтитула -->
            <fo:static-content flow-name="xsl-region-after">
                <!-- Добавление номера страницы к нижнему колонтитулу -->
                <fo:retrieve-marker retrieve-class-name="bottom" retrieve-position="first-starting-within-page"/>
            </fo:static-content>
            <fo:static-content flow-name="xsl-region-end">
                <!-- Добавление номера страницы к нижнему колонтитулу -->
                <fo:block-container height="287mm" margin-bottom="5mm" margin-top="5mm" border-left="solid 0.5mm">
                    <fo:block/>
                </fo:block-container>
            </fo:static-content>
            <fo:static-content flow-name="xsl-region-start">
                <!-- Добавление номера страницы к нижнему колонтитулу -->
                <fo:block-container height="287mm" margin-bottom="5mm" margin-top="5mm" border-right="solid 0.5mm">
                    <fo:block/>
                </fo:block-container>
                <fo:block-container reference-orientation="90" absolute-position="fixed" bottom="5mm" left="8mm">
                    <fo:block font-size="11pt" font-family="Times New Roman" text-align="center">
                        <fo:table table-layout="fixed" width="145mm" height="18mm" border-style="solid"
                                  border-width="0.5mm">
                            <!--  border-style="solid" border-width="0.5mm" -->
                            <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                            <fo:table-column column-width="35mm" border-style="solid" border-width="0.5mm"/>
                            <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                            <fo:table-column column-width="25mm" border-style="solid" border-width="0.5mm"/>
                            <fo:table-column column-width="35mm" border-style="solid" border-width="0.5mm"/>
                            <fo:table-body>
                                <fo:table-row height="4.5mm" border-style="solid" border-width="0.5mm">
                                    <fo:table-cell>
                                        <fo:block margin-left="0.6mm">Инв. № подл.</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block margin-left="0.6mm">Подпись и дата</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block margin-left="0.6mm">Взам. инв. №</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block margin-left="0.6mm">Инв. № дубл.</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>Подпись и дата</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row height="6.8mm" border-style="solid" border-width="0.5mm">
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                </fo:block-container>
                <fo:retrieve-marker retrieve-class-name="left" retrieve-position="first-starting-within-page"/>
            </fo:static-content>

            <!-- Вывод основного содержимого документа -->
            <fo:flow flow-name="xsl-region-body" font-family="Times New Roman">
                <xsl:call-template name="set.flow.properties">
                    <xsl:with-param name="element" select="local-name(.)"/>
                    <xsl:with-param name="master-reference" select="'eskd'"/>
                </xsl:call-template>
                <fo:block>
                    <fo:marker marker-class-name="bottom">
                        <fo:block font-size="11pt" font-family="Times New Roman" text-align="center">
                            <fo:table table-layout="fixed" height="40mm" border-style="solid" border-width="0.5mm"
                                      display-align="center" font-size="9pt" margin-left="-0.1mm">
                                <fo:table-column column-width="6.5mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="10mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="23mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="15mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="10mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="70mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="5mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="5mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="5mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="17mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="17.8mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-body>
                                    <fo:table-row border-style="solid" border-width="0.2mm" height="4.5mm">
                                        <fo:table-cell border-bottom-width="0.3mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.3mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.3mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.3mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.3mm">
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell number-columns-spanned="6" number-rows-spanned="3">
                                            <fo:block font-size="16pt">
                                                <xsl:value-of select="/d:book/d:info/d:decimal"/>
                                                <xsl:value-of select="/d:book/d:info/d:docnumber"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.2mm" height="4.5mm">
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell>
                                            <fo:block>Изм.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Лист</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>№ докум.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Подп.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Дата</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell number-columns-spanned="2" text-align="left">
                                            <fo:block>Разраб.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="left">
                                                <xsl:call-template name="person.surname">
                                                    <xsl:with-param name="position">Исполнитель</xsl:with-param>
                                                </xsl:call-template>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell number-rows-spanned="5" display-align="center">
                                            <fo:block font-size="14pt" vertical-align="middle">
                                                <xsl:choose>
                                                    <xsl:when test="/d:book/d:info/d:shorttitle">
                                                        <xsl:value-of select="/d:book/d:info/d:shorttitle"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="/d:book/d:info/d:title"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>

                                            </fo:block>
                                            <fo:block font-size="10pt" margin-top="2mm">
                                                <xsl:value-of select="/d:book/d:info/d:subtitle"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell number-columns-spanned="3">
                                            <fo:block>Лит.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Лист</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Листов</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell number-columns-spanned="2" text-align="left">
                                            <fo:block>Пров.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="left">
                                                <xsl:call-template name="person.surname">
                                                    <xsl:with-param name="position">Руководитель разработки</xsl:with-param>
                                                </xsl:call-template>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:page-number/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <fo:page-number-citation ref-id="END-OF-DOCUMENT"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell number-columns-spanned="2">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell number-rows-spanned="3" number-columns-spanned="5">
                                            <fo:block/>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell number-columns-spanned="2" text-align="left">
                                            <fo:block>Н. контр.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="left">
                                                <xsl:call-template name="person.author"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.8mm">
                                        <fo:table-cell number-columns-spanned="2" text-align="left">
                                            <fo:block>Утв.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="center">&#x2014;</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block>
                        <fo:block-container position="fixed" top="293mm" left="110mm">
                            <fo:block  font-size="9pt">
                                <fo:inline padding-right="4cm">Копировал</fo:inline>
                                <fo:inline>Формат А4</fo:inline>
                            </fo:block>
                        </fo:block-container>
                    </fo:marker>
                </fo:block>
                <fo:block>
                    <fo:marker marker-class-name="bottom">
                        <fo:block font-size="11pt" font-family="Times New Roman" text-align="center">
                            <fo:table table-layout="fixed" margin-left="-0.1mm" width="175mm" font-size="9pt"
                                      height="15mm" border-style="solid" display-align="center"
                                      border-width="0.5mm">
                                <fo:table-column column-width="6.5mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="10mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="23mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="15mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="10mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="110mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-column column-width="9.8mm" border-style="solid" border-width="0.5mm"/>
                                <fo:table-body>
                                    <fo:table-row border-style="solid" border-width="0.2mm" height="4.5mm">
                                        <fo:table-cell border-bottom-width="0.2mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.2mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.2mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.2mm">
                                            <fo:block/>
                                        </fo:table-cell>
                                        <fo:table-cell border-bottom-width="0.2mm">
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell number-rows-spanned="3">
                                            <fo:block font-size="16pt">
                                                <xsl:value-of select="/d:book/d:info/d:decimal"/>
                                                <xsl:value-of select="/d:book/d:info/d:docnumber"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell number-rows-spanned="3" height="14.5mm" padding="0">
                                            <fo:table margin-left="-0.5mm" padding="0" width="8mm"
                                                      display-align="center" text-align="center">
                                                <fo:table-column column-width="9.8mm"/>
                                                <fo:table-body>
                                                    <fo:table-row>
                                                        <fo:table-cell height="6.5mm" padding="0"
                                                                       border-bottom="solid 0.5mm">
                                                            <fo:block>Лист</fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>
                                                    <fo:table-row height="7.5mm">
                                                        <fo:table-cell>
                                                            <fo:block font-size="16pt">
                                                                <fo:page-number/>
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </fo:table-row>

                                                </fo:table-body>
                                            </fo:table>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.2mm" height="4.5mm">
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block></fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row border-style="solid" border-width="0.5mm" height="4.5mm">
                                        <fo:table-cell>
                                            <fo:block>Изм.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Лист</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>№ докум.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Подп.</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>Дата</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block>
                        <fo:block-container position="fixed" top="293mm" left="110mm">
                            <fo:block  font-size="9pt">
                                <fo:inline padding-right="3cm">Копировал</fo:inline>
                                <fo:inline>Формат А4</fo:inline>
                            </fo:block>
                        </fo:block-container>

                    </fo:marker>
                </fo:block>
                <fo:block>
                    <fo:marker marker-class-name="left">
                        <fo:block-container reference-orientation="90" absolute-position="fixed" bottom="172.3mm"
                                            left="8mm">
                            <fo:block font-size="11pt" font-family="Times New Roman" text-align="center">
                                <fo:table table-layout="fixed" width="120mm" height="18mm" border-style="solid"
                                          border-width="0.5mm">
                                    <!--  border-style="solid" border-width="0.5mm" -->
                                    <fo:table-column column-width="60mm" border-style="solid" border-width="0.5mm"/>
                                    <fo:table-column column-width="60mm" border-style="solid" border-width="0.5mm"/>
                                    <fo:table-body>
                                        <fo:table-row height="4.5mm" border-style="solid" border-width="0.5mm">
                                            <fo:table-cell>
                                                <fo:block margin-left="0.6mm">Справ. №</fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block margin-left="0.6mm">Перв. примен.</fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row height="6.8mm" border-style="solid" border-width="0.5mm">
                                            <fo:table-cell>
                                                <fo:block/>
                                            </fo:table-cell>
                                            <fo:table-cell display-align="center">
                                                <fo:block>
                                                    <xsl:value-of select="/d:book/d:info/d:decimal"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>
                            </fo:block>
                        </fo:block-container>
                    </fo:marker>
                </fo:block>
                <fo:block>
                    <fo:marker marker-class-name="left"/>
                </fo:block>
<!--                -->
<!--                <xsl:apply-templates select="d:acknowledgements" mode="acknowledgements"/>-->

                <xsl:call-template name="make.book.tocs"/>
                <xsl:apply-templates select="d:dedication" mode="dedication"/>

                <xsl:apply-templates select="$content"/>

                <xsl:call-template name="back.cover"/>

                <xsl:call-template name="lripage"/>
            </fo:flow>
        </fo:page-sequence>


        <xsl:if test="/d:book/d:info/d:dsp">
            <fo:page-sequence master-reference="eskd">
                <xsl:call-template name="dsp"/>
            </fo:page-sequence>
        </xsl:if>
        <xsl:if test="/d:book/d:info/d:s">
            <fo:page-sequence master-reference="eskd">
                <xsl:call-template name="s"/>
            </fo:page-sequence>
        </xsl:if>

    </xsl:template>

    <xsl:template match="d:chapter">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="master-reference">
            <xsl:call-template name="select.pagemaster"/>
        </xsl:variable>

        <fo:block id="{$id}" break-before="page"
                  xsl:use-attribute-sets="component.titlepage.properties">
            <xsl:call-template name="chapter.titlepage"/>
        </fo:block>

        <xsl:call-template name="make.component.tocs"/>

        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:dedication" mode="dedication">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="master-reference">
            <xsl:call-template name="select.pagemaster"/>
        </xsl:variable>

        <fo:block id="{$id}" break-before="page"
                  xsl:use-attribute-sets="component.titlepage.properties">
            <xsl:call-template name="dedication.titlepage"/>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:preface">
        <xsl:variable name="id">
            <xsl:call-template name="object.id"/>
        </xsl:variable>

        <xsl:variable name="master-reference">
            <xsl:call-template name="select.pagemaster"/>
        </xsl:variable>

        <fo:block id="{$id}" break-before="page"
                  xsl:use-attribute-sets="component.titlepage.properties">
            <xsl:call-template name="preface.titlepage"/>
        </fo:block>

        <xsl:call-template name="make.component.tocs"/>

        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*" mode="page.sequence" name="page.sequence">
        <xsl:param name="content">
            <xsl:apply-templates/>
        </xsl:param>
        <xsl:param name="master-reference">
            <xsl:call-template name="select.pagemaster"/>
        </xsl:param>
        <xsl:param name="element" select="local-name(.)"/>
        <xsl:param name="gentext-key" select="local-name(.)"/>
        <xsl:param name="language">
            <xsl:call-template name="l10n.language"/>
        </xsl:param>

        <xsl:choose>
            <xsl:when test="string-length($content) != 0">
                <xsl:if test="$element != 'toc'">
                    <fo:block break-before="page"/>
                </xsl:if>
                <xsl:copy-of select="$content"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>
                    <xsl:text>WARNING: call to template 'page.sequence' </xsl:text>
                    <xsl:text>has zero length content; no page-sequence generated.</xsl:text>
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:attribute-set name="espd.titlepage.style">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$body.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="hyphenate">false</xsl:attribute>
    </xsl:attribute-set>

    <!-- Инициалы в формате «И. О. Фамилия»-->
    <xsl:template name="person.name" mode="initials">
        <xsl:param name="node" select="."/>

        <xsl:choose>
            <xsl:when test="$node/d:personname">
                <xsl:call-template name="person.name" mode="initials">
                    <xsl:with-param name="node" select="$node/d:personname"/>
                </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
                <xsl:if test="$node//d:firstname">
                    <xsl:apply-templates select="$node//d:firstname[1]" mode="initials"/>
                    <xsl:text> </xsl:text>
                </xsl:if>

                <xsl:if test="$node//d:othername">
                    <xsl:apply-templates select="$node//d:othername[1]" mode="initials"/>
                    <xsl:text> </xsl:text>
                </xsl:if>

                <xsl:apply-templates select="$node//d:surname[1]" mode="initials"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="person.surname">
        <xsl:param name="position"/>
        <xsl:for-each select="/d:book/d:info//d:othercredit">
            <xsl:if test="$position=./d:personblurb/d:para/text()">
                <xsl:value-of select=".//d:surname"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="person.editor">
        <xsl:value-of select="/d:book/d:info//d:editor//d:surname"/>
    </xsl:template>
    <xsl:template name="person.author">
        <xsl:value-of select="/d:book/d:info//d:author//d:surname"/>
    </xsl:template>

    <xsl:template match="d:firstname|d:othername" mode="initials">
        <xsl:value-of select="substring(string(.), 1, 1)"/>
        <xsl:text>.</xsl:text>
    </xsl:template>

</xsl:stylesheet>
