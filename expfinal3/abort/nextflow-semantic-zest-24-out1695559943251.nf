#!/usr/bin/env nextflow
process wr_twovars{
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

process tnk {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}

process uoxf_twovars{
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

process lxzjp {
input: 
val variable 

output:
val variable 
script: 
 template 'multi_script.sh'
}

process tf {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}

process c {
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

process ff_twovars{
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
workflow {
Channel.of("q".."f","hoql").set{namedchannel1}
namedchannel1  |  lxzjp  |  c 
Channel.of("gncw","h".."g",9..5).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  uoxf_twovars |  ff_twovars
 wr_twovars( tnk (namedchannel2.one),  tf (namedchannel2.two))
}