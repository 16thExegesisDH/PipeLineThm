<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <!-- le script découpe chaque unité du texte par verset dans un fichier txt -->
    <!-- il fonctionne ! 20.11.25 -->
    <xsl:output method="text"/>
    
    <!-- Ignore everything by default -->
    <xsl:template match="node()|@*" />
    
    <!-- Group <ab> elements by those starting with xml:id -->
    <xsl:template match="/">
        <xsl:for-each-group select="//ab" group-starting-with="ab[@xml:id]">
            <xsl:variable name="current-id" select="current-group()[1]/@xml:id"/>
            <xsl:result-document href="{$current-id}.txt" method="text">
                <xsl:value-of select="current-group()//reg" separator=" "/>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    
</xsl:stylesheet>

