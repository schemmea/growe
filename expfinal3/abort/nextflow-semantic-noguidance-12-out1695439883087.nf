#!/usr/bin/env nextflow
process ll {
input: 
val variable 

output:
val variable 
script: 
 template 'allocate_script1.txt'
}

process ebsky {
input: 
val variable 

output:
val variable 
script: 
 template 'script4.txt'
}

process ldn {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

echo $variable

"""
}
workflow {
Channel.of(1..9,"i".."j",3..6).set{namedchannel1}
namedchannel1  |  ll  |  ebsky  |  ldn 
Channel.of(8..9,6..6,"i".."l","k".."s","d","k".."y").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}