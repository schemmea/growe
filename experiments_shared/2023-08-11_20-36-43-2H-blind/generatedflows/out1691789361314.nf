#!/usr/bin/env nextflow 
 process jgli_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script10.txt' 
 } 
  
 process rc{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'bar.txt' 
 } 
  
 process hk{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script6' 
 } 
  
 process sv_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
 """ 
 #!/bin/bash

# Concatenate two strings
concatenated="${variable}_${variable2}"

echo "String Concatenation:"
echo "$variable + $variable2 = \$concatenated" 
 """ 
 } 
  
 process ayml_twovars{ 
  debug true 
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
  
 process rc{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
{
  # Loop to display file permissions every second for 5 seconds
  for ((i=0; i<5; i++))
  do
      echo "File Permissions - Iteration \$i"
      if [[ "$variable" =~ ^[0-9]+\$ ]]; then
          ls -l "$variable"
      else
         ls -l
      fi
  done
} || {
  echo "error"
} 
 """ 
 } 
  
 process swd{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
 """ 
 #!/bin/bash
echo 'Hello $variable' > file.out 
 """ 
 } 
  
 process drjcpqorqlrh{ 
  debug true 
  input: 
   val variable 
  
  output: 
   val variable 
  script: 
   template 'script 10' 
 } 
  
 process mezj_twovars{ 
  debug true 
  input: 
   val variable 
   val variable2 
  
  output: 
   val variable 
   val variable2 
  script: 
   template 'twovars_script10.txt' 
 } 
  workflow { 
   Channel.fromFilePairs("data/*{1,2}*.csv").set{namedchannel1} 
   namedchannel1 |  hk |  swd |  drjcpqorqlrh 
   Channel.of(9,50,"m".."h","f".."t",0..0).branch { 
   one:(String) it!= (String) 0||(String) it> (String) 2 
   two:(String) it< (String) 0||(String) it>= (String) 48||(String) it!= (String) "dqp" 
  }.set{namedchannel2} 
   namedchannel2 |  sv_twovars |  ayml_twovars |  mezj_twovars
 jgli_twovars( rc(namedchannel2.one),  rc(namedchannel2.two)) 
 }