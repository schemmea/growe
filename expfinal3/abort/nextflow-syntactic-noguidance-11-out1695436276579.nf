#!/usr/bin/env nextflow
process e{
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
template 'script5'
}
 workflow {
Channel.of("e","d","c",3)|e|d
}