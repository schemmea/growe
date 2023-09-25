#!/usr/bin/env nextflow
process p {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}

process tt {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash


  # Loop to display system uptime every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "System Uptime - Iteration \$i"
      uptime | grep "$variable"
  done

"""
}
workflow {
Channel.of(968,868).set{namedchannel1}
namedchannel1  |  p  |  tt 
Channel.of(3..4,"m".."h","x".."d","n","w".."n").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}