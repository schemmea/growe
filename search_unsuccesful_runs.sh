#!/bin/bash

base_names=("semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance")
search_file="===== DONE ====="  # Replace with the specific file you're looking for

path=$1

for base_name in "${base_names[@]}"; do
    for id in {0..10}; do
       folder="$path/nextflow-${base_name}-${id}"

	      errorstring="$folder"
        if [ -d "$folder" ]; then
            log_file="$folder/executor.log"  # Assuming the log file name is consistent

            if [ -f "$log_file" ]; then
                if ! grep -q "$search_file" "$log_file"; then
  	          	    errorstring="$errorstring not $search_file!!!!"
                fi
            else
                errorstring="$errostring no $log_file!!!!"
            fi

             log_file2="$folder/errorDir/cov-all.log"
             log_file3="$folder/errorDir/cov-valid.log"
             if  [ -f  "$log_file2" ]; then
                    myfilesize=$(wc -c "$log_file2" | awk '{print $1}')
                if [[ $myfilesize -eq 0 ]]; then
                  errorstring="$errorstring cov-all is empty"
                fi
            else
                 errorstring="$errorstring no cov-all !!!!"
            fi
            if  [ -f  "$log_file3" ]; then
                myfilesize=$(wc -c "$log_file3" | awk '{print $1}')
                if [[ $myfilesize -eq 0 ]]; then
                  errorstring="$errorstring cov-valid is empty"
                fi
            else
                errorstring="$errorstring no cov-valid !!!!"
            fi
            echo "$errorstring"

        else
          echo "no run for $folder!"
        fi

    done
done
