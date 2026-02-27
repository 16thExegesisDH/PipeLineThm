<xsl:stylesheet
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    
   <!-- version 1 du code, il fonctionne pourrait être automatié d'avanatage, puis insérerd dans le pipeline d'Edition, mais à voir
    * ajouter  après la fonction count () + [le numéro de la premire page] le document commencera a décompter les pages à partir de là -->
    <xsl:template match="@*|node()"> 
        <xsl:copy> <xsl:apply-templates select="@*|node()"/> </xsl:copy>
    </xsl:template>


        <!-- Identity transform (copies everything by default) --> 
    <xsl:template match="fw[@type='NumberingZone']">
        <!-- mettre à jour le numéro de page en fonction du document : ici la pagination commence à la page 2, donc + 2 (count commence par défaut de 0) -->
        <xsl:variable name="num"
            select="count(preceding::fw[@type='NumberingZone']) + 1"/>  
        
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