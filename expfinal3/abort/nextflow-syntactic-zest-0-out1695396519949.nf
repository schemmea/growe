#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script1'
}

process b{
input:
val variable
output:
val variable
script:
template 'script5'
}

process e{
input:
val variable
output:
val variable
script:
template 'script3'
}
 workflow {
Channel.of("b","b","a","e")|b|c
}