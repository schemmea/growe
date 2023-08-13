#!/usr/bin/env nextflow 
 process xvf{ 
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
  
 process vg{ 
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
  
 process lui{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash

re='^[0-9]+\$'
num=100
if ! [[ $variable =~ \$re ]] ; then
  num=\$(printf "%d" "'ewr")
fi

# Calculate the number of bytes for the desired memory consumption
memory_size=\$((1024 * 1024 * num))  # 100 MB

# Allocate memory by creating a large array
data=(\$(dd if=/dev/zero bs="\$memory_size" count=1))

# Perform some operations using the allocated memory
# ...
# Your code here

# Release the allocated memory
unset data
 
 """ 
 } 
  
 process uczbyk_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script10.txt' 
 } 
  
 process mcl_twovars{ 
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

# Compare the lengths of two strings
length1=\${#$variable}
length2=\${#$variable2}

if [[ length1 -gt length2 ]]; then
    echo "Length of $variable is greater than $variable2"
elif [[ length1 -lt length2 ]]; then
    echo "Length of $variable is less than $variable2"
else
    echo "Length of $variable is equal to $variable2"
fi
 
 """ 
 } 
  workflow { 
   Channel.of("o".."k",0..0,"jf").set{namedchannel1} 
   namedchannel1 |  vg 
   Channel.of(0..2,"v".."o").branch { 
   one:(String) it>= (String) 40||(String) it<= (String) "gdbed" 
   two:(String) it<= (String) "gjo" 
  }.set{namedchannel2} 
   namedchannel2 |  mcl_twovars
 uczbyk_twovars( xvf(namedchannel2.one),  lui(namedchannel2.two)) 
 }