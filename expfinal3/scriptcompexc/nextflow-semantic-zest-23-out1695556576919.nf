#!/usr/bin/env nextflow
process o {
input: 
val variable 

output:
val variable 
script: 
 template 'long_script.sh'
}

process o {
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

process te_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process ct_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script5.txt'
}

process sxcxmk_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash


# Perform comparison of two variables
if [[ variable -gt variable2 ]]; then
    echo "$variable is greater than $variable2"
elif [[ variable -lt variable2 ]]; then
    echo "$variable is less than $variable2"
else
    echo "$variable is equal to $variable2"
fi
"""
}

process d {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}

process ej_twovars{
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
Channel.of("ygw","u".."z","t","u".."u").set{namedchannel1}
namedchannel1  |  o 
Channel.of("j".."o","r".."f").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ct_twovars |  sxcxmk_twovars |  ej_twovars
 te_twovars( o (namedchannel2.one),  d (namedchannel2.two))
}