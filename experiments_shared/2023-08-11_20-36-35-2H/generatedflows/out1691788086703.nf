#!/usr/bin/env nextflow 
 process oow_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script6.txt' 
 } 
  
 process uy_twovars{ 
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


echo "Before Swapping:"
echo "Variable 1: $variable"
echo "Variable 2: $variable2"

# Swap the values of two variables
temp=$variable
variable=$variable2
variable2=\$temp

echo "After Swapping:"
echo "Variable 1: $variable"
echo "Variable 2: $variable2" 
 """ 
 } 
  
 process if{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo Bar $variable 
 """ 
 } 
  workflow { 
   Channel.fromFilePairs("data/*{1,2}*.csv").set{namedchannel1} 
   namedchannel1 |  if 
   Channel.of(7..1,8,"g".."i","d".."x",1..5,80).branch { 
   one:(String) it> (String) "pmx" 
   two:(String) it>= (String) 0||(String) it< (String) "wt" 
  }.set{namedchannel2} 
   namedchannel2 |  oow_twovars |  uy_twovars
 
 }