#!/usr/bin/env nextflow
process zu {
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

process bvvd {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}

process wulp {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash
echo Foo $variable
"""
}

process d {
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

process xc_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash


# Perform comparison of two variables
if [[ variable -gt variable2 ]]; then
    echo "$variable is greater than $variable2"
elif [[ variable -lt variable2 ]]; then
    echo "$variable is less than $variable2"
else
    echo "$variable is equal to $variable2"
fi
"""
}

process ol_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
"""
#!/bin/bash

# Concatenate two strings
concatenated="${variable}_${variable2}"

echo "String Concatenation:"
echo "$variable + $variable2 = \$concatenated"
"""
}

process me {
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

process d {
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
Channel.of(8..3,"m".."k","z".."a",4..1,6..5,"u".."g").set{namedchannel1}
namedchannel1  |  bvvd  |  d  |  me  |  d 
Channel.of(5..4,"g".."h","u".."c",14).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ol_twovars
 xc_twovars( zu (namedchannel2.one),  wulp (namedchannel2.two))
}