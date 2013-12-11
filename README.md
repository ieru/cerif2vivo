                VIVOCerifTranslator version 0.1 beta                
  @author Alberto Nogales (alberto.nogales@uah.es) and Jesus Mayor  
                                                                    
A tool to translate between CERIF (xml files) to VIVO (owl files)  
and vice-versa. Developed in Alcalá University (Spain) by IERU     
research group (http://www.ieru.org/).                             
Any incidence please submit to the email below.                    

Requirements
============
-Saxon

Saxon is an XSLT and XQuery processor created by Michael Kay. There are open-source and also closed-source commercial versions.
The latest version of Saxon is version 9.5, first released on 19 April 2013
To execute our translator, we recomend Saxon-HE. Saxon-HE (home edition) is an open source product available under the Mozilla Public License version 1.0. It provides implementations of XSLT 2.0, XQuery 1.0, and XPath 2.0 at the basic level of conformance defined by W3C.
We can download it from this link http://sourceforge.net/projects/saxon/files/Saxon-HE/9.5/SaxonHE9-5-1-3J.zip/download

Instructions
============
When you have decompressed the processor, you can use this commands to translate easily:

Vivo-Cerif:
java -jar saxon9he.jar -ext:on InputVivoFile(owl) VIVOCerif.xsl > OutputFileCerif(xml)

Example: java -jar saxon9he.jar -ext:on Example.owl VIVOCerif.xsl > outp.xml

Cerif-Vivo:
java -jar saxon9he.jar -ext:on InputCerifFile(xml) CerifVivo.xsl > OutputFileVivo(owl)

Example: java -jar saxon9he.jar -ext:on Example.xml CerifVivo.xsl > outp.owl

The xsl sheets we have used, are stored in the corresponding folder. Also a VIVO and Cerif instance is at Examples folder, so you can test the tool.
