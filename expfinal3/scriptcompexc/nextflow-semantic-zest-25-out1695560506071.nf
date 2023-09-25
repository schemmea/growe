#!/usr/bin/env nextflow
process bczsd {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process l {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of(1..1,084,"fa").set{namedchannel1}
namedchannel1  |  bczsd  |  l 
Channel.of("z".."h",590,6..4,"r".."v",07).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}