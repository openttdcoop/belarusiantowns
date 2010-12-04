#!/bin/bash
for f in `ls *.stxt`; do
  FILE="`echo $f | sed "s|\.[^\.]*$||;"`.txt"
  cp $f $f.pre
  if [ -f custom_tags.txt ]; then
    IFS=$'\n'
    for i in `cat custom_tags.txt`; do
      FIELD="`echo $i | cut -f1 -d: | sed -e "s/ *$//"`"
      VALUE="`echo $i | cut -f2 -d:`"
      sed "s/{$FIELD}/$VALUE/" $f.pre > $f.post
      mv $f.post $f.pre
    done
    mv $f.pre $FILE
  else
    echo "No custom_tags.txt available, please run nmlc first."
  fi
done
