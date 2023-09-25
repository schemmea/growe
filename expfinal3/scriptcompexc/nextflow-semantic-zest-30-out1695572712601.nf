#!/usr/bin/env nextflow
process vkeb_twovars{
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

process nje_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script6.txt'
}
workflow {
Channel.of("q".."k","n".."x").set{namedchannel1}
namedchannel1 
Channel.of("g",02882).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  vkeb_twovars |  nje_twovars

}