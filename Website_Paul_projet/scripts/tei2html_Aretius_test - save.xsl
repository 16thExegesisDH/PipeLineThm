<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Match the root element -->
    <xsl:template match="/">
        <html>
            <head>
                    <!-- Extract the title from short title -->
                    <title><xsl:value-of select="//title[parent::titleStmt]"/></title>
                <link href="../Website_Paul_projet/CSS/Lambertus.css" rel="stylesheet"></link>
                <script src="../Website_Paul_projet/JS/script.js"></script>
            </head>
            <body>
                <div id="mySidebar" class="sidebar">
                    <a href="../Website_Paul_projet/HTML/home.html">Accueil</a>
                    <a href="https://github.com/16thExegesisDH">Construction du projet: Github</a>
                    <a href="https://ihr-num.unige.ch/rrp/">RRP | Reformation Readings of Paul</a>
                </div> 
                
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:text>main</xsl:text>
                    </xsl:attribute>
                    
                    <button class="openbtn" onclick="openNav()">☰ Navigation</button>                      
                    
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>download</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="button">
                            <xsl:attribute name="class">
                                <xsl:text>openbtn</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>../4_Edition_tei.xml</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:text>[↓] XML-TEI</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="button">
                            <xsl:attribute name="class">
                                <xsl:text>openbtn</xsl:text>
                            </xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:text>../PDF/</xsl:text>
                                    <xsl:value-of select="//TEI/@xml:id"/>
                                    <xsl:text>.pdf</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="target">
                                    <xsl:text>_blank</xsl:text>
                                </xsl:attribute>
                                <xsl:text>[↓] PDF</xsl:text>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                    
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>title</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="//title[parent::titleStmt]"/>
                    </xsl:element>
                    
                    
                    <xsl:apply-templates/>
                    
                    <xsl:element name="div">
                        <xsl:attribute name="id">
                            <xsl:text>footer</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="img">
                            <xsl:attribute name="class">
                                <xsl:text>logo</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="src">
                                <xsl:text>../IMG/unige.svg</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    <xsl:template match="title[parent::titleStmt]">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>title</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template> 
    
    <xsl:template match="body">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>document</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='DropCapitalZone'">
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>drop</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>          
                <xsl:element name="table">
                    <xsl:element name="tr">
                        <xsl:element name="td">
                            <xsl:attribute name="class">
                                <xsl:text>para</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:otherwise>
           
        </xsl:choose> 
      
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>p</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="placeName">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>placeName</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="persName">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>persName</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="fw">
        <xsl:choose>
            <xsl:when test="@type='NumberingZone'">
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>fw_number</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>fw_running</xsl:text> 
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='QuireMarksZone'">
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>fw_quire</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>fw</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="choice">
        <xsl:choose>
            <xsl:when test="ancestor::ab[@type='Main*']">
                <xsl:variable name="truc">
                    <xsl:number level="any" count="choice[parent::ab/@type='Main*']" from="body"/>
                </xsl:variable>
                
                <xsl:variable name="absolute_line_number" select="count(ancestor::body/preceding-sibling::choice)"/>
                
                <xsl:value-of select="$truc"/>. <xsl:value-of select="reg"/><xsl:element name="br"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="reg"/><xsl:element name="br"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="pb">
        <xsl:choose>
            <xsl:when test="sourcelink"></xsl:when>
            <xsl:otherwise>
            <xsl:variable name="var2" select="'https://api.digitale-sammlungen.de/iiif/image/v2/'"/>
            <xsl:variable name="IIIF_link2">
                <xsl:value-of select="substring-after(@corresp, 'f')"/>
            </xsl:variable>
            <xsl:variable name="endlink" select="'/full/full/0/default.jpg'"/>
        
        <xsl:element name="hr">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>content-wrapper</xsl:text>
                </xsl:attribute>
<!-- left section with the picture -->
           <xsl:element name="div">
               <xsl:attribute name="class">
                   <xsl:text>image-section</xsl:text>
               </xsl:attribute>
                    <xsl:element name="img">
                        <xsl:attribute name="src">
                            <xsl:value-of select="concat($var2,$IIIF_link2,$endlink)"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="substring-after(@corresp,'f')"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="abbr"/>
    <xsl:template match="expan">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>expan</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
