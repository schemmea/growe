#!/bin/bash

for prefix in "nextflow-normal" "nextflow-blind" "nextflow-base" "nextflow-baseblind"; do
    for ((i=20; i<=35; i++)); do
        old_name="../exp2/${prefix}-${i}"
        new_number=$((i+20))
        new_name="../exp1/${prefix}-${i}"
        
        if [ -d "$old_name" ]; then
            echo "copyinging $old_name to $new_name "
            
	    cp -r "$old_name" "$new_name"
        fi
    done
done

