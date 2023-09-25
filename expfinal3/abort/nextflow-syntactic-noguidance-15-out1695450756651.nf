#!/usr/bin/env nextflow
process a{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process c{
input:
val variable
output:
val variable
script:
template 'script1'
}

process d{
input:
val variable
output:
val variable
script:
template 'script3'
}

process e{
input:
val variable
output:
val variable
script:
template 'script5'
}
 workflow {
Channel.of("c","b","a","d","d","d","d","d","c","c")|a|e|c|d
}