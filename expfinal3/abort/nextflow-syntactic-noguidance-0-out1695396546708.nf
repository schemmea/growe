#!/usr/bin/env nextflow
process e{
input:
val variable
output:
val variable
script:
template 'script5'
}

process b{
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
template 'script4.txt'
}

process a{
input:
val variable
output:
val variable
script:
template 'script2.sh'
}
 workflow {
Channel.of("e","b",8)|b|c
}