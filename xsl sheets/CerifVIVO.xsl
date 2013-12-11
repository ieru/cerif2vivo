<?xml version="1.0"?>
<!DOCTYPE rdf:RDF [
	<!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
	<!ENTITY ns "http://www.iro.umontreal.ca/lapalme/ns#">
	<!ENTITY iuvivo "http://vivo.iu.edu/ontology/iuvivo#">
	<!ENTITY dc "http://purl.org/dc/elements/1.1/">
	<!ENTITY owl2 "http://www.w3.org/2006/12/owl2-xml#">
	<!ENTITY vivo "http://vivoweb.org/ontology/core#">
	<!ENTITY vitro "http://vitro.mannlib.cornell.edu/ns/vitro/0.7#">
	<!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
	<!ENTITY afn "http://jena.hpl.hp.com/ARQ/function#">
	<!ENTITY foaf "http://xmlns.com/foaf/0.1/">
	<!ENTITY owl "http://www.w3.org/2002/07/owl#">
	<!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
	<!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
	<!ENTITY bibo "http://purl.org/ontology/bibo/">
]>
<xsl:stylesheet
  xmlns:rdf="&rdf;"
  xmlns:cerif="urn:xmlns:org:eurocris:cerif-1.5-1"
  xmlns:vivo="&vivo;"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

<xsl:output
	method="xml"
	indent="yes"
	omit-xml-declaration="no"
	encoding="utf-8"/>

