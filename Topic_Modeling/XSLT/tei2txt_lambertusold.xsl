<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    <!-- dans l'ancien code on doit récupérer le type 'verset' là ou dans le nouveau il faut MainZone-Head -->
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="sourceDoc"/>
    
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    
    <xsl:template match="reg">
        <xsl:apply-templates/><xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="seg">
        <xsl:choose>
            <xsl:when test="@type='verset'">[verset_d]<xsl:apply-templates/>[verset_f]
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- if we do not need the title and pagination -->
    <xsl:template match="fw"/>
    
    <!-- Process text sections (ab elements) the following code structure the txt file by verset-->
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='DropCapitalZone'">
                <xsl:text>
[capital </xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:when test="@type='MainZone-P'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='MainZone-P-Continued'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='MainZone'">
            <xsl:apply-templates select="*|node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/> 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>