#!/usr/bin/env nextflow
process co_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process fz {
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
Channel.of(2..6,277).set{namedchannel1}
namedchannel1  |  fz 
Channel.of("ng","g").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  co_twovars

}