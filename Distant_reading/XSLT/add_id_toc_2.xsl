<?xml version="1.0" encoding="UTF-8"?>    
    <xsl:stylesheet
        version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns="http://www.tei-c.org/ns/1.0"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        exclude-result-prefixes="xs">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <!-- Le scripte donne le bon découpage pour transforme les xmlid en fichier txt à lemmatiser (10.02.26) -->
    <!-- Adapted to the new segmenentation model -->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
  
    <xsl:template match="body">
        
        <xsl:copy>
            
            <!-- preserve body attributes -->
            <xsl:apply-templates select="@*"/>
            
            <div type="book-title">
                <xsl:attribute name="corresp"
                    select="concat('#', /TEI/@xml:id)"/>
                
                <!-- group all body children -->
                <xsl:for-each-group
                    select="node()"
                    group-starting-with="
                    ab[
                    @type='MainZone-Head'
                    and (
                    choice/reg[matches(., '^CAP')]
                    or hi/choice/reg[matches(., '^CAP')]
                    )
                    ]">
                    
                    <xsl:variable name="chapterHead"
                        select="
                        current-group()[1]
                        [self::ab[@type='MainZone-Head']]
                        "/>
                    
                    <xsl:choose>
                        
                        <!-- real chapter -->
                        <xsl:when test="$chapterHead">
                            
                            <xsl:variable name="chapter-id"
                                select="
                                concat(
                                'C_',
                                translate(
                                replace(
                                replace(
                                tokenize(
                                normalize-space(
                                string-join(
                                $chapterHead//reg,
                                ' '
                                )
                                ),
                                '\s+'
                                )[last()],
                                '^CAP\.?',
                                ''
                                ),
                                '\.$',
                                ''
                                ),
                                ' ',
                                '_'
                                )
                                )"/>
                            
                            <div type="chapter-title"
                                xml:id="{$chapter-id}">
                                
                                <!-- preserve chapter ab -->
                                <xsl:apply-templates
                                    select="$chapterHead"/>
                                
                                <div type="chapter-text">
                                    
                                    <!-- everything after chapter -->
                                    <xsl:for-each
                                        select="current-group()[position() gt 1]">
                                        
                                        <xsl:choose>
                                            
                                            <!-- verse head -->
                                            <xsl:when test="
                                                self::ab
                                                and @type='MainZone-Head'
                                                and not(
                                                choice/reg[matches(., '^CAP')]
                                                or hi/choice/reg[matches(., '^CAP')]
                                                )">
                                                
                                                <div>
                                                    <xsl:attribute name="xml:id">
                                                        <xsl:value-of
                                                            select="concat($chapter-id,'_v')"/>
                                                        
                                                        <xsl:number
                                                            level="any"
                                                            count="
                                                            ab[@type='MainZone-Head'
                                                            and not(
                                                            choice/reg[matches(., '^CAP')]
                                                            or hi/choice/reg[matches(., '^CAP')]
                                                            )]"
                                                            from="
                                                            ab[@type='MainZone-Head'
                                                            and (
                                                            choice/reg[matches(., '^CAP')]
                                                            or hi/choice/reg[matches(., '^CAP')]
                                                            )]"/>
                                                    </xsl:attribute>
                                                    
                                                    <xsl:apply-templates select="."/>
                                                    
                                                </div>
                                                
                                            </xsl:when>
                                            
                                            <!-- everything else -->
                                            <xsl:otherwise>
                                                <xsl:apply-templates select="."/>
                                            </xsl:otherwise>
                                            
                                        </xsl:choose>
                                        
                                    </xsl:for-each>
                                    
                                </div>
                            </div>
                            
                        </xsl:when>
                        
                        <!-- content before first chapter -->
                        <xsl:otherwise>
                            <xsl:apply-templates
                                select="current-group()"/>
                        </xsl:otherwise>
                        
                    </xsl:choose>
                    
                </xsl:for-each-group>
                
            </div>
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>