#!/usr/bin/env nextflow
process b{
input:
val variable
output:
val variable
script:
template 'script1'
}

process a{
input:
val variable
output:
val variable
script:
template 'script5'
}

process e{
input:
val variable
output:
val variable
script:
template 'script3'
}

process c{
input:
val variable
output:
val variable
script:
template 'script1'
}
 workflow {
Channel.of("b","c","e","c")|c|a
}