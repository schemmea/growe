#!/usr/bin/env nextflow 
 process pm_twovars{ 
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

re='^[0-9]+\$'
num=100
num2=1024
if ! [[ $variable =~ \$re ]] ; then
  num=\$(printf "%d" "'$variable")
else
  num=$variable
fi
if ! [[ $variable2 =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable")
else
  num2=$variable2
fi
# Calculate the number of bytes for the desired memory consumption
memory_size=\$((1024 * num2 * num))  # 100 MB

# Allocate memory by creating a large array
data=(\$(dd if=/dev/zero bs="\$memory_size" count=1))

# Perform some operations using the allocated memory
# ...
# Your code here
value1=\$((num / num2))

# Release the allocated memory
unset data
echo "$variable * $variable2 = \$value1"

 
 """ 
 } 
  
 process emj{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'multi_script.sh' 
 } 
  
 process wte_twovars{ 
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
  
 process byy{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'yesOrNo.nf' 
 } 
  workflow { 
   Channel.of("j".."r","mw","kn",350).set{namedchannel1} 
   namedchannel1 |  emj |  byy 
   Channel.of("v".."p",56,"f".."h","o".."l",8..4,"a".."x",0..4,"pc",0..9).branch { 
   one:(String) it<= (String) "xsb" 
   two:(String) it< (String) "bem" 
  }.set{namedchannel2} 
   namedchannel2 |  pm_twovars |  wte_twovars
 
 }