# X3DCaseFixer
This repository ontains a couple of scripts to generate sed script from the X3D xml schema to fix element and attribute case

Use
$ sed -f fixX3Dcase.sed input.x3d > output.x3d

Check by
$ diff input.x3d output.x3d
