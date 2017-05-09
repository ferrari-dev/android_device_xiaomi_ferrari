#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")
CMBASE=$(readlink -f "$PATCHBASE/../../../../")

echo "running $0"

for i in $(find "$PATCHBASE"/* -type d); do
	PATCHNAME=$(basename "$i")
	PATCHTARGET=$PATCHNAME
	for i in $(seq 4); do
		PATCHTARGET=$(echo $PATCHTARGET | sed 's/_/\//')
		if [ -d "$CMBASE/$PATCHTARGET" ]; then break; fi
	done
	echo "\nResetting $PATCHTARGET" || exit 1
	cd "$CMBASE/$PATCHTARGET" || exit 1
	git reset --hard || exit 1
done
