#!/usr/bin/env nextflow
process c{
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
Channel.of("b",1)|c|a
}