# X3DCaseFixer

This repository ontains a couple of scripts to generate sed script from the X3D xml schema to fix element and attribute case. The main assumption is that attributes can be identified by a leading space and a trailing '=' character.

Use

$ sed -f fixX3Dcase.sed input.x3d > output.x3d

Check by

$ diff input.x3d output.x3d


Generate sed:

First produce lowercase-realcase mappings with xslt

$ xmlsh -c 'xslt -f stylesheets/element.xslt -cf x3d-3.3.xsd' > elementsMap.dat

$ xmlsh -c 'xslt -f stylesheets/attribute.xslt -cf x3d-3.3.xsd' > attributesMap.dat

Then generate sed by awk scripts:

$ awk -f awk/mksed_ele.awk elementsMap.dat > fixCase.sed

$ awk -f awk/mksed_attr.awk attributesMap.dat >> fixCase.sed


