#!/usr/bin/env nextflow
process d{
input:
val variable
output:
val variable
script:
template 'script1'
}

process a{
input:
val variable
output:
val variable
script:
template 'script3'
}
 workflow {
Channel.of("a",9)|d|a
}