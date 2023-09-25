#!/usr/bin/env nextflow
process d{
input:
val variable
output:
val variable
script:
template 'script3'
}

process e{
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
Channel.of("b","e","b","a","a")|e|d|a
}