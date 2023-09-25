#!/usr/bin/env nextflow
process b{
input:
val variable
output:
val variable
script:
template 'script5'
}

process a{
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
template 'script2.sh'
}

process c{
input:
val variable
output:
val variable
script:
template 'script4.txt'
}

process e{
input:
val variable
output:
val variable
script:
template 'script5'
}
 workflow {
Channel.of("a","a","c","a")|b|c
}