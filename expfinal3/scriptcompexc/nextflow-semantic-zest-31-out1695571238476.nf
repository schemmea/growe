#!/usr/bin/env nextflow
process cqdnpd_twovars{
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

process zik_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process k {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}

process rx {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done


"""
}

process k {
input: 
val variable 

output:
val variable 
script: 
 template 'script3'
}

process c {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

echo $variable

"""
}
workflow {
Channel.of(1..5,9..4,"tc",6..5).set{namedchannel1}
namedchannel1  |  rx  |  c 
Channel.of("wru","b".."u").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  zik_twovars
 cqdnpd_twovars( k (namedchannel2.one),  k (namedchannel2.two))
}