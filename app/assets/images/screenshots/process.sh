#!/usr/bin/env bash

for file in `ls originals/*.png`
do
    thumbnail=thumbnails/`basename $file`
    echo "$file => $thumbnail"
    mkdir -p `dirname $thumbnail`
    convert $file -geometry 1000x200 $thumbnail
done