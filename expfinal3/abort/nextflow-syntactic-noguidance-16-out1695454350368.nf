#!/usr/bin/env nextflow
process d{
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
template 'script3'
}
 workflow {
Channel.of("d","a")|c|e|d
}