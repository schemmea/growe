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

process b{
input:
val variable
output:
val variable
script:
template 'script3'
}
 workflow {
Channel.of("b",3)|b|e
}