#!/usr/bin/env nextflow
process lucxh_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script4.txt'
}

process i {
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

process tysb_twovars{
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
workflow {
Channel.of(5130,0087,578).set{namedchannel1}
namedchannel1  |  i 
Channel.of("b","e".."y",2110746).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  lucxh_twovars |  tysb_twovars

}