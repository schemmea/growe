#!/usr/bin/env nextflow
process w {
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

process i {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash

  # Loop to list running processes every 3 seconds for 10 iterations
  for ((i=0; i<4; i++))
  do
      echo "Running Processes - Iteration \$i"
      ps aux | grep "$variable"
  done

"""
}

process w {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash


# Check CPU information and perform action based on the random parameter
if [[ "$variable" =~ ^[0-9]+\$ ]]; then
    # Print CPU flags information
    echo "CPU Flags Information"
    cat /proc/cpuinfo | grep "flags"
else
    # Print CPU model information
    echo "CPU Model Information"
    cat /proc/cpuinfo | grep "model name"
fi
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
workflow {
Channel.of(0..5,2..3,"f".."g","y","b".."b").set{namedchannel1}
namedchannel1  |  w  |  i  |  w  |  r 
Channel.of(4..2,"c".."r").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}