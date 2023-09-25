#!/usr/bin/env nextflow
process tb_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script4.txt'
}

process vohe {
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
workflow {
Channel.of(9..8,34,"sy","sm").set{namedchannel1}
namedchannel1  |  vohe 
Channel.of(8..7,082).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  tb_twovars

}