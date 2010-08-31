#!/bin/bash
for f in `ls *.stxt`; do
  FILE="`echo $f | sed "s|\.[^\.]*$||;"`.txt"
  cp $f $FILE
  if [ -f custom_tags.txt ]; then
    IFS=$'\n'
    for i in `cat custom_tags.txt`; do
      FIELD="`echo $i | cut -f1 -d:`"
      VALUE="`echo $i | cut -f2 -d: | cut -b2-`"
      sed -i "s/{{$FIELD}}/$VALUE/" $FILE
    done
  else
    echo "No custom_tags.txt available, please run nmlc first."
  fi
done