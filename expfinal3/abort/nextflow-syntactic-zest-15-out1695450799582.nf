#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process e{
input:
val variable
output:
val variable
script:
template 'script5'
}

process b{
input:
val variable
output:
val variable
script:
template 'script5'
}
 workflow {
Channel.of("b","d","d")|b|e|c
}