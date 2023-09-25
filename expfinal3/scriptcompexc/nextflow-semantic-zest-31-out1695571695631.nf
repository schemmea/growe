#!/usr/bin/env nextflow
process o {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process o {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}

process wxz {
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

process ok {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}
workflow {
Channel.of(42,54,"w".."n").set{namedchannel1}
namedchannel1  |  o  |  o  |  wxz  |  ok 
Channel.of(9..1,"b".."c").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}