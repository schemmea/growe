#!/usr/bin/env nextflow
process b {
input: 
val variable 

output:
val variable 
script: 
"""
re='^[0-9]+\$'
upper=100
if ! [[ $variable =~ \$re ]] ; then
  num=\$(printf "%d" "'$variable")
  #echo "$variable is not number char: \$num"
  max=\$(( num > upper ? upper : num ))
  max=\$((max/10))
  echo "conv \$max - \$max  $variable"
  for (( c=0; c<=\$max; c++ )); do
    echo "fraction of \$num \$c"
    sleep 1 &
  done
else
  max=\$(( $variable > upper ? upper : $variable ))
  max=\$((max/100))
  for i in {0..\$max} ; do
    echo "fraction of $variable \$i of \$max"
    sleep 1 &
  done
fi

"""
}

process occh {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}

process xy {
input: 
val variable 

output:
val variable 
script: 
"""
#!/bin/bash
echo Bar $variable
"""
}

process xd {
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
workflow {
Channel.of("wuamipt",09).set{namedchannel1}
namedchannel1  |  b  |  occh  |  xy  |  xd 
Channel.of(80,"f",76,1..5,9..5).multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}