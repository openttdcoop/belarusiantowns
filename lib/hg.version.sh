#!/bin/bash
#detect version:
TAG=`hg id -t | grep -v tip`
REVISION=`hg parent --template="{rev}"`
if [ $TAG ]; then
  VERSION="$TAG"
else
  VERSION="r$REVISION"
fi
VERDATE=`hg parent --template="{date|shortdate}"`
