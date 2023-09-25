#!/usr/bin/env nextflow
process sywfmi {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process g {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}

process l {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}

process in {
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
Channel.of(8..4,"s".."z",6..9).set{namedchannel1}
namedchannel1  |  sywfmi  |  g  |  l  |  in 
Channel.of(65,"x".."v",9..1).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}