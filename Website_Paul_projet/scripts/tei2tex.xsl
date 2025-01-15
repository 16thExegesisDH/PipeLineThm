<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!-- Match the root element -->
    <xsl:template match="/">
        <xsl:text>\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{fontspec}
\setmainfont{Junicode}
\usepackage{reledmac}
\title{</xsl:text>
        <xsl:value-of select="//title[parent::titleStmt]"/>
        <xsl:text>}
\begin{document}
\maketitle
\beginnumbering</xsl:text>
        
        <xsl:apply-templates/>
        
        <xsl:text>\endnumbering
\end{document}</xsl:text>
    </xsl:template>
    
    <!-- Skip teiHeader and sourceDoc -->
    <xsl:template match="teiHeader | sourceDoc"/>
    
    <!-- Title template -->
    <xsl:template match="title[parent::titleStmt]">
        <xsl:text>\section*{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    <!-- Body transformation -->
    <xsl:template match="body">
        <xsl:text>\begin{pages}</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\end{pages}</xsl:text>
    </xsl:template>
    
    <!-- Paragraphs -->
    <xsl:template match="p">
        <xsl:text>\pstart </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> \pend</xsl:text>
    </xsl:template>
    
    
    <!-- Footnotes -->
    <xsl:template match="fw">
        <xsl:choose>
            <xsl:when test="@type='NumberingZone'">
                <xsl:text>
\marginpar{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>
}
                </xsl:text>
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <xsl:text>
\textbf{
                </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>
}
                </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Text Containers for pb tags -->
    <xsl:template match="pb">
        <xsl:text>\section*{Page </xsl:text>
        <xsl:value-of select="substring-after(@corresp, 'fbsb10313792_')"/>
        <xsl:text>}</xsl:text>
        <xsl:apply-templates select="../fw | ../ab"/>
    </xsl:template>
    
    <!-- Process text sections (ab elements) -->
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='DropCapitalZone'">
                <xsl:text>\textbf{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="br">
        <xsl:text>\\</xsl:text> <!-- LaTeX line break -->
    </xsl:template>
    
    <!-- Process choice and keep only reg element content -->
    <xsl:template match="choice">
        <xsl:apply-templates select="reg"/>
    </xsl:template>
    
    <!-- Handle reg -->
    <xsl:template match="reg">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
