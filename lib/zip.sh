#!/bin/bash
rm -r $FILENAME 2>/dev/null
mkdir $FILENAME
cp $FILENAME.grf readme.txt changelog.txt $FILENAME/
7za a -l -tzip -mx=9 $FILENAME-$VERSION.zip $FILENAME
