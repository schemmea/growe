#!/usr/bin/env nextflow
process b{
input:
val variable
output:
val variable
script:
template 'script5'
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
template 'script1'
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
Channel.of("e","c")|c|d
}