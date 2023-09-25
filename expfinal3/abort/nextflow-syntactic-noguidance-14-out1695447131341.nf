#!/usr/bin/env nextflow
process d{
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
template 'script4.txt'
}
 workflow {
Channel.of("c","e","d","d")|b|d
}