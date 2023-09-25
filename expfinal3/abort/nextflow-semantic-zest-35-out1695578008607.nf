#!/usr/bin/env nextflow
process xmxq {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}

process zd {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}

process xim {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to display system load every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "System Load - Iteration \$i"
    uptime | grep "$variable"
done
"""
}
workflow {
Channel.of(6..6,"c".."l","s".."q","b".."c").set{namedchannel1}
namedchannel1  |  xmxq  |  zd  |  xim 
Channel.of(7..2,"g","d","yi").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}