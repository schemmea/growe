#!/usr/bin/env nextflow
process d{
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
template 'script3'
}

process b{
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
template 'script4.txt'
}
 workflow {
Channel.of("b","d")|e|a
}