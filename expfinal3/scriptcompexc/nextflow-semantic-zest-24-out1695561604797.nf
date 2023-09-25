#!/usr/bin/env nextflow
process o {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

  # Loop to display file permissions every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "File Permissions - Iteration \$i"
      if [[ "$variable" =~ ^[0-9]+\$ ]]; then
          ls -l "$variable"
      else
         ls -l
      fi
  done

"""
}

process husgm_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}
workflow {
Channel.of("x".."y","s".."s").set{namedchannel1}
namedchannel1  |  o 
Channel.of(9..6,643,4..4,"mf",354,4..5,"e".."f",06972).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  husgm_twovars

}