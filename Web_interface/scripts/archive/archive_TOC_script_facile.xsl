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
    
    <!-- Ceci est la version 1 du script pour la table des matières automatique, il est plus simple et compréhensible que la version II que l'on a gardé dans le  script officiel -->
    <!-- generate a table of content in the Sidebar -->
       <xsl:template name="generate-sidebar">
        <div id="mySidebar" class="sidebar">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
            <a href="../../../index.html">Home</a>
            <div id="toc_container">
                <a class="toc_title" href="javascript:void(0)" onclick="toggleTOC()">Table of Content</a>
                <ul class="toc_list" style="display: none; padding-left: 8px;">
                    <xsl:for-each-group select="//*[@type='MainZone-Head']"
                        group-starting-with="*[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]">
                        <!--mzHeadLine All the nodes in the current grouped block (i.e. the MainZoneHead) -->
                        <xsl:variable name="mzHeadLine" select="current-group()"/> 
                        <!-- FirstNode=the first node in the group (used to check for chapter) -->
                        <xsl:variable name="FirstNode" select="$mzHeadLine[1]"/> 
                        
                        <!-- Determine if the first element is a chapter -->
                        <xsl:choose>
                            <xsl:when test="$FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]">
                                <!-- It's a chapter -->
                                <xsl:variable name="ChapterText" select="$FirstNode//reg"/>
                                <xsl:variable name="ChapterId" select="translate($ChapterText, ' ', '_')"/>
                                <li>
                                    <a href="#{$ChapterId}" class="point-header" onclick="toggleSubPoints(this)">
                                        <xsl:value-of select="$ChapterText"/>
                                    </a>
                                    <ul style="display: none; padding-left: 8px;">
                                        <xsl:for-each select="$mzHeadLine[position() &gt; 1]">
                                            <xsl:variable name="VersetText" select=".//reg"/>
                                            <xsl:variable name="VersetId" select="translate($VersetText, ' ', '_')"/>
                                            <li>
                                                <a href="#{$VersetId}">
                                                    <xsl:value-of select="$VersetText"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </li>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Default group: Introduction -->
                                <li>
                                    <a href="#Introduction" class="point-header" onclick="toggleSubPoints(this)">
                                        <xsl:text>Introduction</xsl:text>
                                    </a>
                                    <ul style="display: none; padding-left: 8px;">
                                        <xsl:for-each select="$mzHeadLine">
                                            <xsl:variable name="VersetText" select=".//reg"/>
                                            <xsl:variable name="VersetId" select="translate($VersetText, ' ', '_')"/>
                                            <li>
                                                <a href="#{$VersetId}">
                                                    <xsl:value-of select="$VersetText"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </li>
                            </xsl:otherwise>
                        </xsl:choose> 
                    </xsl:for-each-group>
                </ul>
            </div>
        </div>
           <!-- VERSION II DU CODE, conservée à titre d'exemple -->
           <!-- $firstNode is the first node of the designed groupe so the first node of the element contained in the MainZoneHead -->
           <!-- <xsl:variable name="FirstNode" select="current-group()[1]"/>
                        <li>
                            <a href="#{ 
                                if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]) 
                                then translate($FirstNode//reg, ' ', '_') 
                                else '> Introduction' 
                                }" 
                                class="point-header" 
                                onclick="toggleSubPoints(this)">
                                <xsl:value-of select="if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]])
                                    then concat('> ', $FirstNode//reg) 
                                    else '> Introduction'"/>
                            </a>
                            <ul style="display: none; padding-left: 8px;">
                                <xsl:for-each select="if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]) 
                                    then current-group()[position() > 1] 
                                    else current-group()">
                                    <xsl:variable name="versetText" select=".//reg"/>
                                    <!-\- string-length(normalize-space($versetText)) > 0 : when there is no element reg do not creat one -\->
                                    <xsl:if test="string-length(normalize-space($versetText)) &gt; 0">
                                        <li>
                                            <a href="#{translate($versetText, ' ', '_')}">
                                                <xsl:value-of select="$versetText"/>
                                            </a>
                                        </li>
                                    </xsl:if>
                                </xsl:for-each>
                            </ul>
                        </li>-->
           <!-- ancien script gestion verset dans la sidbar -->
           <!--<xsl:for-each select="if ($FirstNode[choice/reg[matches(., '^CAP.*')] or hi/choice/reg[matches(., '^CAP.*')]]) 
                                    then current-group()[position() > 1] 
                                    else current-group()">
                                    <xsl:variable name="versetText" select="string-join(.//reg, ' ')"/>
                                    <!-\- string-length(normalize-space($versetText)) > 0 : when there is no element reg, do not create one -\->
                                    <xsl:if test="string-length(normalize-space($versetText)) &gt; 0">
                                        <li>
                                            <a href="#{translate(normalize-space($versetText), ' ', '_')}">
                                                <xsl:value-of select="$versetText"/>
                                            </a>
                                        </li>
                                    </xsl:if>
                                </xsl:for-each>-->
           
           <!-- ancien script pour les MainZone-Head gestion verset -->
           <!--<xsl:when test="@type='MainZone-Head' and not(choice/reg[matches(., '^CAP.*')]) and not(hi/choice/reg[matches(., '^CAP.*')])">
                        <xsl:variable name="verset" select="translate(normalize-space(string-join(.//reg, ' ')), ' ', '_')"/>
                        <span class="ab_mzHead" id="{$verset}">
                            <xsl:apply-templates/>
                        </span>
                    </xsl:when>-->
    </xsl:template>
</xsl:stylesheet>