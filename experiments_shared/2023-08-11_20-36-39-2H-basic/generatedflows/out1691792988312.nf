#!/usr/bin/env nextflow 
 process ortslfa{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script5' 
 } 
  
 process cf_twovars{ 
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
  
 process pax{ 
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
  
 process ykb{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo 'Hello $variable' > file.out 
 """ 
 } 
  
 process ay{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'test_script.sh' 
 } 
  
 process js{ 
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
  
 process mk{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script6' 
 } 
  
 process ke{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'allocate_script1.txt' 
 } 
  
 process sn{ 
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
  
 process ww{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'test_script.sh' 
 } 
  
 process in{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo 'Hello $variable' > file.out 
 """ 
 } 
  workflow { 
   Channel.fromFilePairs("data/*{1,2}*.fa").set{namedchannel1} 
   namedchannel1 |  ortslfa |  pax |  ykb |  ay |  js |  mk |  ke |  sn |  ww |  in 
   Channel.of(0..0,2..2).branch { 
   one:(String) it>= (String) 6||(String) it< (String) 30 
   two:(String) it!= (String) 597||(String) it> (String) 0||(String) it< (String) 5 
  }.set{namedchannel2} 
   namedchannel2 |  cf_twovars
 
 }