#!/usr/bin/env nextflow
process ta_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process cr {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}
workflow {
Channel.of("a".."s","m".."y").set{namedchannel1}
namedchannel1  |  cr 
Channel.of(207,"r".."t").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ta_twovars

}