#!/usr/bin/env nextflow
process z {
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

process c {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}
workflow {
Channel.of("px","k".."k",0..0,"n".."s",73904,"xw").set{namedchannel1}
namedchannel1  |  z  |  c 
Channel.of(2..3,"x","fsmx").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}