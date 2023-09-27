#!/usr/bin/env nextflow
process wx_twovars{
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

process t {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash
echo Bar $variable
"""
}

process dye_twovars{
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

process c {
input: 
val variable 

output:
val variable 
script: 
 template 'script9'
}

process r {
input: 
val variable 

output:
val variable 
script: 
 template 'script7.txt'
}
workflow {
Channel.of(5042,"s".."j").set{namedchannel1}
namedchannel1  |  c 
Channel.of(0..2,"w".."j").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  dye_twovars
 wx_twovars( t (namedchannel2.one),  r (namedchannel2.two))
}