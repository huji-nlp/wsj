#!/bin/bash

DIR=$(dirname $(readlink -f $0))

for f in $DIR/../00/conllu{,.enhanced{,++}}/*; do
  mv $f $f.tmp || exit 1
  udapy -s ud.Convert1to2 < $f.tmp > $f || exit 1
  rm -f $f.tmp || exit 1
done
