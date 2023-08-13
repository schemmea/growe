#!/usr/bin/env nextflow 
 process gvj{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'bar.txt' 
 } 
  
 process ftj{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash

# Print memory usage
{
    echo "Memory Usage"
    free -m | grep "$variable" &&
} || {
  echo "error"
}
 
 """ 
 } 
  
 process do{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'bash-script.txt' 
 } 
  
 process le_twovars{ 
  debug true 
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
   Channel.fromFilePairs("data/*{1,2}*.txt").set{namedchannel1} 
   namedchannel1 |  gvj |  ftj |  do 
   Channel.of(0..6,"v".."e","u".."d").branch { 
   one:(String) it!= (String) "bty" 
   two:(String) it>= (String) 41||(String) it< (String) 0 
  }.set{namedchannel2} 
   namedchannel2 |  le_twovars
 
 }