#!/bin/bash

remotepath="/home/alena/source/ma_test2/exp2/"
localpath="$HOME/source/repos/growe/expfinalfinal/"
for prefix in "afl"; do
    for ((i=0; i<=20; i++)); do
        dir="nextflow-${prefix}-${i}/fuzz-results"
        mkdir -p "$localpath$dir"
        echo "~~Downloading $dir~~"

        plot_data="$dir/plot_data"
        cov_all="$dir/cov-all.log"
        cov_valid="$dir/cov-valid.log"
        #exceptions="$dir/exception_log.csv"
        stats="$dir/fuzzer_stats"

        scp alena@213.202.208.247:${remotepath}${plot_data} "${localpath}${plot_data}"
        scp alena@213.202.208.247:${remotepath}${cov_all} "${localpath}${cov_all}"
        scp alena@213.202.208.247:${remotepath}${cov_valid} "${localpath}${cov_valid}"
       # scp alena@213.202.208.247:${remotepath}${exceptions} "${localpath}${exceptions}"
        scp alena@213.202.208.247:${remotepath}${stats} "${localpath}${stats}"

    done
done
