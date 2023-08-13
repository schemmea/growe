#!/usr/bin/env nextflow 
 process in{ 
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
  
 process siolk_twovars{ 
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
  
 process ca_twovars{ 
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
value1=\$((num * num2))

# Release the allocated memory
unset data
echo "$variable * $variable2 = \$value1"

 
 """ 
 } 
  
 process hrr{ 
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
  
 process qq_twovars{ 
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

# Perform subtraction of two variables
re='^[0-9]+\$'
num1=$variable
num2=$variable2
if ! [[ $variable =~ \$re ]] ; then
  num1=\$(printf "%d" "'$variable")
fi
if ! [[ $variable =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable2")
fi
difference=\$((num1 - num2))

echo "Subtraction:"
echo "$variable (\$num1) - $variable2 (\$num1) = \$difference"
 
 """ 
 } 
  workflow { 
   Channel.of(0..0,"dlthaobms").set{namedchannel1} 
   namedchannel1 |  in |  hrr 
   Channel.of(0,"o".."g","nrq").branch { 
   one:(String) it> (String) 0 
   two:(String) it<= (String) 6||(String) it<= (String) "zqo"||(String) it>= (String) "denjk"||(String) it<= (String) 40||(String) it>= (String) "rou" 
  }.set{namedchannel2} 
   namedchannel2 |  siolk_twovars |  ca_twovars |  qq_twovars
 
 }