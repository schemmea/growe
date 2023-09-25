#!/usr/bin/env nextflow
process b{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process a{
input:
val variable
output:
val variable
script:
template 'script1'
}

process c{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}
 workflow {
Channel.of("e",8)|b|a
}