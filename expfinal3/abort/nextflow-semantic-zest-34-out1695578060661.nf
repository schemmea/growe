#!/usr/bin/env nextflow
process iua_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process ji_twovars{
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

process um {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done


"""
}

process no {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process fp_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script6.txt'
}

process yy_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script8.txt'
}

process h {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}

process pi {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of(4..3,0..7).set{namedchannel1}
namedchannel1  |  no  |  pi 
Channel.of("g".."f",9..4,01,"p".."n").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ji_twovars |  fp_twovars |  yy_twovars
 iua_twovars( um (namedchannel2.one),  h (namedchannel2.two))
}