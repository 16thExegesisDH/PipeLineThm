<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:text>\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{microtype}% Pour l'ajustement de la mise en page
\usepackage[pdfusetitle,hidelinks]{hyperref}
\usepackage[english]{french} % Pour les règles typographiques du français
\usepackage[series={},nocritical,noend,noeledsec,nofamiliar,noledgroup]{reledmac}
\usepackage{reledpar} % Package pour l'édition

\usepackage{fontspec} % Package pour mettre Junicode comme police (important pour MUFI)
\setmainfont{Junicode}[
Extension=.ttf,
BoldFont=*-Bold]


\begin{document}

\date{}
        </xsl:text>
        <xsl:text>\title{</xsl:text><xsl:value-of select="//title[parent::titleStmt]"/><xsl:text>}
\maketitle

\begin{pages} 
\beginnumbering
        </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>
\end{pages}
\end{document}
        </xsl:text>
    </xsl:template>  
    
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
        
    <xsl:template match="p">
        <xsl:text>\pstart </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> \pend</xsl:text>
    </xsl:template>
    
    <xsl:template match="reg">
        <xsl:apply-templates/><xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="fw">
        <xsl:choose>
            <xsl:when test="@type='NumberingZone'">
                <xsl:text>\marginpar{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <xsl:text>\marginpar{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Process text sections (ab elements) -->
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='DropCapitalZone'">
                <xsl:text>\textbf{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="choice">
        <xsl:choose>
            <xsl:when test="ancestor::ab[@type='Main*']">
                <xsl:value-of select="reg"/><xsl:text> \\
                </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="reg"/><xsl:text> \\
                </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>