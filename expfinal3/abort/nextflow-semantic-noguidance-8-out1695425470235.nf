#!/usr/bin/env nextflow
process n {
input: 
val variable 

output:
val variable 
script: 
 template 'script6'
}

process f {
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
workflow {
Channel.of("f".."z","z".."f",2..0,6..3,"x".."s").set{namedchannel1}
namedchannel1  |  n  |  f 
Channel.of(0..9,"g".."v").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}