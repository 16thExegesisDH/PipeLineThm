<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output method="text" />
    
    <!-- ignore everything by default -->
    <xsl:template match="node()|@*" />
    
    <!-- main -->
    <xsl:template match="/">
        <xsl:for-each-group 
            select="//ab"
            group-starting-with="ab[starts-with(@xml:id, 'C_')]">
            
            <!-- the xml:id of the first item in the group -->
            <xsl:variable name="gid" select="current-group()[1]/@xml:id"/>
            
            <xsl:result-document href="{$gid}.txt" method="text">
                <xsl:value-of select="current-group()//reg" separator=" " />
            </xsl:result-document>
            
        </xsl:for-each-group>
    </xsl:template>
    
</xsl:stylesheet>
