#!/usr/bin/env nextflow
process l {
input: 
val variable 

output:
val variable 
script: 
 template 'test_script.sh'
}

process eit_twovars{
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
num1=$variable
num2=$variable2
if ! [[ $variable =~ \$re ]] ; then
  num1=\$(printf "%d" "'$variable")
else
  num1=$variable
fi
if ! [[ $variable2 =~ \$re ]] ; then
  num2=\$(printf "%d" "'$variable2")
else
  num2=$variable2
 fi

# Perform addition of two variables
sum=\$((num1 + num2))

echo "Addition:"
echo "$variable + $variable2 = \$sum"

"""
}
workflow {
Channel.of("ze","yvab","z".."v",6..3).set{namedchannel1}
namedchannel1  |  l 
Channel.of(08,"tdg",7..8,"o".."g").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  eit_twovars

}