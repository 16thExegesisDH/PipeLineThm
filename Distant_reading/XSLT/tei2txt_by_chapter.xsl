<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <!-- le script découpe chaque unité du texte par chapitre dans un fichier txt -->
    <!-- il fonctionne ! 20.02.26 -->
    <xsl:output method="text" />
    
    <!-- ignore everything by default -->
    <xsl:template match="node()|@*" />
    
    <!-- main -->
    <xsl:template match="/">
        <xsl:for-each-group 
            select="//ab"
            group-starting-with="ab[matches(@xml:id, '^C_I{1,4}$|^C_IV$|^C_V$|^C_VI$')]">
            
            <!-- the xml:id of the first item in the group -->
            <xsl:variable name="gid" select="current-group()[1]/@xml:id"/>
            
            <!-- only process valid chapter groups -->
            <xsl:if test="matches($gid, '^C_I{1,4}$|^C_IV$|^C_V$|^C_VI$')">
                <xsl:result-document href="{$gid}.txt" method="text">
                    <!-- get all reg[@type='normalized'] text in the group -->
                    <xsl:for-each select="current-group()//reg[@type='normalized']">
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:result-document>
            </xsl:if>
            
        </xsl:for-each-group>
    </xsl:template>
    
</xsl:stylesheet>