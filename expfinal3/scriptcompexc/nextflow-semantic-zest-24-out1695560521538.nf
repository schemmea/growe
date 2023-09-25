#!/usr/bin/env nextflow
process yrh_twovars{
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

process ga_twovars{
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

process z {
input: 
val variable 

output:
val variable 
script: 
 template 'script2.sh'
}
workflow {
Channel.of(9..7,"i".."q","f",7..1,093799).set{namedchannel1}
namedchannel1  |  z 
Channel.of(32891,2..4,"f".."b","a".."v","bb").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  yrh_twovars |  ga_twovars

}