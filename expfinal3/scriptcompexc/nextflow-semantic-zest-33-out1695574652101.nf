#!/usr/bin/env nextflow
process gsk_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script5.txt'
}

process nkoa_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process bhrf {
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
workflow {
Channel.of(3..4,35,"i".."o",09813,9..4,9..4,1..5,1..2).set{namedchannel1}
namedchannel1  |  bhrf 
Channel.of(20268,"g".."v").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  gsk_twovars |  nkoa_twovars

}