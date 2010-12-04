#!/bin/bash
#detect version:
TAG=`hg id -t | grep -v tip`
REVISION=`hg parent --template="{rev}"`
[ -z "$REVISION" ] && REVISION=0
if [ $TAG ]; then
  VERSION="$TAG"
else
  VERSION="r`hg id -n`"
fi
VERDATE=`hg parent --template="{date|shortdate}"`
