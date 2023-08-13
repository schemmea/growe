#!/usr/bin/env nextflow 
 process run{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script7.txt' 
 } 
  
 process vqd{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo "Hello $variable !{family} !{params.data}" > file.out 
 """ 
 } 
  
 process veea{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo Foo $variable 
 """ 
 } 
  
 process me{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'multi_script.sh' 
 } 
  
 process afr_twovars{ 
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
  workflow { 
   Channel.fromPath("data/*.csv").set{namedchannel1} 
   namedchannel1 |  run |  vqd |  veea |  me 
   Channel.of(0..0,"y".."a").branch { 
   one:(String) it!= (String) "ylxfk" 
   two:(String) it>= (String) "lvihkww"||(String) it!= (String) "qc" 
  }.set{namedchannel2} 
   namedchannel2 |  afr_twovars
 
 }