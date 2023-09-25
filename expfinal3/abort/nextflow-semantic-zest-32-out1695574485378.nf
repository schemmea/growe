#!/usr/bin/env nextflow
process h {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash


# Check CPU information and perform action based on the random parameter
if [[ "$variable" =~ ^[0-9]+\$ ]]; then
    # Print CPU flags information
    echo "CPU Flags Information"
    cat /proc/cpuinfo | grep "flags"
else
    # Print CPU model information
    echo "CPU Model Information"
    cat /proc/cpuinfo | grep "model name"
fi
"""
}

process og {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of("e".."p","il",0..8).set{namedchannel1}
namedchannel1  |  h  |  og 
Channel.of(4..4,"yg").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}