<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="ab">
        <!-- Skip DropCapitalZone & MainZone-P -->
        <xsl:if test="@type != 'DropCapitalZone' and @type != 'MainZone-P'">
            <xsl:copy>
                <!-- Copy existing attributes except xml:id -->
                <xsl:apply-templates select="@*[name() != 'xml:id']"/>
                
                <!-- CASE 1: MainZone-Head chapter with CAP --> 
                <xsl:if test="@type='MainZone-Head'
                    and (choice/reg[matches(., '^CAP')]
                    or hi/choice/reg[matches(., '^CAP')])">
                    <xsl:variable name="chapter-token" 
                        select="tokenize(normalize-space(string-join(.//reg, ' ')), '\s+')[last()]"/>
                    <xsl:attribute name="xml:id"
                        select="concat('C_', replace(replace($chapter-token, '^CAP\.',''), '\.$',''))"/>
                </xsl:if>
                
                <!-- CASE 2: MainZone-Head without CAP -->
                <xsl:if test="@type='MainZone-Head'
                    and not(choice/reg[matches(., '^CAP')])
                    and not(hi/choice/reg[matches(., '^CAP')])">
                    <xsl:variable name="chapter-id" 
                        select="
                        concat(
                        'C_',
                        replace(
                        replace(
                        tokenize(
                        normalize-space(string-join(
                        (preceding-sibling::ab[@type='MainZone-Head' 
                        and (choice/reg[matches(., '^CAP')] 
                        or hi/choice/reg[matches(., '^CAP')])]
                        //reg), ' ')), '\s+')[last()],
                        '^CAP\.',''),
                        '\.$','')
                        )
                        "/>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="concat($chapter-id, '_v')"/>
                        <xsl:number 
                            level="any"
                            count="ab[@type='MainZone-Head' 
                            and not(choice/reg[matches(., '^CAP')])
                            and not(hi/choice/reg[matches(., '^CAP')])]"
                            from="ab[@type='MainZone-Head' 
                            and (choice/reg[matches(., '^CAP')] 
                            or hi/choice/reg[matches(., '^CAP')])]"/>
                    </xsl:attribute>
                </xsl:if>
                
                <!-- Copy children AFTER all attributes are created -->
                <xsl:apply-templates select="node()"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>
