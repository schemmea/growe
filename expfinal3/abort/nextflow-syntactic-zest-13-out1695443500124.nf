#!/usr/bin/env nextflow
process e{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process c{
input:
val variable
output:
val variable
script:
template 'script5'
}

process a{
input:
val variable
output:
val variable
script:
template 'script1'
}
 workflow {
Channel.of("b","c","b",5)|c|e|a
}