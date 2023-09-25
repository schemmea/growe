#!/usr/bin/env nextflow
process g {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Print memory usage

echo "Memory Usage"
free -m | grep "$variable"

"""
}

process fx {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}
workflow {
Channel.of("ybhwt",38).set{namedchannel1}
namedchannel1  |  g  |  fx 
Channel.of("tsr",8..9).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}