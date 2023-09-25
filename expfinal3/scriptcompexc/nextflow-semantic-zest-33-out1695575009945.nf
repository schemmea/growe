#!/usr/bin/env nextflow
process ip_twovars{
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

process n {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of("f".."m","t".."w").set{namedchannel1}
namedchannel1  |  n 
Channel.of(098,5..0).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ip_twovars

}