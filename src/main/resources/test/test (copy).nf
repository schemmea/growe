#!/usr/bin/env nextflow 
 process tnpb_twovars{ 
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
num1=$variable
num2=$variable2
if ! [[ $variable =~ \$re ]] ; then
  num1=\$(printf "%d" "'$variable")
else
  num1=$variable
fi
if ! [[ $variable2 =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable2")
else
  num2=$variable2
 fi

# Perform addition of two variables
sum=\$((num1 + num2))

echo "Addition:"
echo "$variable + $variable2 = \$sum"
 
 """ 
 } 
  
 process v{ 
 debug true 
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
  
 process uan{ 
 debug true 
 input: 
 val variable 
  
 output: 
 val variable 
 script: 
 template 'bash-script.txt' 
 } 
 
 workflow { 
 Channel.fromPath("data/*.csv").set{namedchannel1} 
 namedchannel1 |  v |  uan 
 Channel.of("u".."p","m").branch { 
 one:(String) it> (String) 883||(String) it!= (String) 69||(String) it< (String) "w" 
 two:(String) it<= (String) "ii"||(String) it> (String) 30||(String) it< (String) 90 
 }.set{namedchannel2} 
 namedchannel2 |  tnpb_twovars
