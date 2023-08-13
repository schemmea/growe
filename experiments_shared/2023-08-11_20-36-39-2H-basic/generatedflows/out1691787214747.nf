#!/usr/bin/env nextflow 
 process pa_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script10.txt' 
 } 
  
 process lp_twovars{ 
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

# Perform subtraction of two variables
re='^[0-9]+\$'
num1=$variable
num2=$variable2
if ! [[ $variable =~ \$re ]] ; then
  num1=\$(printf "%d" "'$variable")
fi
if ! [[ $variable =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable2")
fi
difference=\$((num1 - num2))

echo "Subtraction:"
echo "$variable (\$num1) - $variable2 (\$num1) = \$difference"
 
 """ 
 } 
  
 process do{ 
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
  
 process yt_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script9.txt' 
 } 
  workflow { 
   Channel.of("v".."i","yaj").set{namedchannel1} 
   namedchannel1 |  do 
   Channel.of(0..3,"s".."l").branch { 
   one:(String) it<= (String) 1 
   two:(String) it<= (String) 6 
  }.set{namedchannel2} 
   namedchannel2 |  pa_twovars |  lp_twovars |  yt_twovars
 
 }