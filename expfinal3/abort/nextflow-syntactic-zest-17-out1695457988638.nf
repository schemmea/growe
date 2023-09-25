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
 workflow {
Channel.of("e","a")|a|c
}