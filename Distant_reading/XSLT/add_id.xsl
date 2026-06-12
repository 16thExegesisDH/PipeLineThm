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
    
    <!-- Copy DropCapitalZone unchanged -->
    <xsl:template match="ab[@type='DropCapitalZone']">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- Copy DropCapitalZone unchanged -->
    <xsl:template match="ab[@type='MainZone-P']">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- Copy DropCapitalZone unchanged -->
    <xsl:template match="ab[@type='MainZone-P-Continued']">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="ab">
        <!-- Skip DropCapitalZone & MainZone-P -->
        <xsl:if test="@type != 'DropCapitalZone' and @type != 'MainZone-P'">
            <xsl:copy>
                <!-- Copy attributes -->
                <xsl:apply-templates select="@*"/>
                
                <xsl:choose>
                    <!-- CASE 1: MainZone-Head chapter with CAP--> 
                    <xsl:when test="@type='MainZone-Head'
                        and (choice/reg[matches(., '^CAP')]
                        or hi/choice/reg[matches(., '^CAP')])">
                        
                        <!-- Build xml:id as 'C_' + last token of all <reg> text, with trailing dot removed and spaces replaced by underscores -->
                        <!--<xsl:attribute name="xml:id"
                            select="
                            concat(
                            'C_',
                            translate(
                            replace(
                            tokenize(
                            normalize-space(string-join(.//reg, ' ')),
                            '\s+'
                            )[last()],
                            '\.$',
                            ''
                            ),
                            ' ',
                            '_'
                            )
                            )"/>-->
                        
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="
                                concat(
                                'C_',
                                translate(
                                replace(
                                replace(
                                tokenize(
                                normalize-space(string-join(.//reg, ' ')),
                                '\s+'
                                )[last()],
                                '^CAP\.?', ''          (: remove leading CAP. if present :)
                                ),
                                '\.$', ''                (: remove trailing dot if present :)
                                ),
                                ' ',
                                '_'
                                )
                                )
                                "/>
                        </xsl:attribute>
                        
                        
                        
                    </xsl:when>
                   
                    
            
                    
                    <!-- CASE 2: MainZone-Head without CAP -->
                    <xsl:when test="@type='MainZone-Head'
                        and not(choice/reg[matches(., '^CAP')])
                        and not(hi/choice/reg[matches(., '^CAP')])">
                        
                        <!-- Get nearest preceding CAP chapter xml:id -->
                        <xsl:variable name="chapter-id" 
                            select="preceding-sibling::ab[@type='MainZone-Head' 
                            and (choice/reg[matches(., '^CAP.*')] 
                            or hi/choice/reg[matches(., '^CAP.*')])][1]
                            /
                            concat(
                            'C_',
                            translate(
                            replace(
                            replace(
                            tokenize(
                            normalize-space(string-join(.//reg, ' ')),
                            '\s+'
                            )[last()],
                            '^CAP\.?', ''          (: remove leading CAP. if present :)
                            ),
                            '\.$', ''                (: remove trailing dot if present :)
                            ),
                            ' ',
                            '_'
                            )
                            )
                            "/>
                        
                        <xsl:attribute name="xml:id">
                            <!-- prepend chapter-id + v -->
                            <xsl:value-of select="concat($chapter-id, '_v')"/>
                            <!-- numbering within the chapter -->
                            <xsl:number 
                                level="any"
                                count="ab[@type='MainZone-Head' 
                                and not(choice/reg[matches(., '^CAP')])
                                and not(hi/choice/reg[matches(., '^CAP')])]"
                                from="ab[@type='MainZone-Head' 
                                and (choice/reg[matches(., '^CAP.*')] 
                                or hi/choice/reg[matches(., '^CAP.*')])]"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="ab[@type='DropCapitalZone']"> 
                        <xsl:apply-templates/>
                    </xsl:when>
                </xsl:choose>
                
                <!-- Copy children -->
                <xsl:apply-templates select="node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    
    
    
    
    
</xsl:stylesheet>