#!/usr/bin/env nextflow 
 process in{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash


# Check CPU information and perform action based on the random parameter
if [[ "$variable" =~ ^[0-9]+\$ ]]; then
    # Print CPU flags information
    echo "CPU Flags Information"
    cat /proc/cpuinfo | grep "flags"
else
    # Print CPU model information
    echo "CPU Model Information"
    cat /proc/cpuinfo | grep "model name"
fi 
 """ 
 } 
  
 process qc_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
 """ 
 #!/bin/bash

# Concatenate two strings
concatenated="${variable}_${variable2}"

echo "String Concatenation:"
echo "$variable + $variable2 = \$concatenated" 
 """ 
 } 
  
 process ni_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script4.txt' 
 } 
  
 process gmtdkme{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script 8.sh' 
 } 
  
 process zo{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo 'Hello $variable' > file.out 
 """ 
 } 
  workflow { 
   Channel.fromFilePairs("data/*{1,2}*.txt").set{namedchannel1} 
   namedchannel1 |  gmtdkme 
   Channel.of("d".."t","q".."e").branch { 
   one:(String) it> (String) "vx" 
   two:(String) it>= (String) "lakv" 
  }.set{namedchannel2} 
   namedchannel2 |  ni_twovars
 qc_twovars( in(namedchannel2.one),  zo(namedchannel2.two)) 
 }