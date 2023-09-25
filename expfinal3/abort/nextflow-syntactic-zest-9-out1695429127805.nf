#!/usr/bin/env nextflow
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
template 'script4.txt'
}

process d{
input:
val variable
output:
val variable
script:
template 'script5'
}

process c{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}
 workflow {
Channel.of("a","a")|c|e|b|d
}