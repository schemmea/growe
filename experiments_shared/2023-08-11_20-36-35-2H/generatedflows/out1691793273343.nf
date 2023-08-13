#!/usr/bin/env nextflow 
 process jhhuye_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script7.txt' 
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

{
  # Loop to display system uptime every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "System Uptime - Iteration \$i"
      uptime | grep "$variable"
  done
} || {
  echo "error"
} 
 """ 
 } 
  
 process kq_twovars{ 
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
  
 process at{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'multi_script.sh' 
 } 
  
 process xzf_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script7.txt' 
 } 
  
 process sox{ 
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
  workflow { 
   Channel.of(8..4,"w".."a").set{namedchannel1} 
   namedchannel1 |  at 
   Channel.of("n".."t","d".."h").branch { 
   one:(String) it> (String) "aipk" 
   two:(String) it< (String) 90 
  }.set{namedchannel2} 
   namedchannel2 |  kq_twovars |  xzf_twovars
 jhhuye_twovars( if(namedchannel2.one),  sox(namedchannel2.two)) 
 }