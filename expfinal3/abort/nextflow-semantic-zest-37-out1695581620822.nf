#!/usr/bin/env nextflow
process slfim_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script4.txt'
}

process sob {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}

process nbu_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash


# Perform comparison of two variables
if [[ variable -gt variable2 ]]; then
    echo "$variable is greater than $variable2"
elif [[ variable -lt variable2 ]]; then
    echo "$variable is less than $variable2"
else
    echo "$variable is equal to $variable2"
fi
"""
}

process t {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done


"""
}
workflow {
Channel.of(1..3,"ka").set{namedchannel1}
namedchannel1  |  sob  |  t 
Channel.of(6..7,"jj","p",6..2).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  slfim_twovars |  nbu_twovars

}