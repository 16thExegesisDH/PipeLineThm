<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output method="text"/>
    
    <!-- Ignore everything except <ab> and <reg> -->
    <xsl:template match="node()|@*" />
    
    <!-- Process <ab> elements with xml:id -->
    <xsl:template match="/">
        <xsl:for-each select="//ab[@xml:id]">
            <xsl:variable name="current-id" select="@xml:id"/>
            
            <!-- Collect all <reg> in this <ab> and following siblings until the next ab with xml:id -->
            <xsl:variable name="regs">
                <xsl:for-each select="
                    .//reg
                    | following-sibling::node()[
                    not(self::ab[@xml:id])
                    ]//reg
                    ">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </xsl:variable>
            
            <!-- Output only text of <reg> -->
            <xsl:result-document href="{$current-id}.txt" method="text">
                <xsl:value-of select="$regs" separator=" "/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
