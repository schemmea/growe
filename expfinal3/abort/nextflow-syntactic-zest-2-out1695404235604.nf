#!/usr/bin/env nextflow
process a{
input:
val variable
output:
val variable
script:
template 'script3'
}

process b{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}
 workflow {
Channel.of("d","a","e","d")|a|b
}