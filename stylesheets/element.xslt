<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" extension-element-prefixes="xs">

<!--
    Stylesheet  : X3dElementsAttributesLowerCaseTableConstruction.xslt
    Created     : 18 December 2009, updated November 2015
    Author      : Don Brutzman, updated by Andreas Plesch
    Description : Create table comparing X3D elements and attributes using XML case and lower case
    Reference   : build.xml task html5.buildElementAttributeTables
-->

<xsl:output method="xml" encoding="UTF8" indent="yes" omit-xml-declaration="yes"/>

<xsl:strip-space elements="*" />

<xsl:variable name="X3dSchema"><xsl:text>x3d-3.3.xsd</xsl:text></xsl:variable>
<xsl:variable name="secondColumnIndex">42</xsl:variable>

<!-- ****************** root:  start of file ****************** -->
<xsl:template match="/">

<xsl:message>
  <xsl:text>BuildElementAttributeTables.xslt for HTML5 Recommendation, X3D schema version='</xsl:text>
  <xsl:value-of select="//xs:schema/@version"/>
  <xsl:text>'</xsl:text>
 </xsl:message>
 
<xsl:text> _X3D elements and attributes, shown in relaxed lowercase and strict CamelCase_</xsl:text>
<xsl:text>&#10;</xsl:text>
<xsl:text>&#10;</xsl:text>

<xsl:text>1. X3D elements from </xsl:text>
<xsl:value-of select="$X3dSchema"/>
<xsl:text> schema, lower case and XML case:</xsl:text>
<xsl:text>&#10;</xsl:text>
<xsl:text>================================================================================</xsl:text>
<xsl:text>&#10;</xsl:text>
<xsl:for-each select="//xs:element[string-length(@name) > 0]/parent::*[name()!='xs:appinfo']/xs:element">
    <xsl:sort select="fn:lower-case(@name)"/>

    <!-- skip if duplicate -->
    <xsl:variable name="currentName"><xsl:value-of select="@name"/></xsl:variable>
    <xsl:if test="not(preceding::xs:element[@name=$currentName])">
        <xsl:value-of select="fn:lower-case(@name)"/>
        <!-- recurse to add spaces -->
        <xsl:variable name="spaceBuffer"><xsl:value-of select="$secondColumnIndex - string-length(@name)"/></xsl:variable>
        <xsl:call-template name="insert-spaces">
                <xsl:with-param name="spaceCount" select="$spaceBuffer"/>
        </xsl:call-template>

        <xsl:value-of select="@name"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:if>
</xsl:for-each>
<xsl:text>&#10;</xsl:text>
<xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template name="insert-spaces">
  <xsl:param name="spaceCount"></xsl:param>
  <xsl:variable name="spaceBuffer"><xsl:value-of select="number($spaceCount - 1)"/></xsl:variable>
  <!-- output space character -->
  <xsl:text> </xsl:text>
  <!-- tail recursion
       <xsl:value-of select="$spaceCount"/>
  -->
  <xsl:if test="$spaceCount > 0">
    <xsl:call-template name="insert-spaces">
      <xsl:with-param name="spaceCount" select="$spaceBuffer"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
