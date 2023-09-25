#!/usr/bin/env nextflow
process ifa_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process pac {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}
workflow {
Channel.of("f".."w","d".."x",8..9).set{namedchannel1}
namedchannel1  |  pac 
Channel.of(9..5,449178896).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ifa_twovars

}