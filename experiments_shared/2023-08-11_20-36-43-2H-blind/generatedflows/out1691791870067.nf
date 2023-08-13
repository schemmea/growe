#!/usr/bin/env nextflow 
 process mkid{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done
} || {
  echo "error"
}
 
 """ 
 } 
  
 process in{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'bash-script.txt' 
 } 
  
 process wnif{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'yesOrNo.nf' 
 } 
  
 process jef_twovars{ 
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
  
 process iocy_twovars{ 
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
  
 process gn{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
    # Check network interface information and perform action based on the random parameter
    if [[ "$variable" =~ ^[0-9]+\$ ]]; then
        # Print specific network interface information
        echo "Network Interface Information - $variable"
        ip link show &&
    else
        # Print all network interface information
        echo "All Network Interface Information"
        ip -$variable &&
    fi
} || {
  echo "error"
} 
 """ 
 } 
  workflow { 
   Channel.of(9..0,"v".."d").set{namedchannel1} 
   namedchannel1 |  in |  gn 
   Channel.of(0..3,"gp","x".."s","pl",0..1).branch { 
   one:(String) it>= (String) "gubxwe" 
   two:(String) it< (String) 4 
  }.set{namedchannel2} 
   namedchannel2 |  iocy_twovars
 jef_twovars( mkid(namedchannel2.one),  wnif(namedchannel2.two)) 
 }