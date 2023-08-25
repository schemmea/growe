package de.schemmea.ma

import com.pholser.junit.quickcheck.From
import com.pholser.junit.quickcheck.generator.java.lang.StringGenerator
import de.schemmea.ma.generator.Configuration
import de.schemmea.ma.generator.ContentGenerator
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
    public void debugTest() {
        NfTest.setIteration(NfTest.getIteration() + 1); //for java debugging
        println Configuration.newline + "ITERATION " + NfTest.iteration + Configuration.newline

        try {
            String filename = "/home/alena/source/growe/src/main/resources/test/test.nf";
            String[] orig_args2 = new String[]{"run", filename};
            def args2 = [filename]

            int status = new Launcher().command(orig_args2).run();
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


    @Fuzz
    public void testNFCommand(@From(NextflowCommandGenerator.class) String[] command) {
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

    private void serializeInputStream(InputStream instream, String filename) throws IOException {
        Path path = Paths.get(filename);
        try (BufferedWriter out = Files.newBufferedWriter(path)) {
            int b;
            while ((b = instream.read()) != -1) {
                out.write(b);
            }
        }
    }

    @Fuzz
    public void testAFL(InputStream inputStream) throws IOException {
        /*
         * install afl
         * https://medium.com/@ayushpriya10/fuzzing-applications-with-american-fuzzy-lop-afl-54facc65d102
         * https://www.dannyvanheumen.nl/post/java-fuzzing-with-afl-and-jqf/
         */
        String filename = getFileName();
        try {
            serializeInputStream(inputStream, filename);

            List<String> args2 = List.of(filename);
            String[] orig_args2 = new String[]{"run", filename};

            Launcher launcher = new Launcher().command(orig_args2);//.run();

            CmdRun myRunner = new CmdRun();
            myRunner.setArgs(args2);
            myRunner.setLauncher(launcher);

            myRunner.run();
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Throwable t) {
            Assume.assumeNoException(t);
        } finally {

            //instead of @After
            Plugins.stop();
            Files.delete(Paths.get(filename));
            //nextflow clean -f does not work?!
            //  int status = new Launcher().command(new String[]{"clean", "-f"}).run();
        }
    }


    @Fuzz
    public void testFile(@From(WorkflowFileGenerator) File inputFile) {
        NfTest.setIteration(NfTest.getIteration() + 1); //for java debugging
        println Configuration.newline + "ITERATION " + NfTest.iteration + Configuration.newline

        try {
            String filename = inputFile.absolutePath;
            String[] orig_args2 = new String[]{"run", filename};
            def args2 = [filename]

            int status = new Launcher().command(orig_args2).run();
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

    @Fuzz
    public void debugContent(@From(ContentGenerator) String inputFile) {
        print inputFile
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

