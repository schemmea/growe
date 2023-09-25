#!/usr/bin/env nextflow
process wjqulqg {
input: 
val variable 

output:
val variable 
script: 
 template 'shell-script.txt'
}

process c {
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
Channel.of("h".."p",008,650).set{namedchannel1}
namedchannel1  |  wjqulqg  |  c 
Channel.of(4..7,"b").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}