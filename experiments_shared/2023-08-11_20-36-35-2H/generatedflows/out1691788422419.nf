#!/usr/bin/env nextflow 
 process of{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 re='^[0-9]+\$'
upper=100
if ! [[ $variable =~ \$re ]] ; then
  num=\$(printf "%d" "'$variable")
  #echo "$variable is not number char: \$num"
  max=\$(( num > upper ? upper : num ))
  max=\$((max/10))
  echo "conv \$max - \$max  $variable"
  for (( c=0; c<=\$max; c++ )); do
    echo "fraction of \$num \$c"
    sleep 1 &
  done
else
  max=\$(( $variable > upper ? upper : $variable ))
  max=\$((max/100))
  for i in {0..\$max} ; do
    echo "fraction of $variable \$i of \$max"
    sleep 1 &
  done
fi
 
 """ 
 } 
  
 process of{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script6' 
 } 
  
 process ebge{ 
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
  
 process qo{ 
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
  
 process pxyrsuk{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash


# Check CPU information and perform action based on the random parameter
if [[ "$variable" =~ ^[0-9]+\$ ]]; then
    # Print CPU flags information
    echo "CPU Flags Information"
    cat /proc/cpuinfo | grep "flags"
else
    # Print CPU model information
    echo "CPU Model Information"
    cat /proc/cpuinfo | grep "model name"
fi 
 """ 
 } 
  workflow { 
   Channel.of("h".."r","f".."z",0..0).set{namedchannel1} 
   namedchannel1 |  of |  of |  ebge |  qo |  pxyrsuk 
   Channel.of(4..0,"l".."g").branch { 
   one:(String) it< (String) 720 
   two:(String) it< (String) "smqoc"||(String) it<= (String) "sibkxc" 
  }.set{namedchannel2} 
   namedchannel2 
 }