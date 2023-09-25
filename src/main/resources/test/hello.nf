 #!/usr/bin/env nextflow

    nextflow.enable.dsl=2

    process foo {
        input:
            val cheers
        output:
            path '../../../foo.txt'
        shell:
            '''
            # nextflow will create working directories for each task
            #    where this file would go
            echo !{cheers} >> ../../../foo.txt
            '''
    }

    process bar {
        input:
            path x
        exec:
            x.eachLine{ line ->
                println line
            }
    }
    workflow {
        channel.of('Hello world!', 'Hi!', 'Bonjour!') | foo | bar
    }