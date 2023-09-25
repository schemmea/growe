#!/usr/bin/env nextflow
process r {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Print memory usage

echo "Memory Usage"
free -m | grep "$variable"

"""
}

process bj_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script9.txt'
}
workflow {
Channel.of(69,70101,5..9,9..3,"l".."k",5..4).set{namedchannel1}
namedchannel1  |  r 
Channel.of("u".."f",0..2).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  bj_twovars

}