#!/usr/bin/env nextflow
process a{
input:
val variable
output:
val variable
script:
template 'script3'
}

process b{
input:
val variable
output:
val variable
script:
template 'script1'
}
 workflow {
Channel.of("e","c")|a|b
}