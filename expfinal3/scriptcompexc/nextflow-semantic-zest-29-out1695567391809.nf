#!/usr/bin/env nextflow
process he {
input: 
val variable 

output:
val variable 
script: 
 template 'script9'
}

process d {
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
Channel.of(46,10,"nt",19).set{namedchannel1}
namedchannel1  |  he  |  d 
Channel.of(0296,9..5,"b".."z","j".."g").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}