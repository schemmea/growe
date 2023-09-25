#!/usr/bin/env nextflow
process egg {
input: 
val variable 

output:
val variable 
script: 
 template 'foo.txt'
}

process px_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script8.txt'
}
workflow {
Channel.of(0858,79,4..3).set{namedchannel1}
namedchannel1  |  egg 
Channel.of("o".."s","a").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  px_twovars

}