#!/usr/bin/env nextflow
process bii_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script10.txt'
}

process cy_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash


echo "Before Swapping:"
echo "Variable 1: $variable"
echo "Variable 2: $variable2"

# Swap the values of two variables
temp=$variable
variable=$variable2
variable2=\$temp

echo "After Swapping:"
echo "Variable 1: $variable"
echo "Variable 2: $variable2"
"""
}
workflow {
Channel.of(09,5..3).set{namedchannel1}
namedchannel1 
Channel.of(7..2,"v".."m","q",2..8,"q".."f","q".."j").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  bii_twovars |  cy_twovars

}