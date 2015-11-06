# X3DCaseFixer

This repository ontains a couple of scripts to generate a sed script from the X3D xml schema to fix element and attribute case in a (nonconforming) x3d file. The main assumption is that attributes can be identified by a leading space and a trailing '=' character. Always double check the formatted output.
Since the script does not chack for script nodes, there is a good chance that variables which have attribute names in assignments will be transformed as well. This is typically NOT what is intended.

http://www.w3.org/TR/2008/REC-xml-20081126/#sec-starttags
defines that there may be zero or more spaces in front or after the "=" character. This is recognized by the regexp used in the sed script. The output preserves how white space was used.

Use 

$ sed -f sed/fixX3Dcase.sed input.x3d > output.x3d

Check by

$ diff input.x3d output.x3d


Generate sed:

Get x3d schema from http://www.web3d.org/specifications/x3d-3.3.xsd.

First produce lowercase-realcase mappings with xslt

$ xmlsh -c 'xslt -f stylesheets/element.xslt -cf x3d-3.3.xsd' > maps/elementsMap.dat

$ xmlsh -c 'xslt -f stylesheets/attribute.xslt -cf x3d-3.3.xsd' > maps/attributesMap.dat

Then generate sed by awk scripts:

$ awk -f awk/mksed_ele.awk maps/elementsMap.dat > sed/fixCase.sed

$ awk -f awk/mksed_attr.awk maps/attributesMap.dat >> sed/fixCase.sed


