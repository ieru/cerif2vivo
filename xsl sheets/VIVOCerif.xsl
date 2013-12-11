<?xml version="1.0"?>

<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"  
xmlns:vivo="http://vivoweb.org/ontology/core#" 
xmlns:foaf="http://xmlns.com/foaf/0.1/" 
xmlns:owl2="http://www.w3.org/2006/12/owl2-xml#" 
xmlns:iuvivo="http://vivo.iu.edu/ontology/iuvivo#"
xmlns:bibo="http://purl.org/ontology/bibo/"
version="2.0">

<xsl:output
	method="xml"
	indent="yes"
	omit-xml-declaration="no"
	encoding="utf-8"/>
	
<xsl:template match="rdf:RDF">

<CERIF  
 xmlns="urn:xmlns:org:eurocris:cerif-1.5-1"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
 release="1.5" date="2012-10-17" 
 sourceDatabase="Project Profile">
	
	<!--<xsl:if test="rdf:Description/rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Project'">-->
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Project']">
		<cfProj>
			<cfProjId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfProjId>
			<cfAcro><xsl:value-of select="vivo:abbreviation"/></cfAcro>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>	
			<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
			<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
				<cfProj_Class>
					<cfClassId>0bd2d47a-8688-4758-a63c-45e76825a0f6</cfClassId>					
					<cfClassSchemeId>794234b8-25bb-46df-9d26-ae660bca64bc</cfClassSchemeId>
				</cfProj_Class>
				<cfProj_Fund>
					<cfFundId><xsl:value-of select="//rdf:Description[vivo:hasFundingVehicle/@rdf:resource=current()/@rdf:about and rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Grant']/@rdf:about"/></cfFundId>						
					<cfAmount><xsl:value-of select="//rdf:Description[vivo:hasFundingVehicle/@rdf:resource=current()/@rdf:about and rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Grant']/vivo:totalAwardAmount"/></cfAmount>	
					<cfClassId>eda2b2e6-34c5-11e1-b86c-08000200c9a66</cfClassId>			
					<cfClassSchemeId>759af93b-34c5-11e1-b86c-0800200c9a66</cfClassSchemeId>
					<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
					<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
				</cfProj_Fund>	
					
		</cfProj>
	</xsl:for-each>
	<!--</xsl:if>-->	
	
	<!--<xsl:if test="rdf:Description/rdf:type/@rdf:resource='http://xmlns.com/foaf/0.1/Person'">-->
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://xmlns.com/foaf/0.1/Person']">
		<cfPers>
			<cfPersId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfPersId>
			<cfGender>
				<xsl:if test="owl2:gender='Male'"><xsl:value-of select="'m'"/></xsl:if>
				<xsl:if test="owl2:gender='Female'"><xsl:value-of select="f"/></xsl:if>
			</cfGender>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfPersName>
				<cfFirstNames><xsl:value-of select="concat(foaf:firstName, ' ', vivo:middleName)"/></cfFirstNames>
				<cfFamilyNames><xsl:value-of select="foaf:lastName"/></cfFamilyNames>
			</cfPersName>
			<cfPersKeyw>
				<cfKeyw><xsl:value-of select="iuvivo:freetextKeyword"/></cfKeyw>
			</cfPersKeyw>
				
			<cfPers_OrgUnit>	
				<cfClassId>eda2b2e6-34c5-11e1-b86c-08000200c9a66</cfClassId>
				<cfClassSchemeId>759af93b-34c5-11e1-b86c-0800200c9a66</cfClassSchemeId>
				<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:personInPosition/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>	
				<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:personInPosition/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>	
			</cfPers_OrgUnit>
		</cfPers>
	</xsl:for-each>	
	<!--</xsl:if>-->
	
	<!--<xsl:if test="rdf:Description/rdf:type/@rdf:resource='http://xmlns.com/foaf/0.1/Organization'">-->
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://xmlns.com/foaf/0.1/Organization']">
		<cfOrgUnit>
			<cfOrgUnitId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfOrgUnitId>
			<cfAcro><xsl:value-of select="vivo:abbreviation"/></cfAcro>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfOrgUnitKeyw>
				<cfKeyw><xsl:value-of select="iuvivo:freetextKeyword"/></cfKeyw>
			</cfOrgUnitKeyw>
				
			<cfPers_OrgUnit>	
				<cfClassId>eda2b2e6-34c5-11e1-b86c-08000200c9a66</cfClassId>
				<cfClassSchemeId>759af93b-34c5-11e1-b86c-0800200c9a66</cfClassSchemeId>	
				<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:organizationForPosition/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>	
				<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:organizationForPosition/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
			</cfPers_OrgUnit>
				
		</cfOrgUnit>
	</xsl:for-each>
	<!--</xsl:if>--><!--events in publications-->
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://purl.org/NET/c4dm/event.owl#Event' and vivo:webpage]">
		<cfEvent>
			<cfEventId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfEventId>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
			<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
		</cfEvent>
	</xsl:for-each>
	
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Grant' and vivo:webpage]">
		<cfFund>
			<cfFundId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfFundId>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfAmount><xsl:value-of select="vivo:totalAwardAmount"/></cfAmount>
			<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
			<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
		</cfFund>
	</xsl:for-each>
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Service' and vivo:webpage]">
		<cfSrv>
			<cfSrvId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfSrvId>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
		</cfSrv>
	</xsl:for-each>
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://purl.org/ontology/bibo/Document' and vivo:webpage]">
		<cfResPubl>
			<cfResPublId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfResPublId>
			<cfResPublDate><xsl:value-of select="//rdf:Description[@rdf:about = //rdf:Description[@rdf:about = current()/vivo:dateTimeValue/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfResPublDate>
			<cfNum><xsl:value-of select="bibo:number"/></cfNum>
			<cfVol><xsl:value-of select="bibo:volume"/></cfVol>
			<cfEdition><xsl:value-of select="bibo:edition"/></cfEdition>
			<cfIssue><xsl:value-of select="bibo:issue"/></cfIssue>
			<cfStartPage><xsl:value-of select="bibo:pageStart"/></cfStartPage>
			<cfEndPage><xsl:value-of select="bibo:pageEnd"/></cfEndPage>
			<cfTotalPage><xsl:value-of select="bibo:numPages"/></cfTotalPage>
			<cfISBN><xsl:value-of select="bibo:isbn13"/></cfISBN>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfResPublAbstr>
				<cfAbstr>
					<xsl:value-of select="bibo:abstract"/>
				</cfAbstr>
			</cfResPublAbstr>
			<cfResPublKeyw>
				<cfKeyw>
					<xsl:value-of select="vivo:freetextKeyword"/>
				</cfKeyw>
			</cfResPublKeyw>
			<cfResPubl_Event>
				<cfResPubl_Class>
					<cfClassId>eda2d9ed-34c5- 11e1-b86c-0800200c9a66</cfClassId>
					<cfClassSchemeId>a7e0dc90- 1be4-4fd9-9ff7-bdfb8a95a1eb</cfClassSchemeId>
					<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = //rdf:Description[@rdf:about = current()/bibo:presentedAt/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
					<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = //rdf:Description[@rdf:about = current()/bibo:presentedAt/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
				</cfResPubl_Class>
			</cfResPubl_Event>
		</cfResPubl>
	</xsl:for-each>
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://purl.org/ontology/bibo/Patent' and vivo:webpage]">
		<cfResPat>
			<cfResPatId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfResPatId>
			<cfRegistrDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfRegistrDate>
			<cfAprovDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfAprovDate>
			<cfPatentNumber><xsl:value-of select="vivo:patentNumber"/></cfPatentNumber>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfResPatAbstr>	
				<cfAbstr>
					<xsl:value-of select="bibo:abstract"/>
				</cfAbstr>
			</cfResPatAbstr>
			<cfResPatKeyw>
				<cfKeyw><xsl:value-of select="vivo:freetextKeyword"/></cfKeyw>
			</cfResPatKeyw>
			<cfOrgUnit_ResPat>
				<cfClassId>eda2b2f0-34c5-11e1-b86c-0800200c9a66</cfClassId>
				<cfClassSchemeId>6832797c-2f56-4336-b4ff-dc0ba2275dfa</cfClassSchemeId>
				<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = //rdf:Description[@rdf:about = current()/bibo:assignee/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
				<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = //rdf:Description[@rdf:about = current()/bibo:assignee/@rdf:resource]/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
			</cfOrgUnit_ResPat>
		</cfResPat>
	</xsl:for-each>
	<xsl:for-each select="//rdf:Description[rdf:type/@rdf:resource='http://vivoweb.org/ontology/core#Equipment' and vivo:webpage]">
		<cfEquip>
			<cfEquipId><xsl:value-of select="substring-after(@rdf:about, '/n')"/></cfEquipId>
			<cfURI><xsl:value-of select="vivo:webpage/@rdf:resource"/></cfURI>
			<cfFacil_Equip>
				<cfClassId>cf7799e7-3477-11e1-b86c-0800200c9a66</cfClassId>
				<cfClassSchemeId>794234b8-25bb-46df-9d26-ae660bca64bc</cfClassSchemeId>
			</cfFacil_Equip>
			<cfOrgUnit_Equip>
				<cfClassId>cf7799e2-3477-11e1-b86c-0800200c9a66</cfClassId>
				<cfClassSchemeId>794234b8-25bb-46df-9d26-ae660bca64bc</cfClassSchemeId>
			</cfOrgUnit_Equip>
			<cfEquip_Class>
				<cfStartDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:start/@rdf:resource]/vivo:dateTime"/></cfStartDate>
				<cfEndDate><xsl:value-of select="//rdf:Description[@rdf:about =//rdf:Description[@rdf:about = current()/vivo:dateTimeInterval/@rdf:resource]/vivo:end/@rdf:resource]/vivo:dateTime"/></cfEndDate>
			</cfEquip_Class>
		</cfEquip>
	</xsl:for-each>
</CERIF>
</xsl:template>
</xsl:stylesheet>
