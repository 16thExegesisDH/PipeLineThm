<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <!-- Template for the root element 'text' -->
    <xsl:template match="/text">
        \documentclass{article}
        \usepackage{amsmath}
        \begin{document}
        
        <xsl:apply-templates select="body"/>
        
        \end{document}
    </xsl:template>
    
    <!-- Template to match the 'body' element -->
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Template for page break 'pb' elements -->
    <xsl:template match="pb">
        \newpage
    </xsl:template>
    
    <!-- Template for 'fw' elements (handles 'NumberingZone', 'RunningTitleZone', etc.) -->
    <xsl:template match="fw">
        <!-- Process different types of fw elements -->
        <xsl:choose>
            <xsl:when test="@type='NumberingZone'">
                \section*{Page \textbf{<xsl:value-of select="choice/reg"/>}}
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                \textbf{<xsl:value-of select="choice/reg"/>}
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template for 'ab' elements (text blocks) -->
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='MainZone-P'">
                <p><xsl:value-of select="choice/reg"/></p>
            </xsl:when>
            <xsl:when test="@type='MainZone-Head'">
                \section*{<xsl:value-of select="choice/reg"/>}
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template for 'choice' elements -->
    <xsl:template match="choice">
        <xsl:apply-templates select="reg"/>
    </xsl:template>
    
    <!-- Template for 'reg' elements (for rendering text) -->
    <xsl:template match="reg">
        <xsl:value-of select="."/><!-- The 'reg' contains contemporary text -->
    </xsl:template>
    
    <!-- Template for 'lb' elements (line breaks) -->
    <xsl:template match="lb">
        \\
    </xsl:template>
    
</xsl:stylesheet>
