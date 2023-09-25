#!/usr/bin/env nextflow
process d{
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
template 'script1'
}
 workflow {
Channel.of("e","b","e","a")|e|d
}