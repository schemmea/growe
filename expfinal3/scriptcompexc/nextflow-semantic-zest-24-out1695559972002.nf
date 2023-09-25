#!/usr/bin/env nextflow
process p {
input: 
val variable 

output:
val variable 
script: 
 template 'script7.txt'
}

process o {
input: 
val variable 

output:
val variable 
script: 
 template 'bar.txt'
}

process ulf {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash


  # Loop to display system uptime every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "System Uptime - Iteration \$i"
      uptime | grep "$variable"
  done

"""
}

process izwrjh {
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

# Loop to check file size every second for 5 seconds
for ((i=0; i<5; i++))
do
    echo "file - Iteration \$i"
    du -a "$variable"
done


"""
}

process x {
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
Channel.of("f".."n",094).set{namedchannel1}
namedchannel1  |  p  |  o  |  ulf  |  izwrjh  |  v  |  x 
Channel.of("t".."f",4..1,"q".."w").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}