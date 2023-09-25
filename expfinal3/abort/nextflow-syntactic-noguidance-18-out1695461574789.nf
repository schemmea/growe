#!/usr/bin/env nextflow
process d{
input:
val variable
output:
val variable
script:
template 'script3'
}

process a{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}
 workflow {
Channel.of("d",6)|d|a
}