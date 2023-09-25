#!/usr/bin/env nextflow
process b{
input:
val variable
output:
val variable
script:
template 'script3'
}

process a{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}

process e{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}
 workflow {
Channel.of("e","c",5)|b|a
}