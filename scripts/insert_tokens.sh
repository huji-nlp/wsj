#!/usr/bin/env bash

TEMP_DIR=$(mktemp -d)

if [ $# -lt 1 ]; then
    wget -r http://www.cs.cmu.edu/afs/cs/project/cmt-55/lti/Courses/722/Spring-08/Penn-tbank/MRG/WSJ/00/ \
        -P ${TEMP_DIR}/ -A MRG --no-parent --cut-dirs=11
    WSJ_DIR=${TEMP_DIR}/www.cs.cmu.edu
else
    WSJ_DIR="$1"
fi

DIR=$(dirname $(readlink -f $0))

for MRG_FILE in ${WSJ_DIR}/00/[wW][sS][jJ]_*.[mM][rR][gG]; do
    BASENAME="$(basename ${MRG_FILE%.*})"  # remove suffix and path
    BASENAME="${BASENAME,,}"  # to lower case
    NUM_SENTENCES="$(csplit ${MRG_FILE} '/^(/' '{*}' -f ${TEMP_DIR}/${BASENAME}. -n 1 | wc -l)"  # split on sentences
    for SENT in $(seq ${NUM_SENTENCES}); do
        echo -ne "$BASENAME.${SENT}\r"
        XML_FILE="${DIR}/../00/ucca/${BASENAME}.${SENT}.xml"
        if [ ! -f ${XML_FILE} ]; then
            continue
        fi
        TOK_FILE="${TEMP_DIR}/${BASENAME}.${SENT}.tokens"  # extract one token per line
        grep -Po '(?<!-NONE- )(?<= )[^) ]+(?=\))' "${TEMP_DIR}/${BASENAME}.${SENT}" | sed 's/&/&amp;/' > ${TOK_FILE}
        perl -MFile::Slurp -pi -e \
            'BEGIN {@lines = read_file("'${TOK_FILE}'", chomp => 1);} s/(?<=")_(?=")/$lines[$i++]/ge' ${XML_FILE}
    done
done
if grep -l '"_"' 00/ucca/*.xml; then
    echo Files exist with remaining placeholders.
else
    echo Replaced all placeholders with tokens.
fi
