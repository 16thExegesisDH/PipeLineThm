<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <!-- script terminé le 30.04.2025 fonction à 100% pour mdz file -->
    <!-- STRIP all unnecessary spaces in input XML -->
    <xsl:strip-space elements="*"/>
    <!-- Output clean HTML without useless indentations -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <!-- script for MDZ -->
    <!-- Match the root element -->
    <xsl:template match="/">
        <!-- setup for the webpage and metadata -->
        <!-- NOTA BENE : le script concerne seulement les données de Lambert qui est un vieux document, il faut faire quelque changement manuel dans la table des matières -->
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<!-- Extract the title from short title -->
                <title>
                    <xsl:value-of select="//title[parent::titleStmt]"/>
                </title>
                <link href="../../../Web_interface/CSS/updated_3_toc.css" rel="stylesheet"/>
                <script src="../../../Web_interface/JS/script_toc.js" defer="defer"></script>
            </head>
            <body>
                
                <xsl:call-template name="generate-sidebar"/>
                
<!-- setup for the main div containing the bottum -->
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
                                    <xsl:text>../../TEI/</xsl:text>
                                    <xsl:value-of select="//TEI/@xml:id"/>
                                    <xsl:text>_tei_NF.zip</xsl:text>
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
                                    <xsl:text>../../PDF/</xsl:text>
                                    <xsl:value-of select="//TEI/@xml:id"/>
                                    <xsl:text>_update.pdf</xsl:text>
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
                </xsl:element>
<!-- setup for the credit  -->
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:text>credits</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="p">
                        <xsl:element name="strong">
                            <xsl:text>Terms of Use and Citation </xsl:text>
                        </xsl:element>
                        <xsl:text>The citation terms are as follows :
        "16th Century Exegesis of Paul - a Digital Library: 16th Century Exegesis of Paul, SNF207696, Universties of Geneva and Zürich, dir. Ueli Zahnd and Stefan Krauter, [date of consultation]". </xsl:text>
                    </xsl:element>
                    <xsl:element name="p">
                        <xsl:text>coding &amp; design :</xsl:text>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>mailto:floriane.goy@unige.ch</xsl:text>
                            </xsl:attribute>
                            <xsl:text>floriane.goy@unige.ch</xsl:text>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
                
<!-- setup for the footer -->
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:text>footer</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>logos</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="img">
                            <xsl:attribute name="class">
                                <xsl:text>logo</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="src">
                                <xsl:text>../../../Web_interface/IMG/ihreformation_blanc.png</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:element name="img">
                            <xsl:attribute name="class">
                                <xsl:text>logo2</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="src">
                                <xsl:text>../../../Web_interface/IMG/SNF_logo_standard_web_sw_neg_e.png</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:element name="img">
                            <xsl:attribute name="class">
                                <xsl:text>logo3</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="src">
                                <xsl:text>../../../Web_interface/IMG/uzh-logo-white.png</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>                
            </body>
        </html>
    </xsl:template>
    
    <!-- generate a table of content in the Sidebar -->
    
    <xsl:template name="generate-sidebar">
        <div id="mySidebar" class="sidebar">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
            <a href="../../../index.html">Home</a>
            <div id="toc_container">
                <a class="toc_title" href="javascript:void(0)" onclick="toggleTOC()">&gt; Table of Content</a>
                <ul class="toc_list" style="display: none; padding-left: 8px;">
                    <!-- add the MainZone type for Lambertus -->
                    <xsl:for-each-group select="//*[@type='MainZone-Head'or @type='MainZone']" 
                        group-starting-with="*[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]">
                        <xsl:variable name="FirstNode" select="current-group()[1]"/>
                        <xsl:variable name="firstNodeText" select="string-join($FirstNode//reg, ' ')"/>
                     
                        <li>
                            <a href="#{
                                if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]])
                                then translate(normalize-space($firstNodeText), ' ', '_')
                                else 'Introduction'
                                }"
                                class="point-header"
                                onclick="toggleSubPoints(this)">
                                <xsl:value-of select="
                                    if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]])
                                    then concat('> ', normalize-space($firstNodeText))
                                    else '> Introduction'"/>
                                
                            </a>
                            <ul style="display: none; padding-left: 8px;">
                                <xsl:for-each select="if ($FirstNode[choice/reg[matches(., '^CAP')]] or $FirstNode[hi/choice/reg[matches(., '^CAP')]]) 
                                    then current-group()[position() > 1] 
                                    else current-group()">
                                    <!-- change the path for lambertus use the "seg" element and not the "reg" -->
                                    <xsl:variable name="versetFixedText" select="replace(normalize-space(string-join(.//seg, ' ')), '-\s+', '')"/> 
                                    
                                    <xsl:if test="string-length($versetFixedText) &gt; 0">
                                        <li>
                                            <!-- for a explicite descriptopm of the use of the fonction (lower-case..etc) see the part concerning MainZoneHead -->
                                            <a href="#{lower-case(string-join(subsequence(tokenize($versetFixedText, '\s+'), 1, 3),'_'))}">
                                                <xsl:value-of select="$versetFixedText"/>
                                            </a>
                                        </li>
                                    </xsl:if>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each-group>
                </ul>
            </div>
        </div>
    </xsl:template>
    
    
