package de.schemmea.ma

import com.beust.jcommander.*
import de.schemmea.ma.generator.Configuration
import de.schemmea.ma.guidance.FileAwareExecutionIndexingGuidance
import de.schemmea.ma.guidance.FileAwareZestGuidance
import de.schemmea.ma.utils.Args
import de.schemmea.ma.utils.FileResourcesUtils
import edu.berkeley.cs.jqf.fuzz.guidance.Guidance
import edu.berkeley.cs.jqf.fuzz.guidance.Result
import edu.berkeley.cs.jqf.fuzz.junit.*
import edu.berkeley.cs.jqf.fuzz.repro.ReproGuidance
import org.apache.commons.lang.StringUtils

import java.nio.file.Paths
import java.time.Duration

class TestExecutor {

    static Args ARGS = new Args();
    private static Set<String> stackTraces = new HashSet<>();
    private static Map<String, Integer> nameCountMap = new HashMap<>();

    static File logfile = new File(Paths.get(Configuration.EXCEPTION_LOG_FILE).toUri());

    static void main(String... args) {

        var commander = new JCommander(ARGS, args)

        String testname = "testTest"
        Class testclass = NfTest.class

        String errorDir = Configuration.ERROR_DIR;

        boolean iswindows = System.getProperty("os.name").toLowerCase().startsWith("windows");
        if (iswindows && !errorDir.startsWith("C:") && !errorDir.startsWith("/")) errorDir = "/" + errorDir;
        Guidance guidance = null;

        new FileResourcesUtils().copyFilesToFolder(Configuration.SOURCE_PATH, Configuration.OUTPUT_PATH);
        new FileResourcesUtils().copyFilesToFolder(Configuration.TEMPLATE_SOURCE_PATH, Configuration.OUTPUT_TEMPLATE_PATH);
        new FileResourcesUtils().copyFilesToFolder(Configuration.DATA_SOURCE_PATH, Configuration.OUTPUT_DATA_PATH);

        if (ARGS.guidance == "repro") {
            File[] testInputFiles = new File(ARGS.reproDir).listFiles().sort();

            String traceDirName = System.getProperty("jqf.repro.traceDir");
            File traceDir = traceDirName != null ? new File(traceDirName) : null;

            guidance = new ReproGuidance(testInputFiles, traceDir)

            println "Repro $ARGS.reproDir"

        } else {

            println "Testing $testclass.name # $testname $ARGS.iteration times, duration: $ARGS.durationInSeconds s"

            File errorDirectory = Paths.get(errorDir).toFile();
            if (!errorDirectory.exists()) {
                errorDirectory.mkdir();
            }

            if (ARGS.guidance == "ei") {
                guidance = new FileAwareExecutionIndexingGuidance(testname,
                        Duration.ofSeconds(ARGS.durationInSeconds),
                        ARGS.iteration,
                        errorDirectory,
                        new Random(),
                        TestExecutor::handleResult)
            } else { /*zest*/
                guidance = new FileAwareZestGuidance(testname,
                        Duration.ofSeconds(ARGS.durationInSeconds),
                        ARGS.iteration,
                        errorDirectory,
                        new Random(),
                        TestExecutor::handleResult)
            }
        }

        /* ~~~~~~~~~~~~~~~ execution ~~~~~~~~~~~~~~~~ */
        GuidedFuzzing.run(testclass, testname, guidance, System.out)

        if (ARGS.guidance == "repro") {

            if (guidance.getBranchesCovered() != null) {
                String cov = "";
                for (String s : guidance.getBranchesCovered()) {
                    cov += "# Covered: " + s + "\n";
                }
                final String finalFooter = cov;
                System.out.println(finalFooter);
            }

            System.out.println(String.format("Covered %d edges.", guidance.getCoverage().getNonZeroCount()));

        } else {
            System.out.println(String.format("Covered %d edges.", guidance.getTotalCoverage().getNonZeroCount()));

        }


        println "Tested $testclass.name#$testname $ARGS.iteration times, duration: $ARGS.durationInSeconds s"
    }


    private static void handleResult(Object[] files, Result result, Throwable throwable) {
        if (result == Result.FAILURE && files.length == 1) {
            File mainFile = null;
            if (files[0] instanceof File) {
                mainFile = (File) files[0];
            } else if (((String[]) files[0])[0] == "run") {
                mainFile = new File(((String[]) files[0])[1])
            }
            String name;
            String stackTrace;
            if (throwable == null) {
                name = "NONE";
                stackTrace = StringUtils.EMPTY;
            } else {
                name = throwable.getClass().getName();
                stackTrace = throwableToStacktraceText(throwable);
            }
            boolean unique = !stackTraces.contains(stackTrace);
            if (unique) {
                stackTraces.add(stackTrace);
            }

            //count exception overall general
            var count = nameCountMap.getOrDefault(name, 0);
            nameCountMap.put(name, ++count);

            //write to csv : exception, unique, file name
            FileWriter writer = new FileWriter(logfile, true);
            writer.append(name + ";" + unique + ";" + count + ";" + mainFile?.getName() + ";" + Configuration.newline);
            writer.close();

        } else if (result == Result.SUCCESS && files.length == 1 && files[0] instanceof File && !ARGS.keepTestFile) {
            //delete file because no error was thrown
            var mainFile = (File) files[0];
            mainFile.delete();
        } else if (result == Result.SUCCESS && files.length == 1 && files[0] instanceof String[] && !ARGS.keepTestFile) {
            if (((String[]) files[0])[0] == "run") {
                new File(((String[]) files[0])[1]).delete()
            }
        }
    }

    private static String throwableToStacktraceText(Throwable throwable) {
        var writer = new StringWriter();
        throwable.printStackTrace(new PrintWriter(writer));
        return writer.toString();
    }
}

