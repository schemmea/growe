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
template 'script1'
}
 workflow {
Channel.of("d",9)|b|c
}