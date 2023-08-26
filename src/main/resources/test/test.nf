#!/usr/bin/env nextflow
process vfa_onevar {
debug true
input:
val variable

output:
val variable
script:
"""
#!/bin/bash
echo 'Hello $variable' > file.out
"""
}

process lfi_twovars{
debug true
input:
val variable
val variable2

output:
val variable
val variable2
script:
template 'twovars_script2.txt'
}
workflow {
Channel.fromPath("/data/*.txt").set{namedchannel1}
namedchannel1.view()
namedchannel1  |  vfa_onevar
Channel.of("s",024).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  lfi_twovars
}