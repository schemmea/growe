#!/bin/bash

#base_names=("semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance")
base_names=("normal" "blind" "base" "baseblind")
search_file="===== DONE ====="  # Replace with the specific file you're looking for

path=$1

for base_name in "${base_names[@]}"; do
    for id in {0..36}; do
       folder="$path/nextflow-${base_name}-${id}"

        if [ -d "$folder" ]; then
            log_file="$folder/executor.log"  # Assuming the log file name is consistent

            if [ -f "$log_file" ]; then
                 echo "delete $log_file"
		 rm "$log_file"
            fi
            work="$folder/work"
            echo "delete $work"
	    rm -r $work
            nf="$folder/.nextflow"
            rm -r $nf
            echo "delete $nf"

        else
          echo "no run for $folder!"
        fi

    done
done
