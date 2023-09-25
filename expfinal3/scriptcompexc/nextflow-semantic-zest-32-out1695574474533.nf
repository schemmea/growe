#!/usr/bin/env nextflow
process dr {
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

process f {
input: 
val variable 

output:
val variable 
script: 
 template 'allocate_script1.txt'
}

process f {
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
workflow {
Channel.of(2..0,71).set{namedchannel1}
namedchannel1  |  dr  |  f  |  f 
Channel.of("z".."y","e".."p","v","c".."y").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}