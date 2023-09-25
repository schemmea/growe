#!/usr/bin/env nextflow
process pmvjzm_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash

# Concatenate two strings
concatenated="${variable}_${variable2}"

echo "String Concatenation:"
echo "$variable + $variable2 = \$concatenated"
"""
}

process veen {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}

process octier {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of("a".."y","d".."o","e".."g").set{namedchannel1}
namedchannel1  |  veen  |  octier 
Channel.of("c".."g","gckumw").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  pmvjzm_twovars

}