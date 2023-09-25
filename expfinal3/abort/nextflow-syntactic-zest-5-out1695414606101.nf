#!/usr/bin/env nextflow
process b{
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
Channel.of("b",6)|a|b
}