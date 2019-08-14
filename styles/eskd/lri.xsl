<?xml version="1.0" encoding="UTF-8"?>
<!--
  Стиль оформления ЕСПД документов в формате DocBook 5.
  © Лаборатория 50, 2013-2018.
  Распространяется на условиях лицензии GPL 3.

  http://lab50.net/
-->

<!-- Лист регистрации изменений. -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:d="http://docbook.org/ns/docbook"
        version="1.1">

    <xsl:attribute-set name="espd.lri.style">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$body.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-size">10.5pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="lripage">
        <fo:block id="END-OF-DOCUMENT" break-before="page"/>
        <fo:block xsl:use-attribute-sets="espd.lri.style" hyphenate="true" hyphenation-character="-">
            <fo:table table-layout="fixed" width="100%" height="100%" border-style="solid" border-width="0.4mm">
                <fo:table-column column-width="12.3mm" border-style="solid"/>
                <fo:table-column column-width="15mm" border-style="solid"/>
                <fo:table-column column-width="14.7mm" border-style="solid"/>
                <fo:table-column column-width="12.5mm" border-style="solid"/>
                <fo:table-column column-width="15mm" border-style="solid"/>
                <fo:table-column column-width="24.8mm" border-style="solid"/>
                <fo:table-column column-width="22.3mm" border-style="solid"/>
                <fo:table-column column-width="26.5mm" border-style="solid"/>
                <fo:table-column column-width="20.9mm" border-style="solid"/>
                <fo:table-column column-width="14.9mm" border-style="solid"/>
                <fo:table-body>
                    <fo:table-row height="9mm" border-style="solid" border-width="0.4mm" text-align="center">
                        <fo:table-cell number-columns-spanned="10" display-align="center">
                            <fo:block>Лист регистрации изменений</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row height="6mm" border-style="solid" border-width="0.4mm" text-align="center">
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Изм.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-columns-spanned="4" display-align="center">
                            <fo:block>Номера листов (страниц)</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Всего лис&#xAD;тов (страниц) в документе</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Номер документа</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Входящий номер сопроводительного документа и дата</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Подпись (фамилия)</fo:block>
                        </fo:table-cell>
                        <fo:table-cell number-rows-spanned="2" display-align="center">
                            <fo:block>Дата</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border-style="solid" border-width="0.4mm" text-align="center">
                        <fo:table-cell display-align="center">
                            <fo:block>изменённых</fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center">
                            <fo:block>заменённых</fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center">
                            <fo:block>новых</fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="center">
                            <fo:block>аннулированных</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                    <xsl:call-template name="lri-empty-row"/>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="lri-empty-row">
        <fo:table-row border-style="solid" height="7.6mm">
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
            <fo:table-cell><fo:block>&#x00A0;</fo:block></fo:table-cell>
        </fo:table-row>
    </xsl:template>

</xsl:stylesheet>
