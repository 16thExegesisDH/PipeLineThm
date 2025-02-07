<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="sourceDoc"/>
    
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    
    <xsl:template match="reg">
        <xsl:apply-templates/><xsl:text> </xsl:text>
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
            <xsl:when test="@type='MainZone-Head' and not(hi/choice/orig[contains(text(), 'CAP')])">
                <xsl:text>
[verset_d]</xsl:text><xsl:apply-templates/><xsl:text>[verset_f]</xsl:text>
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