#!/bin/bash

DIR=$(dirname $(readlink -f $0))
cd $DIR/../../CoreNLP

rm -f $DIR/../00/conllu{,.enhanced{,++}}/* || exit 1
for i in 0001.1 0001.2 0002.1 0003.10 0003.11 0003.12 0003.13 0003.14 0003.15 0003.16 0003.17 0003.18 0003.19 0003.1 0003.20 0003.21 0003.22 0003.23 0003.24 0003.25 0003.26 0003.27 0003.28 0003.29 0003.2 0003.30 0003.3 0003.4 0003.5 0003.6 0003.7 0003.8 0003.9 0004.10 0004.11 0004.12 0004.13 0004.14 0004.15 0004.16 0004.17 0004.1 0004.2 0004.3 0004.4 0004.5 0004.6 0004.7 0004.8 0004.9 0005.1 0005.2 0005.3 0007.1 0007.2 0007.3 0007.4 0008.1 0008.2 0008.3 0008.4 0008.5 0008.6 0009.1 0009.2 0009.3 0009.4 0010.10 0010.11 0010.12 0010.13 0010.14 0010.15 0010.16 0010.17 0010.18 0010.19 0010.1 0010.20 0010.2 0010.3 0010.4 0010.5 0010.6 0010.7 0010.8 0010.9 0011.1 0011.2 0011.3 0011.4 0011.5 0011.6 0011.7 0011.8 0012.1 0012.2 0012.3 0012.4 0012.5; do
  sent_id=wsj_$i
  doc_id=${sent_id%.*}
  found=
  for existing in $DIR/../00/conllu/_$doc_id.*; do
    found=1
  done
  if [ -n "$found" ]; then
    java -cp "*" -mx1g edu.stanford.nlp.trees.ud.UniversalDependenciesConverter -treeFile ../data/wsj/00/$doc_id.mrg | csplit - '/^$/' '{*}' -f $DIR/../00/conllu/_$doc_id. -n 1 || exit 1
    java -cp "*" -mx1g edu.stanford.nlp.trees.ud.UniversalDependenciesConverter -treeFile ../data/wsj/00/$doc_id.mrg -outputRepresentation enhanced | csplit - '/^$/' '{*}' -f $DIR/../00/conllu.enhanced/_$doc_id. -n 1 || exit 1
    java -cp "*" -mx1g edu.stanford.nlp.trees.ud.UniversalDependenciesConverter -treeFile ../data/wsj/00/$doc_id.mrg -outputRepresentation enhanced++ | csplit - '/^$/' '{*}' -f $DIR/../00/conllu.enhanced++/_$doc_id. -n 1 || exit 1
  fi
  for f in '' .enhanced .enhanced++; do
    echo "# doc_id = $doc_id" > $DIR/../00/conllu$f/$sent_id.conllu || exit 1
    echo "# sent_id = $sent_id" >> $DIR/../00/conllu$f/$sent_id.conllu || exit 1
    grep -v '^$' $DIR/../00/conllu$f/_$doc_id.$(expr ${i#*.} - 1) >> $DIR/../00/conllu$f/$sent_id.conllu || exit 1
    echo >> $DIR/../00/conllu$f/$sent_id.conllu || exit 1
  done
done
rm -f $DIR/../00/conllu{,.enhanced{,++}}/_*

