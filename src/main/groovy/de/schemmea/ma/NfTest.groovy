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

    static int getIteration() { return iteration; }

    static void setIteration(int value) { iteration = value; }

    @Before
    public void setup() {
    }


    @Fuzz
    public void testNFCommand(@From(GroovyGenerator.class) String[] command) {
        NfTest.setIteration(NfTest.getIteration() + 1); //for java debugging
        println Configuration.newline + "ITERATION " + NfTest.iteration + Configuration.newline
        println command

        try {

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
                Assume.assumeTrue(status == 0)
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Throwable t) {
            Assume.assumeNoException(t);
        } finally {

        }

    }


    @Fuzz
    public void testTest(@From(WorkflowFileGenerator.class) File inputFile) {
        NfTest.setIteration(NfTest.getIteration() + 1); //for java debugging
        println Configuration.newline + "ITERATION " + NfTest.iteration + Configuration.newline

        try {
            String filename = inputFile.getAbsoluteFile();
            String[] orig_args2 = new String[]{"run", filename};
            def args2 = [filename]

            int status = new Launcher().command(orig_args2).run();
            Assume.assumeTrue(status == 0)
            Assume.assumeTrue(status == 0)

        } catch (Exception ex) {
            println "EXCEPTION " + ex.getMessage()
            Assume.assumeNoException(ex)
        } catch (Error e) {
            println "ERROR " + e.getMessage()
            println e.getCause()
            Assume.assumeNoException(e)

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

