#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script5'
}

process b{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process d{
input:
val variable
output:
val variable
script:
template 'script3'
}
 workflow {
Channel.of("c","b","e","d")|d|b
}