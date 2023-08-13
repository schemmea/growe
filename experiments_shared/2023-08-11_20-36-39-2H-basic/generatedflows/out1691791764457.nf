#!/usr/bin/env nextflow 
 process yg_twovars{ 
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
  
 process dte_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script2.txt' 
 } 
  
 process aqvu{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'test_script.sh' 
 } 
  
 process gcufz{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'multi_script.sh' 
 } 
  
 process ja_twovars{ 
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
  
 process ms{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script9' 
 } 
  
 process fogk_twovars{ 
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
  
 process ms{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
  # Loop to list running processes every 3 seconds for 10 iterations
  for ((i=0; i<4; i++))
  do
      echo "Running Processes - Iteration \$i"
      ps aux | grep "$variable" &&
  done
} || {
  echo "error"
} 
 """ 
 } 
  
 process lgp{ 
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
   Channel.of("n".."g",39).set{namedchannel1} 
   namedchannel1 |  gcufz |  ms |  lgp 
   Channel.of("r".."h",0,"g".."n","n".."p","s".."x",0).branch { 
   one:(String) it< (String) "uz" 
   two:(String) it!= (String) 425 
  }.set{namedchannel2} 
   namedchannel2 |  dte_twovars |  ja_twovars |  fogk_twovars
 yg_twovars( aqvu(namedchannel2.one),  ms(namedchannel2.two)) 
 }