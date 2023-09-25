#!/usr/bin/env nextflow
process in {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}

process mtoayf {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}
workflow {
Channel.of(8..9,9..3).set{namedchannel1}
namedchannel1  |  in  |  mtoayf 
Channel.of("r".."s",72).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}