<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <!-- Le scripte donne le bon découpage pour transforme les xmlid en fichier txt à lemmatiser (10.02.26) -->
    <!-- Adapted to the new segmenentation model -->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="text-section"/>
        
    </xsl:template>
    
        
    
    <!-- here the script change for e-rara identifier for fw/ab/and img scr -->
    <xsl:template name="text-section">
        <div content="complet-text" id="{/TEI/@*[namespace-uri()='http://www.w3.org/XML/1998/namespace' and local-name()='id']}">
            <xsl:for-each select="/TEI/text/body/pb">
                <!-- Extract the relevant digit sequence from pb/@corresp -->
                <xsl:variable name="pbID" select="substring-after(@corresp, 'f')"/>
                <div content="content-page">
                    <xsl:attribute name="id">
                        <xsl:value-of select="substring-after(@corresp,'f')"/>
                    </xsl:attribute>
                    <div content="text-fw" id="{concat('#', substring-after(@corresp, 'f'))}">
                            <xsl:apply-templates select="../fw[starts-with(@corresp, concat('#f', $pbID))]"/>
                      </div>
                    <div content="text-ab" id="{concat('#', substring-after(@corresp, 'f'))}">
                            <xsl:apply-templates select="../ab[starts-with(@corresp, concat('#f', $pbID))]"/>
                      </div>
                    <!--      </div> div tex-contenaire -->
                    <div content="text-note" id="{concat('#', substring-after(@corresp, 'f'))}">
<!--                        <section class="note" id="{concat('#', substring-after(@corresp, 'f'))}">--> 
                            <xsl:apply-templates select="../note[starts-with(@corresp, concat('#f', $pbID))]"/>
                 
                    </div> <!-- div text-container -->
                    <!-- Generate the image section after the text-container -->
                   </div><!-- </div> div content-wrapper-->
            </xsl:for-each>
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>