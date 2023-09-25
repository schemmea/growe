#!/usr/bin/env nextflow
process f {
input: 
val variable 

output:
val variable 
script: 
 template 'script2.sh'
}

process v {
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

process b {
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

process r {
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

process fz_twovars{
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

process vf_twovars{
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
workflow {
Channel.of(9..4,"s",5..9,8..0,"x").set{namedchannel1}
namedchannel1  |  v  |  r 
Channel.of(98,9..3).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  vf_twovars
 fz_twovars( f (namedchannel2.one),  b (namedchannel2.two))
}