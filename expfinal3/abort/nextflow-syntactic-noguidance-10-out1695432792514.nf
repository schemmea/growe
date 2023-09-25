#!/usr/bin/env nextflow
process e{
input:
val variable
output:
val variable
script:
template 'script3'
}

process d{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}
 workflow {
Channel.of("b",7)|e|d
}