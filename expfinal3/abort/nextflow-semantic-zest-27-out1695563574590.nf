#!/usr/bin/env nextflow
process k {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}

process lb_twovars{
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
Channel.of(9..8,484221,"k".."j","i".."j").set{namedchannel1}
namedchannel1  |  k 
Channel.of("m".."t","c",4..9).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  lb_twovars

}