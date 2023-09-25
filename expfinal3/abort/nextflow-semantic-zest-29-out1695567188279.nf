#!/usr/bin/env nextflow
process kx_twovars{
input:
val variable
val variable2 

output:
val variable
val variable2
script:
template 'twovars_script5.txt'
}

process gimt {
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

process yl {
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

process ve_twovars{
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

process f {
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

process aj {
input: 
val variable 

output:
val variable 
script: 
 template 'script 10'
}
workflow {
Channel.of(2..4,"y").set{namedchannel1}
namedchannel1  |  yl  |  aj 
Channel.of(9..3,272).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  ve_twovars
 kx_twovars( gimt (namedchannel2.one),  f (namedchannel2.two))
}