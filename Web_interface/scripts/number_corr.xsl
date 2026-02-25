<xsl:stylesheet
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:template match="@*|node()"> 
        <xsl:copy> <xsl:apply-templates select="@*|node()"/> </xsl:copy>
    </xsl:template>


        <!-- Identity transform (copies everything by default) -->
    <xsl:template match="fw[@type='NumberingZone']">
        <xsl:variable name="num"
            select="count(preceding::fw[@type='NumberingZone']) + 1"/> <!-- pour l'instant c'est pas ou point reg[1] -->
        
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="lb"/>
            
            <choice>
                <orig>
                    <xsl:value-of select="$num"/>
                </orig>
                <reg type="normalized">
                    <xsl:value-of select="$num"/>
                </reg>
            </choice>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>