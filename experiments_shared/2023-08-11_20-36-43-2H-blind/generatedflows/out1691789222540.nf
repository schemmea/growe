#!/usr/bin/env nextflow 
 process in{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script9' 
 } 
  
 process lumv_twovars{ 
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
  
 process lsn{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script 10' 
 } 
  
 process dg{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
    # Check network interface information and perform action based on the random parameter
    if [[ "$variable" =~ ^[0-9]+\$ ]]; then
        # Print specific network interface information
        echo "Network Interface Information - $variable"
        ip link show &&
    else
        # Print all network interface information
        echo "All Network Interface Information"
        ip -$variable &&
    fi
} || {
  echo "error"
} 
 """ 
 } 
  
 process ji{ 
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
  workflow { 
   Channel.of("ei",0..0).set{namedchannel1} 
   namedchannel1 |  in |  lsn |  dg |  ji 
   Channel.of("z".."k","p".."f",31).branch { 
   one:(String) it!= (String) 1||(String) it>= (String) "ih"||(String) it>= (String) "tiuv"||(String) it< (String) "hl"||(String) it>= (String) "dz"||(String) it>= (String) 0 
   two:(String) it<= (String) "mu" 
  }.set{namedchannel2} 
   namedchannel2 |  lumv_twovars
 
 }