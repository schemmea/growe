package de.schemmea.ma

import com.pholser.junit.quickcheck.From
import de.schemmea.ma.generator.Configuration
import de.schemmea.ma.generator.TestMiniGenerator
import de.schemmea.ma.generator.WorkflowFileGenerator
import edu.berkeley.cs.jqf.fuzz.Fuzz
import edu.berkeley.cs.jqf.fuzz.JQF
import nextflow.Global
import nextflow.Session
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
        Test.setIteration(Test.getIteration() + 1); //for java debugging
        println Configuration.newline + "ITERATION " + Test.iteration + Configuration.newline
        println mini

    }

    @Fuzz
    public void testlauncher() {
        String falseyFile = "/home/alena/source/growe/src/main/resources/test/yesOrNo2.nf";

        String filename = "/home/alena/source/growe/src/main/resources/seeds/yesOrNo.nf";

        Launcher launcher1 = new Launcher().command('run', falseyFile)

        int status = launcher1.run()


        def sess = (Session) Global.getSession()
        if (sess != null) {
            sess.cleanup()
            sess.destroy()
        }
        //  Global.cleanUp()
        //plugins won't stop after sriptcompilation exception
        //   Plugins.stop()

        Launcher launcher2 = new Launcher().command('run', filename)

        int status2 = launcher2.run()
    }


    static long allmillis = 0;

    @Fuzz
    public void testtime() {

        String filename = "/home/alena/source/growe/src/main/resources/test/hello.nf";
        long millis = System.currentTimeMillis()
        Launcher launcher1 = new Launcher().command('run', filename, "-cache", "false")

        int status = launcher1.run()
        long millis2 = System.currentTimeMillis()
        def took = millis2 - millis
        allmillis += took
        iteration++

        def avg = allmillis / iteration
        println "iteration: " + iteration + " time: " + avg + " current: " + took + "(all)" + allmillis
    }

    @After
    public void cleanUp() {
        println("cleaning up $iteration")
        def sess = (Session) Global.getSession()
        if (sess != null) {
            sess.cleanup()
            sess.destroy()
        }
        Global.cleanUp()
        //plugins won't stop after sriptcompilation exception
        Plugins.stop()

    }

}

