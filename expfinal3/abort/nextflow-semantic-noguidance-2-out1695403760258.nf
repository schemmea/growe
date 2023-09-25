#!/usr/bin/env nextflow
process n {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

    # Check network interface information and perform action based on the random parameter
    if [[ "$variable" =~ ^[0-9]+\$ ]]; then
        # Print specific network interface information
        echo "Network Interface Information - $variable"
        ip link show
    else
        # Print all network interface information
        echo "All Network Interface Information"
        ip -$variable
    fi

"""
}

process dce_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script8.txt'
}
workflow {
Channel.of("s".."j",6..7).set{namedchannel1}
namedchannel1  |  n 
Channel.of("m".."l","ad",5..6,"zblaw",9..1,"r","y").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  dce_twovars

}