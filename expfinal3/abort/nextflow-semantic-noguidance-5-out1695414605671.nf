#!/usr/bin/env nextflow
process c {
input: 
val variable 

output:
val variable 
script: 
 template 'script 8.sh'
}

process v {
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
workflow {
Channel.of(3..3,"n".."k","f".."w").set{namedchannel1}
namedchannel1  |  c  |  v 
Channel.of(1..5,"p".."v").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}