#!/usr/bin/env nextflow
process pl_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process f {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to check disk space usage every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "Disk Space Usage - Iteration \$i"
    df -h "$variable"
done
"""
}
workflow {
Channel.of(0..4,"k".."r").set{namedchannel1}
namedchannel1  |  f 
Channel.of(355,"tk","a".."t",4..8,09,426).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  pl_twovars

}