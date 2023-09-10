#!/bin/bash

remotepath="/home/alena/source/growe/exps9/"
localpath="$HOME/source/growe/exps8/"
for prefix in "semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance"; do
#for prefix in "afl"; do
    for ((i=10; i<=19; i++)); do
#        dir="nextflow-${prefix}-${i}/fuzz-results"
		dir="nextflow-${prefix}-${i}/errorDir"
        mkdir -p "$localpath$dir"
        echo "~~Downloading $dir~~"

        plot_data="$dir/plot_data"
        cov_all="$dir/cov-all.log"
        cov_valid="$dir/cov-valid.log"

        scp alena@213.202.208.247:${remotepath}${plot_data} "${localpath}${plot_data}"
        scp alena@213.202.208.247:${remotepath}${cov_all} "${localpath}${cov_all}"
        scp alena@213.202.208.247:${remotepath}${cov_valid} "${localpath}${cov_valid}"

    done
done

