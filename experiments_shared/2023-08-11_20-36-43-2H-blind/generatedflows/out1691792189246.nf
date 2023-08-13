#!/usr/bin/env nextflow 
 process ml_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script8.txt' 
 } 
  
 process bw{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'shell-script.txt' 
 } 
  
 process bw{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script7.txt' 
 } 
  
 process sfxa{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
  # Loop to display file permissions every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "File Permissions - Iteration \$i"
      if [[ "$variable" =~ ^[0-9]+\$ ]]; then
          ls -l "$variable"
      else
         ls -l
      fi
  done
} || {
  echo "error"
} 
 """ 
 } 
  workflow { 
   Channel.fromFilePairs("data/*{1,2}*.fq").set{namedchannel1} 
   namedchannel1 |  bw |  bw |  sfxa 
   Channel.of("j".."h","e".."b").branch { 
   one:(String) it>= (String) 610||(String) it< (String) 0 
   two:(String) it!= (String) 867||(String) it!= (String) "ywl" 
  }.set{namedchannel2} 
   namedchannel2 |  ml_twovars
 
 }