<!-- delete teiHeader/sourceDoc and original text -->
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
<!-- add title to the document -->
    <xsl:template match="title[parent::titleStmt]">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>title</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template> 
<!-- segment the body in several container for the differtent text-zone -->
    <xsl:template match="body">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>document</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="pb">
                <!-- Extract the relevant digit sequence from pb/@corresp -->
                <xsl:variable name="pbID" select="substring-after(@corresp, 'f')"/>
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>content-wrapper</xsl:text>
                    </xsl:attribute>
                    
                    <!-- Process matching text sections (fw/ab) -->
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>text-container</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates select="../fw[starts-with(@corresp, concat('#f', $pbID))]"/>
                        <xsl:apply-templates select="../ab[starts-with(@corresp, concat('#f', $pbID))]"/>
                        
                        <!-- Add a zone for the marginal glossis (MarginText_Note) -->
                        <xsl:element name="div">
                            <xsl:attribute name="class">
                                <xsl:text>note-section</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('#', substring-after(@corresp, 'f'))"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="../note[starts-with(@corresp, concat('#f', $pbID))]"/>
                        </xsl:element> 
                    </xsl:element> 
                    
                    
                    <!-- Generate the image section after the text-container -->
                    <xsl:element name="div">
                        <xsl:attribute name="class">image-section</xsl:attribute>
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="concat('https://www.e-rara.ch/i3f/v20/', substring-after(@corresp, 'f'), '/full/full/0/default.jpg')"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="substring-after(@corresp,'f')"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
<!-- copy the text forme the note (MarginText_Note) -->
    <xsl:template match="note">
        <xsl:element name="p">
            <xsl:attribute name="class">note-text</xsl:attribute>
            <xsl:apply-templates select=".//reg"/>   
        </xsl:element>
    </xsl:template>
    
<!-- removes all the hyphens and add a space at the end of the line if there is no hyphens -->
    <xsl:template match="reg">
        <xsl:choose>
            <xsl:when test="contains(., '-')">
                <xsl:value-of select="translate(., '-', '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(., ' ')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
<!-- Template for all 'ab' elements -->
    <xsl:template match="ab">
<!-- DropCapitalZone is handled by MainZone-P, so we skip rendering it here -->
        <xsl:if test="@type != 'DropCapitalZone' and @type != 'MainZone-P'">
            <div class="text-section">
                <xsl:choose>
