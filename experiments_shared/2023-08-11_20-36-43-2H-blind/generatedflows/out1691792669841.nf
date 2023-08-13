#!/usr/bin/env nextflow 
 process knkc_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script9.txt' 
 } 
  
 process zop_twovars{ 
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
  
 process tt_twovars{ 
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
  
 process tt_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script5.txt' 
 } 
  
 process nxr_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script9.txt' 
 } 
  
 process ugxl_twovars{ 
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
   Channel.fromPath("data/*.txt").set{namedchannel1} 
   namedchannel1 
   Channel.of(1,"lz").branch { 
   one:(String) it> (String) "ls" 
   two:(String) it<= (String) 5425 
  }.set{namedchannel2} 
   namedchannel2 |  knkc_twovars |  zop_twovars |  tt_twovars |  tt_twovars |  nxr_twovars |  ugxl_twovars
 
 }