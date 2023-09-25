#!/usr/bin/env nextflow
process a{
input:
val variable
output:
val variable
script:
template 'script1'
}

process e{
input:
val variable
output:
val variable
script:
template 'script1'
}

process c{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}
 workflow {
Channel.of("c","a")|a|c
}