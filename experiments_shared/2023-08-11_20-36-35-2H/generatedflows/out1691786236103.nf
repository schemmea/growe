#!/usr/bin/env nextflow 
 process qbu{ 
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
  
 process ex{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script9' 
 } 
  
 process bwmi{ 
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
   Channel.of(9..0,655).set{namedchannel1} 
   namedchannel1 |  qbu |  ex |  bwmi 
   Channel.of("v".."s","sp","k".."t",2..1).branch { 
   one:(String) it>= (String) "zb"||(String) it< (String) 78 
   two:(String) it<= (String) "qol"||(String) it!= (String) 0||(String) it<= (String) "wo"||(String) it>= (String) "ja"||(String) it> (String) 1||(String) it<= (String) "vz" 
  }.set{namedchannel2} 
   namedchannel2 
 }