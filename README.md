# growe

This is the reference project used in the Master Thesis by Alena Schemmert at Humboldt Universität zu Berlin 2023.

## used libraries
The implementation reuses [GramTest](https://github.com/codelion/gramtest) and is therefore published under Apache License 2.

Thhe source code was used as is with a small modification that allows the class GeneratorVisitor to be controlled via JQF by using the quickcheck SourceOfRandomness instead of JDK Random. 


## Fuzz testing

use `./gradlew build` to create JAR
In same directory as this repo you need to have a clone of the JQF repo
use scripts/run_jqf_all or similar to start fuzz testing 