<xsl:template match="/">
	<rdf:RDF
		xmlns:iuvivo="&iuvivo;"
		xmlns:dc="&dc;"
		xmlns:owl2="&owl2;"
		xmlns:vivo="&vivo;"
		xmlns:vitro="&vitro;"
		xmlns:rdf="&rdf;"
		xmlns:afn="&afn;"
		xmlns:foaf="&foaf;"
		xmlns:owl="&owl;"
		xmlns:xsd="&xsd;"
		xmlns:rdfs="&rdfs;"
		xmlns:bibo="&bibo;">
		<xsl:variable name="idCounter" select="1234"/><!--Set this as you want. (Start id)-->
		<xsl:for-each select="//cerif:cfProj">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfProjId}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Project"/>
				<vivo:abbreviation><xsl:value-of select="cerif:cfAcro"/></vivo:abbreviation>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="{cerif:cfProj_Fund/cerif:cfFundId}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Grant"/>
				<vivo:totalAwardAmount><xsl:value-of select="cerif:cfProj_Fund/cerif:cfAmount"/></vivo:totalAwardAmount>
				<vivo:hasFundingVehicle rdf:resource="{cerif:cfProjId}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfProj_Fund/cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nProj{$idCounter+position()*3+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfProj_Fund/cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfPers">
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfPersId}">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
				<rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Agent"/>
				<vivo:personInPosition rdf:resource="http://vivo.iu.edu/individual/position{$idCounter+position()*3}"/>
				<foaf:firstName><xsl:value-of select="cerif:cfPersName/cerif:cfFirstNames"/></foaf:firstName>
				<foaf:lastName><xsl:value-of select="cerif:cfPersName/cerif:cfFamilyNames"/></foaf:lastName>
				<iuvivo:freetextKeyword rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="cerif:cfPersKeyw/cerif:cfKeyw"/></iuvivo:freetextKeyword>
				<owl2:gender>
					<xsl:if test="cerif:cfGender='m'"><xsl:value-of select="'Male'"/></xsl:if>
					<xsl:if test="cerif:cfGender='f'"><xsl:value-of select="'Female'"/></xsl:if>
				</owl2:gender>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/position{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#FacultyPosition"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfPers_OrgUnit/cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPerson{$idCounter+position()*3+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfPers_OrgUnit/cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfOrgUnit">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfOrgUnitId}">
				<rdf:type rdf:resource="http://www.w3.org/1999/02/22-rdf-syntax-ns#description"/>
				<rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
				<vivo:abbreviation><xsl:value-of select="cerif:cfAcro"/></vivo:abbreviation>
				<iuvivo:freetextKeyword rdf:datatype="http://www.w3.org/2001/XMLSchema#string"><xsl:value-of select="cerif:cfOrgUnitKeyw/cerif:cfKeyw"/></iuvivo:freetextKeyword>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Agent"/>
				<vitro:mostSpecificType rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
				<vivo:organizationForPosition rdf:resource="http://vivo.iu.edu/individual/positionOrg{$idCounter+position()*3}"/><!-- added jesús -->
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/positionOrg{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
				<vivo:positionForPerson rdf:resource="http://vivo.iu.edu/individual/person416500"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#NonFacultyAcademicPosition"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3}"/><!-- added -->
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/positionOrg{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#FacultyPosition"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Position"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeInterval"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfPers_OrgUnit/cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nOrg{$idCounter+position()*3+2}">
					<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
					<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
					<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
					<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfPers_OrgUnit/cerif:cfEndDate"/></vivo:dateTime>
					<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfSrv">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfSrvId}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Service"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfResPubl">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfResPublId}">
				<rdf:type rdf:resource="http://purl.org/ontology/bibo/Document"/>
				<xsl:call-template name="tokenizeKWD"> 
					<xsl:with-param name="csv" select="cerif:cfResPubl_Class/cerif:cfResPublKeyw/cerif:cfKeyw" />
				</xsl:call-template>
				<bibo:number><xsl:value-of select="cerif:cfNum"/></bibo:number>
				<bibo:volume><xsl:value-of select="cerif:cfVol"/></bibo:volume>
				<bibo:edition><xsl:value-of select="cerif:cfEdition"/></bibo:edition>
				<bibo:issue><xsl:value-of select="cerif:cfIssue"/></bibo:issue>
				<bibo:pageStart rdf:datatype="http://www.w3.org/2001/XMLSchema#int"><xsl:value-of select="cerif:cfStartPage"/></bibo:pageStart>
				<bibo:pageEnd rdf:datatype="http://www.w3.org/2001/XMLSchema#int"><xsl:value-of select="cerif:cfEndPage"/></bibo:pageEnd>
				<bibo:numPages rdf:datatype="http://www.w3.org/2001/XMLSchema#int"><xsl:value-of select="cerif:cfTotalPage"/></bibo:numPages>
				<bibo:isbn13><xsl:value-of select="cerif:cfISBN"/></bibo:isbn13>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/academicTerm/{$idCounter+position()*3}"/>
				<bibo:abstract><xsl:value-of select="cerif:cfAbstr"/></bibo:abstract>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#InformationResource"/>
				<vitro:mostSpecificType rdf:resource="http://purl.org/ontology/bibo/Document"/>
				<bibo:presentedAt rdf:resource="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5}"/>
				<vivo:dateTimeValue rdf:resource="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+3}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5}">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://purl.org/ontology/bibo/Conference"/>
				<rdf:type rdf:resource="http://purl.org/NET/c4dm/event.owl#Event"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+1}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+2}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+3}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfResPubl_Event/cerif:cfResPubl_Class/cerif:cfStartDate" /></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfResPubl_Event/cerif:cfResPubl_Class/cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPub{$idCounter+position()*5+4}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nPubS{$idCounter+position()*5+4}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPubS{$idCounter+position()*5+4}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfResPublDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfResPat">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfResPatId}">
				<rdf:type rdf:resource="http://purl.org/ontology/bibo/Patent"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<bibo:abstract><xsl:value-of select="cerif:cfResPatAbstr/cerif:cfAbstr" /></bibo:abstract>
				<xsl:call-template name="tokenizeKWD"> 
					<xsl:with-param name="csv" select="cerif:cfResPatKeyw/cerif:cfKeyw" />
				</xsl:call-template>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5}"/>
				<vivo:patentNumber><xsl:value-of select="cerif:cfPatentNumber"/></vivo:patentNumber>
				<bibo:assignee rdf:resource="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+3}"/>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfRegistrDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfAprovDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+3}">
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<rdf:type rdf:resource="http://purl.org/ontology/bibo/Agent"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+4}"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPat{$idCounter+position()*5+4}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nPatS{$idCounter+position()*5+4}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nPatE{$idCounter+position()*5+4}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPatS{$idCounter+position()*5+4}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfOrgUnit_ResPat/cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nPatE{$idCounter+position()*5+4}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfOrgUnit_ResPat/cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfFund">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfFundId}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Grant"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<vivo:totalAwardAmount><xsl:value-of select="cerif:cfAmount"/></vivo:totalAwardAmount>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3}"/>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nGrant{$idCounter+position()*3+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cerif:cfEvent">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cfEventId}">
				<rdf:type rdf:resource="http://purl.org/NET/c4dm/event.owl#Event"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3}"/>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEvent{$idCounter+position()*3+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
		<xsl:for-each select="//cfEquip">
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/n{cerif:cdEquipId}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#Equipment"/>
				<vivo:webpage rdf:resource="{cerif:cfURI}"/>
				<vivo:dateTimeInterval rdf:resource="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3}"/>
				<rdf:type rdf:resource="http://www.w3.org/2022/07/owl#Thing"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:start rdf:resource="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3+1}"/>
				<vivo:end rdf:resource="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3+2}"/>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3+1}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfEquip_Class/cerif:cfStartDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
			
			<rdf:Description rdf:about="http://vivo.iu.edu/individual/nEquip{$idCounter+position()*3+2}">
				<rdf:type rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
				<rdf:type rdf:resource="http://www.w3.org/2002/07/owl#Thing"/>
				<vivo:dateTimePrecision rdf:resource="http://vivoweb.org/ontology/core#yearPrecision"/>
				<vivo:dateTime rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="cerif:cfEquip_Class/cerif:cfEndDate"/></vivo:dateTime>
				<vitro:mostSpecificType rdf:resource="http://vivoweb.org/ontology/core#DateTimeValue"/>
			</rdf:Description>
		</xsl:for-each>
	</rdf:RDF>
</xsl:template>

<xsl:template name="tokenizeKWD">
	<xsl:param name="csv" />
	<xsl:variable name="first-item" select="normalize-space( 
		substring-before( concat( $csv, ';'), ';'))" /> 
	<xsl:if test="$first-item">
		<vivo:freetextKeyword><xsl:value-of select="$first-item"/></vivo:freetextKeyword>
		<xsl:call-template name="tokenizeKWD"> 
			<xsl:with-param name="csv" select="substring-after($csv,';')" /> 
		</xsl:call-template>    
	</xsl:if>  
</xsl:template>
</xsl:stylesheet>
