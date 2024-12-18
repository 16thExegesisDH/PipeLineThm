<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Ceci est un brouillon dans lequel le lien vers chaque block segmenté est récupérable  -->
    
    <!-- Match the root element -->
    <xsl:template match="/">
        <html>
            <head>
                <!-- Extract the title from short title -->
                <title><xsl:value-of select="//title[parent::titleStmt]"/></title>
                <link href="../Website_Paul_projet/CSS/style2.css" rel="stylesheet"></link>
                <script src="../Website_Paul_projet/JS/script.js"></script>
            </head>
    
    
    <!-- Define variables for the parts of URL pour cibler indépendemment chaque block de la page-->
    
    <xsl:otherwise>
        <xsl:variable name="var1" select="'https://api.digitale-sammlungen.de/iiif/image/v2/'"/>
        <xsl:variable name="IIIF_link">
            <xsl:value-of select="substring-after(@corresp, '#f')"/>
        </xsl:variable>
        
        <!-- Conditional check for either '_bl' or '_eS' in the IIIF link -->
        
        <xsl:variable name="IIIF_before_either">
            <xsl:choose> 
                <!-- If '_bl' is found, extract the part before it -->
                <xsl:when test="contains($IIIF_link, '_bl')">
                    <xsl:value-of select="substring-before($IIIF_link, '_bl')"/>
                </xsl:when> 
                <!-- If '_bl' is not found, check for '_eS' -->
                <xsl:when test="contains($IIIF_link, '_eS')">
                    <xsl:value-of select="substring-before($IIIF_link, '_eS')"/>
                </xsl:when> 
                <!-- If neither '_bl' nor '_eS' is found, use the entire string -->
                <xsl:otherwise>
                    <xsl:value-of select="$IIIF_link"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> 
        
        <xsl:variable name="IIIF_zone">
            <xsl:value-of select="substring-after(@corresp,'#')"/>
        </xsl:variable>
        <xsl:variable name="IIIF_zone2">
            <xsl:value-of select="//zone[@xml:id=$IIIF_zone]/@source"/>
        </xsl:variable>    
        
        <xsl:element name="table">
            <xsl:element name="tr">
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>para</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="class">
                        <xsl:text>paraImage</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="img">
                        <xsl:attribute name="src">
                            <xsl:value-of select="concat($var1,$IIIF_before_either,'/', $IIIF_zone2)"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="substring-after(@corresp,'f')"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:otherwise>
</xsl:stylesheet>