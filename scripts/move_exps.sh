#!/bin/bash

for prefix in "semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance"; do
    for ((i=20; i<=35; i++)); do
        old_name="../exp2/nextflow-${prefix}-${i}"
        new_number=$((i+20))
        new_name="../exp1/nextflow-${prefix}-${i}"
        
        if [ -d "$old_name" ]; then
            echo "copyinging $old_name to $new_name "
            
	    cp -r "$old_name" "$new_name"
        fi
    done
done

