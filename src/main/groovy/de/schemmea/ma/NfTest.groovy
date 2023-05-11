package de.schemmea.ma

import com.pholser.junit.quickcheck.From
import de.schemmea.ma.generator.NfGenerator
import de.schemmea.ma.nf.CustomNextflowLauncher
import de.schemmea.ma.nf.CustomNextflowScriptRunner
import edu.berkeley.cs.jqf.fuzz.Fuzz
import edu.berkeley.cs.jqf.fuzz.JQF
import nextflow.cli.Launcher
import org.junit.runner.RunWith

import java.nio.file.Paths
import java.util.concurrent.CompletableFuture

@RunWith(JQF.class)
class NfTest {


    static int iteration = 0;

    @Fuzz
    public void testNF(@From(NfGenerator.class) String inputFile) throws IOException {

        var newline = System.getProperty("line.separator");

        inputFile = inputFile.replace("\\n", newline)

        println newline + "STARTING ITERATION " + (++iteration) + newline + inputFile

        var date = System.currentTimeMillis()
        date -= 1680000000000

        String dir = "$TestExecutor.formattedDate/generatedflows"
        println( "Writing file to dir: $dir")
        File generated = Paths.get(dir).toFile();
        if (!generated.exists()) {
            generated.mkdir();
        }

        File file = new File("$dir/out" + date + ".nf")
        file.write inputFile


        //classloader setzen?

        String[] orig_args2 = ["run", file.path]
        ArrayList<String> args2 = [file.path];

        //  status = new CustomNextflowLauncher().command(args2).run();
        CustomNextflowScriptRunner myrunnner = new CustomNextflowScriptRunner(args2)

        status = myrunnner.run();

        println "launched nextflow, status:" + status

    }
    static int status = 0

    private static CompletableFuture<Void> createFuture(String[] args2) {

        return CompletableFuture.runAsync(new Launcher().command(args2).run() as Runnable);
    }

    @Fuzz
    public void testSimple() {
        var startTime = System.currentTimeMillis();

        File file = new File(getClass().getResource("/templates/yesOrNo.nf").toURI())

        String[] args2 = ["run", file.absolutePath]
        final status = new Launcher().command(args2).run()
        println "launched nextflow"
        if (status) {
            var stopTime = System.currentTimeMillis();

            println "took " + (stopTime - startTime) / 1000 + "s"
            System.exit(status)
        }
    }

}
