#!/usr/bin/env nextflow
process s {
input: 
val variable 

output:
val variable 
script: 
 template 'script7.txt'
}

process reu_twovars{
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
Channel.of("g".."b","w".."w").set{namedchannel1}
namedchannel1  |  s 
Channel.of(097,2..0,4..9,"c".."h",73,"e".."d").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2  |  reu_twovars

}