#!/usr/bin/env nextflow
process zz_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process m {
input: 
val variable 

output:
val variable 
script: 
 template 'bar.txt'
}

process gyk_twovars{
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

process tpdx_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script7.txt'
}

process m {
input: 
val variable 

output:
val variable 
script: 
 template 'script7.txt'
}

process ju {
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

process qrpkq_twovars{
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
Channel.of("i".."j",5..1,"rqxe","j".."y").set{namedchannel1}
namedchannel1  |  m 
Channel.of(1..8,"wye").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  gyk_twovars |  tpdx_twovars |  qrpkq_twovars
 zz_twovars( m (namedchannel2.one),  ju (namedchannel2.two))
}