#!/usr/bin/env nextflow
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
template 'script1'
}

process e{
input:
val variable
output:
val variable
script:
template 'script3'
}
 workflow {
Channel.of("b","b","d","d",3)|e|b
}