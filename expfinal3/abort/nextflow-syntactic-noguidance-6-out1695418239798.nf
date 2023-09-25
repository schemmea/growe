#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script1'
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
Channel.of("e",2)|b|c
}