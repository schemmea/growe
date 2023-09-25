#!/usr/bin/env nextflow
process e {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done


"""
}

process ku_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script6.txt'
}
workflow {
Channel.of("vl",2..2,3677).set{namedchannel1}
namedchannel1  |  e 
Channel.of(9..9,0..9).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ku_twovars

}