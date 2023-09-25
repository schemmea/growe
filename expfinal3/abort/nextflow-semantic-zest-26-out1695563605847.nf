#!/usr/bin/env nextflow
process cii_twovars{
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

process h {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

  # Loop to list running processes every 3 seconds for 10 iterations
  for ((i=0; i<4; i++))
  do
      echo "Running Processes - Iteration \$i"
      ps aux | grep "$variable"
  done

"""
}

process sq_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script4.txt'
}

process m {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}

process jm_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}
workflow {
Channel.of(8..8,55).set{namedchannel1}
namedchannel1  |  h  |  m 
Channel.of(6..5,"w".."t").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  cii_twovars |  sq_twovars |  jm_twovars

}