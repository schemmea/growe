#!/usr/bin/env nextflow
process wzug {
input: 
val variable 

output:
val variable 
script: 
 template 'script4.txt'
}

process ynh {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}

process ry {
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
workflow {
Channel.of("uoby","k","p").set{namedchannel1}
namedchannel1  |  wzug  |  ynh  |  ry 
Channel.of(3..8,"k","n".."h").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}