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
template 'script2.sh'
}
 workflow {
Channel.of("d","b","e")|a|b
}