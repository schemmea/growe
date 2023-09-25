#!/usr/bin/env nextflow
process xs_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script6.txt'
}

process wg {
input: 
val variable 

output:
val variable 
script: 
 template 'script2.sh'
}
workflow {
Channel.of(0898,2..7,85,"fn").set{namedchannel1}
namedchannel1  |  wg 
Channel.of(0..6,1..2,"n".."k").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  xs_twovars

}