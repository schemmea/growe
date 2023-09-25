#!/usr/bin/env nextflow
process k {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

  # Loop to list running processes every 3 seconds for 10 iterations
  for ((i=0; i<4; i++))
  do
      echo "Running Processes - Iteration \$i"
      ps aux | grep "$variable"
  done

"""
}

process o {
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
workflow {
Channel.of("r".."s",08,81).set{namedchannel1}
namedchannel1  |  k  |  o 
Channel.of(9..5,"bcqvqa").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}