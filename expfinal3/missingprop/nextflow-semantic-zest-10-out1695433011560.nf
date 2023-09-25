#!/usr/bin/env nextflow
process ykxvhpy {
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

process i {
input: 
val variable 

output:
val variable 
script: 
 template 'allocate_script1.txt'
}

process jix_twovars{
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

process in {
input: 
val variable 

output:
val variable 
script: 
 template 'script5'
}

process voacfn_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script2.txt'
}

process bngvfy_twovars{
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
workflow {
Channel.of(970648,"r".."s","i".."q",6..8).set{namedchannel1}
namedchannel1  |  i 
Channel.of("v".."a",31).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  voacfn_twovars |  bngvfy_twovars
 jix_twovars( ykxvhpy (namedchannel2.one),  in (namedchannel2.two))
}