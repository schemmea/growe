#!/bin/bash

base_names=("semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance")
search_file="===== DONE ====="  # Replace with the specific file you're looking for


for base_name in "${base_names[@]}"; do
    for id in {0..14}; do
        folder="nextflow-${base_name}-${id}"
        if [ -d "$folder" ]; then
            log_file="$folder/executor.log"  # Assuming the log file name is consistent

            if [ -f "$log_file" ]; then
                if grep -q "$search_file" "$log_file"; then
  		    echo "$search_file in $folder"
                else
                    echo "!!! $search_file not found in $folder !!!!"
                fi
            else
                echo "Log file $log_file not found in $folder"
            fi

           log_file2="$folder/errorDir/cov-all.log"	   
 	   log_file3="$folder/errorDir/cov-valid.log"
	if [ -f  "$log_file2" ]; then
            echo "$log_file2 in $folder"
        else
            echo "!!! $log_file2 not found in $folder !!!!"
        fi
	if [ -f  "$log_file3" ]; then
            echo "$log_file3 in $folder"
        else
            echo "!!! $log_file3 not found in $folder !!!!"
        fi

        fi
    done
done
