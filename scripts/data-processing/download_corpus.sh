#!/bin/bash

remotepath="/home/alena/source/growe/exp5/"
localpath="$HOME/source/repos/growe/exp5/"
for prefix in  "semantic-noguidance" ; do
    for ((i=0; i<=5; i++)); do
        dir="nextflow-${prefix}-${i}/errorDir/corpus"
        mkdir -p "$localpath$dir"
        echo "~~Downloading $dir~~"

        scp -r alena@213.202.208.247:${remotepath}${dir} "${localpath}${dir}"

    done
done

