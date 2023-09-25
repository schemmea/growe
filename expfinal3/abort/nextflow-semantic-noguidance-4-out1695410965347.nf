#!/usr/bin/env nextflow
process un {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash
echo "Hello $variable !{family} !{params.data}" > file.out
"""
}

process ymn_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script10.txt'
}

process sxoxu_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script6.txt'
}

process ogbl {
input: 
val variable 

output:
val variable 
script: 
 template 'foo.txt'
}

process gd_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process b {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}
workflow {
Channel.of(0..4,7..7).set{namedchannel1}
namedchannel1  |  ogbl 
Channel.of(3..7,"d").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  sxoxu_twovars |  gd_twovars
 ymn_twovars( un (namedchannel2.one),  b (namedchannel2.two))
}