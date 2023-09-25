#!/usr/bin/env nextflow
process b{
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
template 'script3'
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
Channel.of("c","a","b","e")|d|c
}