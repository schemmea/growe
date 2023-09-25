#!/usr/bin/env nextflow
process s {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash
echo "Hello $variable !{family} !{params.data}" > file.out
"""
}

process dyod {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}
workflow {
Channel.of(0..5,"n".."f",5..3,"i".."y").set{namedchannel1}
namedchannel1  |  s  |  dyod 
Channel.of(39,2..9,0..0).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}