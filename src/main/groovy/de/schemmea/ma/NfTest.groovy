package de.schemmea.ma

import com.pholser.junit.quickcheck.From
import com.pholser.junit.quickcheck.generator.java.lang.StringGenerator
import de.schemmea.ma.generator.Configuration
import de.schemmea.ma.generator.NextflowCommandGenerator
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

import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths

import static de.schemmea.ma.generator.Util.getFileName

@RunWith(JQF.class)
public class NfTest {


    static int iteration = 0;


    @Before
    public void setup() {
    }


    @Fuzz
    public void testNFCommand(@From(GroovyGenerator.class) String[] command) {

        println Configuration.newline + "ITERATION " + ++iteration + Configuration.newline
        println command

        if (command[0] == "run") {
            //avoid try catch (Throwable) in Launcher
            Launcher launcher = new Launcher().command(command)

            CmdRun myRunner = new CmdRun();
            myRunner.setArgs(command.tail().toList());
            myRunner.setLauncher(launcher);

            myRunner.run();

        } else {
            int status = new Launcher().command(command).run();
            println "status " + status
            Assume.assumeTrue(status==0)
        }
    }


    @Fuzz
    public void testTest(@From(StringGenerator.class) String inputFile) {
        print Configuration.newline + "ITERATION " + ++iteration + Configuration.newline

        try {
            String filename = "/home/alena/source/ma_test2/src/main/resources/test/out1691656718885.nf";
            String[] orig_args2 = new String[]{"run", filename};
            def args2 = [filename]

            int status = new Launcher().command(orig_args2).run();
            Assume.assumeTrue(status==0)

        } catch (Exception ex) {
            println "EXCEPTION"
            ex.printStackTrace()

        } catch (Error e) {
            println "ERROR"
            println e.getCause()
        }
        //nextflow clean ? <
    }


    @After
    public void cleanUp() {
        //plugins won't stop after sriptcompilation exception
        Plugins.stop()

        //nextflow clean -f
       // this makes interesting things
        // int status = new Launcher().command(new String[]{"clean","-f"}).run();
    }

}

