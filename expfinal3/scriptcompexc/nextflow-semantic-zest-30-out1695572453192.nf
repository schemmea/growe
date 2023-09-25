#!/usr/bin/env nextflow
process ej {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Check user information and perform action based on the random variable
if [[ "$variable" =~ ^[0-9]+\$ ]]; then
    # Print specific user information
    echo "User Information - $variable"
    id "$variable"
else
    # Print all user information
    echo "All User Information"
    cat /etc/passwd
fi
"""
}

process jfb_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process injuse {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

# Print memory usage

echo "Memory Usage"
free -m | grep "$variable"

"""
}

process udz_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script3.txt'
}

process ab {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}

process qr_twovars{
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

process yn {
input: 
val variable 

output:
val variable 
script: 
 template 'script2.sh'
}

process d {
input: 
val variable 

output:
val variable 
script: 
 template 'script9'
}
workflow {
Channel.of(09,"g".."y").set{namedchannel1}
namedchannel1  |  injuse  |  yn  |  d 
Channel.of(1..8,4..0).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  udz_twovars |  qr_twovars
 jfb_twovars( ej (namedchannel2.one),  ab (namedchannel2.two))
}