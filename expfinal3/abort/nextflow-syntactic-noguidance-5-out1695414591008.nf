#!/usr/bin/env nextflow
process a{
input:
val variable
output:
val variable
script:
template 'script5'
}

process e{
input:
val variable
output:
val variable
script:
template 'script1'
}
 workflow {
Channel.of("e","c","d")|a|e
}