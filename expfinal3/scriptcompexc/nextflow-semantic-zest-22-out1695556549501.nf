#!/usr/bin/env nextflow
process aa_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash

# Compare the lengths of two strings
length1=\${#$variable}
length2=\${#$variable2}

if [[ length1 -gt length2 ]]; then
    echo "Length of $variable is greater than $variable2"
elif [[ length1 -lt length2 ]]; then
    echo "Length of $variable is less than $variable2"
else
    echo "Length of $variable is equal to $variable2"
fi

"""
}

process dcdhjh {
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

process p {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}

process hx {
input: 
val variable 

output:
val variable 
script: 
 template 'script5'
}
workflow {
Channel.of(7..7,43).set{namedchannel1}
namedchannel1  |  dcdhjh  |  p  |  hx 
Channel.of("i",099,01).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  aa_twovars

}