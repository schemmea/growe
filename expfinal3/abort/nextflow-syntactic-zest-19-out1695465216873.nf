#!/usr/bin/env nextflow
process e{
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
template 'script1'
}
 workflow {
Channel.of("b","b",3)|e|c
}