package de.schemmea.ma

import com.pholser.junit.quickcheck.From
import de.schemmea.ma.generator.Configuration
import de.schemmea.ma.generator.TestMiniGenerator
import de.schemmea.ma.generator.WorkflowFileGenerator
import edu.berkeley.cs.jqf.fuzz.Fuzz
import edu.berkeley.cs.jqf.fuzz.JQF
import nextflow.cli.CmdRun
import nextflow.cli.Launcher
import nextflow.plugin.Plugins
import org.junit.After
import org.junit.Assume
import org.junit.Before
import org.junit.runner.RunWith

@RunWith(JQF.class)
public class Test {


    static int iteration = 0;

    static int getIteration() { return iteration; }

    static void setIteration(int value) { iteration = value; }

    @Before
    public void setup() {
    }


    @Fuzz
    public void testMini(@From(TestMiniGenerator.class) String mini) {
        Test.setIteration(Test.getIteration()+1); //for java debugging
        println Configuration.newline + "ITERATION " + Test.iteration + Configuration.newline
        println mini

    }



}

