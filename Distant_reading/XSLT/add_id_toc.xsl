<?xml version="1.0" encoding="UTF-8"?>    
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <!-- Decoupage du xml tei en vue d'un fichier pour une table des matières de Tei-publisher -->
    <!-- le 09.06.26 -->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="hi">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="body">
        
        <xsl:copy>
            
            <!-- preserve body attributes -->
            <xsl:apply-templates select="@*"/>
            
            <div type="book">
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
                                <h1>
                                <!-- preserve chapter ab -->
                                <xsl:apply-templates
                                    select="$chapterHead"/>
                                </h1>
                                <div type="chapter-text">
                                    
                                    <!-- group content by verse -->
                                    <xsl:for-each-group
                                        select="current-group()[position() gt 1]"
                                        group-starting-with="
                                        ab[
                                        @type='MainZone-Head'
                                        and not(
                                        choice/reg[matches(., '^CAP')]
                                        or hi/choice/reg[matches(., '^CAP')]
                                        )
                                        ]">
                                        
                                        <xsl:variable name="verseHead"
                                            select="
                                            current-group()[1]
                                            [self::ab[@type='MainZone-Head']]
                                            "/>
                                        
                                        <xsl:choose>
                                            
                                            <!-- real verse -->
                                            <xsl:when test="$verseHead">
                                                
                                                <!-- build verse id once -->
                                                
                                                <xsl:variable name="verse-id">
                                                    <xsl:value-of select="concat($chapter-id,'_v')"/>
                                                    
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
                                                </xsl:variable>
                                                
                                                <div type="verse" xml:id="{$verse-id}">
                                                    
                                                    <!-- verse title -->
                                                    <h2>
                                                    <xsl:apply-templates select="$verseHead"/>
                                                    </h2>
                                                    <!-- commentary wrapper -->
                                                    <div type="commentary"
                                                        corresp="#{$verse-id}">
                                                        
                                                        <xsl:apply-templates
                                                            select="current-group()[position() gt 1]"/>
                                                        
                                                    </div>
                                                    
                                                </div>
                                                
                                            </xsl:when>
                                            
                                            <!-- material before first verse -->
                                            <xsl:otherwise>
                                                                                                
                                                <xsl:apply-templates select="current-group()"/>
                                            </xsl:otherwise>
                                            
                                        </xsl:choose>
                                        
                                    </xsl:for-each-group>
                                    
                                </div>
                            </div>
                            
                        </xsl:when>
                        
                        <!-- content before first chapter -->
                        <xsl:otherwise>
                            <div type="book-introduction"
                                xml:id="Introduction">
                                
                                <xsl:for-each-group
                                    select="current-group()"
                                    group-starting-with="ab[@type='MainZone-Head']">
                                    
                                    <xsl:choose>
                                        
                                        <!-- group begins with a title -->
                                        <xsl:when test="current-group()[1][self::ab[@type='MainZone-Head']]">
                                            
                                            <h1>
                                                <xsl:apply-templates
                                                    select="current-group()[1]"/>
                                            </h1>
                                            
                                            <!-- following material -->
                                            <xsl:if test="count(current-group()) gt 1">
                                                <div type="introduction-text">
                                                    <xsl:apply-templates
                                                        select="current-group()[position() gt 1]"/>
                                                </div>
                                            </xsl:if>
                                            
                                        </xsl:when>
                                        
                                        <!-- material before first MainZone-Head -->
                                        <xsl:otherwise>
                                            <div type="introduction-text">
                                                <xsl:apply-templates
                                                    select="current-group()"/>
                                            </div>
                                        </xsl:otherwise>
                                        
                                    </xsl:choose>
                                    
                                </xsl:for-each-group>
                                
                            </div>
                        </xsl:otherwise>
                      <!--  <xsl:otherwise>
                            <div type="book-introduction"
                                xml:id="Introduction">
                                
                                <xsl:apply-templates
                                    select="current-group()"/>
                                
                            </div>
                        
                        </xsl:otherwise>-->
                        
                    </xsl:choose>
                    
                </xsl:for-each-group>
                
            </div>
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>