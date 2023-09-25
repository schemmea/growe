#!/usr/bin/env nextflow
process u {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process h {
input: 
val variable 

output:
val variable 
script: 
"""
re='^[0-9]+\$'
upper=100
if ! [[ $variable =~ \$re ]] ; then
   #echo "$variable is not number"
   num=\$(printf "%d" "'$variable")

   max=\$(( num > upper ? upper : num ))
   max=\$((max/100))
   echo "converted \$max - \$num  $variable"
   sleep \$max
else
  max=\$(( $variable > upper ? upper : $variable ))
  max=\$((max/100))
  echo "converted \$max - $variable"
  sleep \$max
fi

"""
}

process vmroo {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process h {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

    # Check network interface information and perform action based on the random parameter
    if [[ "$variable" =~ ^[0-9]+\$ ]]; then
        # Print specific network interface information
        echo "Network Interface Information - $variable"
        ip link show
    else
        # Print all network interface information
        echo "All Network Interface Information"
        ip -$variable
    fi

"""
}

process uyy {
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

process czj {
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

process vj {
input: 
val variable 

output:
val variable 
script: 
 template 'script1'
}
workflow {
Channel.of("r".."b","g").set{namedchannel1}
namedchannel1  |  u  |  h  |  vmroo  |  h  |  uyy  |  czj  |  vj 
Channel.of("z".."s",6..4).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}