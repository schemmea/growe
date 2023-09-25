#!/usr/bin/env nextflow
process d{
input:
val variable
output:
val variable
script:
template 'script4.txt'
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
Channel.of("b","e","c","b",7)|d|a
}