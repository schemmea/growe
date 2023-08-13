#!/usr/bin/env nextflow 
 process wi{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script4.txt' 
 } 
  
 process ci{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script6' 
 } 
  
 process cd_twovars{ 
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
  workflow { 
   Channel.of("wmr","st",1).set{namedchannel1} 
   namedchannel1 |  wi |  ci 
   Channel.of("bq","wpcpj",730).branch { 
   one:(String) it> (String) 3 
   two:(String) it<= (String) "iqx"||(String) it> (String) "ic"||(String) it< (String) 58 
  }.set{namedchannel2} 
   namedchannel2 |  cd_twovars
 
 }