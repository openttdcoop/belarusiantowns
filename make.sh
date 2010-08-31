#!/bin/bash

# http://dev.openttdcoop.org/projects/swisstowns
# http://hg.openttdcoop.org/nml/raw-file/tip/docs/reference.html#block-town_names

GRFID="\4D\47\0D\01"
FILENAME="belarusiantowns"

. lib/hg.version.sh

NML="$FILENAME.nml"

# fill custom-tags.txt for lang files
cat >custom_tags.txt <<EOF
VERSION: $VERSION
DATE: $VERDATE
GRFID: `echo $GRFID | tr '\' ' ' 2>/dev/null`
FILENAME: $FILENAME.grf
EOF

# split big list to parts of 255:
rm -rf tmp && mkdir tmp
split -l126 data/belarusian-towns.txt tmp/

cat >$NML <<EOF
grf {
  grfid: "$GRFID";
  name : string(STR_GRF_NAME);
  desc : string(STR_GRF_DESCRIPTION);
}
EOF

for i in `ls tmp`; do
cat >>$NML <<EOF
town_names(b_$i) {
  {
`awk -F'\t' '{print "    text(\""$2"\", "$1"),"}' tmp/$i`
  }
}
EOF
done
cat >>$NML <<EOF
town_names(big) {
  styles: string(STR_GAME_OPTIONS_TOWN_NAME);
  {
EOF

for i in `ls tmp`; do
  AMOUNT=`cat tmp/$i | wc -l`
  echo "    town_names(b_$i, $AMOUNT)," >>$NML
done

cat >>$NML <<EOF
  }
}
EOF

nmlc $NML
echo "MD5SUM: `md5sum $FILENAME.grf | cut -f1 -d' '`" >> custom_tags.txt
. lib/sed.custom_tags.sh
. lib/zip.sh

exit

#################################################
# Snippets / Notes
#################################################

