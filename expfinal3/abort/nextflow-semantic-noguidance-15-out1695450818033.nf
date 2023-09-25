#!/usr/bin/env nextflow
process iyr {
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

process w {
input: 
val variable 

output:
val variable 
script: 
"""
#!/usr/bin/env nextflow
/*
 * Copyright 2020-2022, Seqera Labs
 * Copyright 2013-2019, Centre for Genomic Regulation (CRG)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
workflow {
  channel.of(1,2) | yesOrNo
}

process yesOrNo {
    debug true

    input:
    val x

    script:
    if( x == 1 ) {
        'echo YES'
    }
    else {
        'echo NO'
    }

}

"""
}

process p {
input: 
val variable 

output:
val variable 
script: 
 template 'yesOrNo.nf'
}
workflow {
Channel.of("q".."u",9..7).set{namedchannel1}
namedchannel1  |  iyr  |  w  |  p 
Channel.of("o".."f","q".."n").multiMap { it -> one: two: it }.set{namedchannel2}
namedchannel2 
}