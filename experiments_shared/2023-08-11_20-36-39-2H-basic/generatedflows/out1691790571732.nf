#!/usr/bin/env nextflow 
 process fu_twovars{ 
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
  
 process hog_twovars{ 
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
  
 process piait_twovars{ 
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
  
 process zv{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script2.sh' 
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

# Loop to check disk space usage every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "Disk Space Usage - Iteration \$i"
    df -h "$variable"
done 
 """ 
 } 
  workflow { 
   Channel.of("m".."j","wunet",3..0,70,"x".."q").set{namedchannel1} 
   namedchannel1 |  zv |  if 
   Channel.of(0..0,6..8,0..0).branch { 
   one:(String) it<= (String) 0||(String) it> (String) "aaojsj" 
   two:(String) it> (String) "jk"||(String) it!= (String) "jkgvih" 
  }.set{namedchannel2} 
   namedchannel2 |  fu_twovars |  hog_twovars |  piait_twovars
 
 }