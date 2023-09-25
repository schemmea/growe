#!/usr/bin/env nextflow
process nv {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to display system load every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "System Load - Iteration \$i"
    uptime | grep "$variable"
done
"""
}

process ri_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script4.txt'
}

process in {
input: 
val variable 

output:
val variable 
script: 
 template 'multi_script.sh'
}
workflow {
Channel.of("w".."c","f").set{namedchannel1}
namedchannel1  |  nv  |  in 
Channel.of(076,"g".."m","i".."g").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ri_twovars

}