<!-- MainZone-Head special case -->
                    
                    <xsl:when test="@type='MainZone-Head' and (choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')])">
                        <xsl:variable name="Chapter" select="translate(normalize-space(string-join(.//reg, ' ')), ' ', '_')"/>
                        
                        <!--</xsl:variable>-->
                        <span class="ab_mzHead" id="{$Chapter}">
                        <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    
                    <xsl:when test="@type='MainZone-Head' and not(choice/reg[matches(., '^CAP')]) and not(hi/choice/reg[matches(., '^CAP')])">
                        <span class="ab_mzHead" id="{
                            lower-case(string-join(subsequence(tokenize(replace(string-join(.//reg, ' '), '-\s+', ''), '\s+'),1, 3),'_'))}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>
                    
                    
<!-- Step 1: Join all reg elements <xsl:variable name="versetRaw" select="string-join(.//reg, ' ')" />-->
<!-- Step 2: Fix hyphenated breaks (e.g., episco- pum → episcopum)<xsl:variable name="versetFixed" select="replace(normalize-space($versetRaw), '-\s+', '')" />-->
<!-- Step 3: Tokenize words <xsl:variable name="words" select="tokenize($versetFixed, '\s+')" />-->
<!-- Step 4: Build ID with first 3 words joined by underscores <xsl:variable name="versetID" select="lower-case(string-join(subsequence($words, 1, 3), '_'))" />-->
                  
                    
                    <xsl:when test="@type='MainZone-Entry'">
                        <span class="ab_mzEntry">
                            ◦  <xsl:apply-templates/>
                        </span>
                    </xsl:when>
<!-- Default case -->
                    <xsl:otherwise>
                        <table>
                            <tr>
                                <td class="para">
                                    <p>
                                        <xsl:apply-templates/>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:if>
    </xsl:template>
    
    
    
<!-- Skip direct output of DropCapitalZone -->
    <xsl:template match="ab[@type='DropCapitalZone']">
        <span class="ab_Drop">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    
    
<!-- MainZone-P with potential DropCapitalZone integration -->
    <xsl:template match="ab[@type='MainZone-P']">
        <div class="text-section">
            <table>
                <tr>
                    <td class="para">
                        <p>
                            <!-- Only show DropCapital if immediately it precede a MainZone-P -->
                            <xsl:if test="preceding-sibling::*[1][self::ab[@type='DropCapitalZone']]">
                                <span class="ab_Drop">
                                    <xsl:value-of select="preceding-sibling::ab[@type='DropCapitalZone'][1]//choice/reg"/>
                                </span>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
    </xsl:template>
<!-- template for fw elements -->    
    <xsl:template match="fw">
        <!-- right section  with the text -->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>text-section</xsl:text>
            </xsl:attribute>
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
        </xsl:element>
    </xsl:template>
    
<!--add the br break at the end of each line  -->
    <xsl:template match="choice">
        <xsl:choose>
            <!-- IF inside DropCapitalZone, NO <br> -->
            <xsl:when test="ancestor::ab[@type='DropCapitalZone']">
                <xsl:choose>
                    <xsl:when test="descendant::seg">
                        <i><xsl:value-of select="reg"/></i>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="reg"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- IF inside Main* -->            
            <!-- Normal cases -->
            <xsl:when test="descendant::seg">
                <xsl:variable name="versetFixedText" select="replace(normalize-space(string-join(.//seg, ' ')), '-\s+', '')"/>
                
                <xsl:if test="string-length($versetFixedText) &gt; 0">
                   
                        <!-- for a explicite description of the use of the fonction (lower-case..etc) see the part concerning MainZoneHead  -->
                        <span class="ab_mzHeadLam" id="{lower-case(string-join(subsequence(tokenize($versetFixedText, '\s+'), 1, 3),'_'))}">
                            <xsl:value-of select="$versetFixedText"/>
                          
                <xsl:value-of select="seg"/>
                <br/>
               </span> 
                   
                </xsl:if>
            </xsl:when>
            
            
            <xsl:when test="descendant::reg">
                <xsl:value-of select="reg"/>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="reg"/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
