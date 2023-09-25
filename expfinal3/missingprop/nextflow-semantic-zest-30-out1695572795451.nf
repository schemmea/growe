#!/usr/bin/env nextflow
process wl_twovars{
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
value1=\$((num % num2))

echo "$variable * $variable2 = \$value1"

# Release the allocated memory
unset data

"""
}

process in {
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
workflow {
Channel.of(7..5,"n".."q").set{namedchannel1}
namedchannel1  |  in 
Channel.of("n".."s",0..9).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  wl_twovars

}