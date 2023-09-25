#!/usr/bin/env nextflow
process zo_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process dvzfzp_twovars{
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
workflow {
Channel.of("xl","c",5..4).set{namedchannel1}
namedchannel1 
Channel.of("a".."s",0814,9..0).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  zo_twovars |  dvzfzp_twovars

}