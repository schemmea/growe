#!/usr/bin/env nextflow 
 process cklk{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash

# Loop to display system load every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "System Load - Iteration \$i"
    uptime | grep "$variable"
done 
 """ 
 } 
  
 process he_twovars{ 
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

re='^[0-9]+\$'
num1=$variable
num2=$variable2
if ! [[ $variable =~ \$re ]] ; then
  num1=\$(printf "%d" "'$variable")
else
  num1=$variable
fi
if ! [[ $variable2 =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable2")
else
  num2=$variable2
 fi

# Perform addition of two variables
sum=\$((num1 + num2))

echo "Addition:"
echo "$variable + $variable2 = \$sum"
 
 """ 
 } 
  
 process fd{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'yesOrNo.nf' 
 } 
  
 process dwacom_twovars{ 
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

re='^[0-9]+\$'
num=100
num2=1024
if ! [[ $variable =~ \$re ]] ; then
  num=\$(printf "%d" "'$variable")
else
  num=$variable
fi
if ! [[ $variable2 =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable")
else
  num2=$variable2
fi
# Calculate the number of bytes for the desired memory consumption
memory_size=\$((1024 * num2 * num))  # 100 MB

# Allocate memory by creating a large array
data=(\$(dd if=/dev/zero bs="\$memory_size" count=1))

# Perform some operations using the allocated memory
# ...
# Your code here
value1=\$((num / num2))

# Release the allocated memory
unset data
echo "$variable * $variable2 = \$value1"

 
 """ 
 } 
  
 process kndbyoqv{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script 8.sh' 
 } 
  
 process dg{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script1' 
 } 
  
 process gjqm{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done
} || {
  echo "error"
}
 
 """ 
 } 
  workflow { 
   Channel.of("a".."l",2..1).set{namedchannel1} 
   namedchannel1 |  fd |  dg |  gjqm 
   Channel.of("ok",0..0,0..0,"y".."b").branch { 
   one:(String) it!= (String) 40 
   two:(String) it<= (String) 5 
  }.set{namedchannel2} 
   namedchannel2 |  dwacom_twovars
 he_twovars( cklk(namedchannel2.one),  kndbyoqv(namedchannel2.two)) 
 }