#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script1'
}

process e{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}
 workflow {
Channel.of("d","e",8)|c|e
}