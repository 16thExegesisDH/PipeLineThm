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
    <!-- 23.06.26 -->
    <!-- architecture du fichier fonctionne, il faut dans l'étape précédente corriger la place de la DropCapital dans un script précédant 
        et régler la question majuscule minuscule pour le mapping des titres ainsi que uniformiser les xml-id -->
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
  <!--  <xsl:template match="hi">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:template match="body">
        
        <xsl:copy>
            
            <!-- preserve body attributes -->
            <xsl:apply-templates select="@*"/>
            
            <!--<div type="book">
                <xsl:attribute name="corresp"
                    select="concat('#', /TEI/@xml:id)"/>-->
                
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
                            
                            <xsl:variable name="chapter-title"
                                select="
                                concat(
                                'Cap. ',
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
                                ' '
                                )
                                )"/>
                            
                            
                            <div type="chapter"
                                xml:id="{$chapter-id}">
                                <div type="chapter-title">
                                    <!-- preserve chapter ab -->
                                    <xsl:apply-templates
                                        select="$chapterHead"/>
                                </div>
                                <div type="chapter-content">
                                    
                               
                               
                                    
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
                                                
                                                <xsl:variable name="verse-title">
                                                    <xsl:value-of select="concat($chapter-title,' v.')"/>
                                                    
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
                                                
                                                <div type="verse" xml:id="{$verse-id}" corresp="#{$chapter-id}">
                                                    
                                                    <!-- verse title--> 
                                                    
                                                    <div type="verse">
                                                        <div type="verse-title">
                                                    <head resp="editor"><xsl:value-of select="$verse-title"/></head>
                                                        </div>
                                                        <div type="verse-content">
                                                    <xsl:apply-templates select="$verseHead"/>
                                                        </div>
                                                    </div>
                                              
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
                                            <div type="introduction-title">
                                            
                                                <xsl:apply-templates
                                                    select="current-group()[1]"/>
                                            
                                            </div>
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
                
            <!--</div>-->
            
        </xsl:copy>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>