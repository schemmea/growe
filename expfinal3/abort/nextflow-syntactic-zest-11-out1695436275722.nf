#!/usr/bin/env nextflow
process d{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process b{
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
Channel.of("c","a","c",2)|d|a
}