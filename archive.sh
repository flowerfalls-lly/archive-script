#!/bin/bash

#finish function 1
if [[ $# -ne 1 ]]
then 
	echo "Parameter missing"
else
	echo "Parameter inputed successfully"
fi

#finish function 2
if [[ -d $1 ]]
then 
	echo
else
	echo "The dictionary is not found!"
fi

#finish function 3
FILE=$(basename $1)  # get dirname
FILE_PATH=$(cd $(dirname $1);pwd)

#finish function 4
DATE=$(date +%Y%m%d)

#finish function 5
FILE_NAME=archive_${FILE}_$DATE.tar.gz
DEST=./archive/$FILE_NAME

#finish function 6
echo "Operating now"

tar -czf "$DEST" "$FILE_PATH/$FILE"

#finish function 7
if [[ $? -eq 0 ]]
then
	echo "Opearating successfully"
else
	echo "Operating failed"
	echo "Operating file_name: $DEST"
fi

exit