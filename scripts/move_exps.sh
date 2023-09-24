#!/bin/bash

#for prefix in "semantic-zest" "syntactic-zest" "semantic-noguidance" "syntactic-noguidance"; do
for prefix in "semantic-zest"; do
    for ((i=20; i<=39; i++)); do
        old_name="../expfinal3/nextflow-${prefix}-${i}"
        new_number=$((i-20))
        new_name="../expfinal3/nextflow-${prefix}-${new_number}"
        
        if [ -d "$old_name" ]; then
            echo "copyinging $old_name to $new_name "
            
	        mv "$old_name" "$new_name"
        fi
    done
done

