#!/usr/bin/env nextflow
process fn {
input: 
val variable 

output:
val variable 
script: 
 template 'allocate_script1.txt'
}

process m {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}

process j {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}
workflow {
Channel.of(74,"m",4..4).set{namedchannel1}
namedchannel1  |  fn  |  m  |  j 
Channel.of("d".."p",9..8,"k".."j").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}