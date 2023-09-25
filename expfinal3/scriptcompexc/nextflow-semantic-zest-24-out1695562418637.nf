#!/usr/bin/env nextflow
process apok_twovars{
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

process yz_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash

# Compare the lengths of two strings
length1=\${#$variable}
length2=\${#$variable2}

if [[ length1 -gt length2 ]]; then
    echo "Length of $variable is greater than $variable2"
elif [[ length1 -lt length2 ]]; then
    echo "Length of $variable is less than $variable2"
else
    echo "Length of $variable is equal to $variable2"
fi

"""
}
workflow {
Channel.of("s","f".."d",09,87,4..7,"cveyvjstwqf","fu").set{namedchannel1}
namedchannel1 
Channel.of("lixyxuj","x",9..7).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  apok_twovars |  yz_twovars

}