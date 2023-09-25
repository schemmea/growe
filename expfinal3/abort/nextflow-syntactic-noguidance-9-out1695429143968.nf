#!/usr/bin/env nextflow
process c{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}

process d{
input:
val variable
output:
val variable
script:
template 'script1'
}
 workflow {
Channel.of("c","b")|c|d
}