#!/bin/bash

set -e



cd "$(dirname "$0")"

patchespath=$(pwd)

echo $patchespath


for filename in *.patch
do
    [ -e "$filename" ] || continue
    echo "Apply patch:$filename"
    patch -g0 -p1 -E -d $patchespath/../../buildroot <$filename
    echo "------------"
done
