#!/usr/bin/env nextflow
process e{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}

process a{
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

process d{
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
template 'script3'
}
 workflow {
Channel.of("a","e","e","b",9)|c|a|d
}