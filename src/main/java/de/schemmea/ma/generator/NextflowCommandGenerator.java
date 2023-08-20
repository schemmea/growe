package de.schemmea.ma.generator;

import com.pholser.junit.quickcheck.generator.GenerationStatus;
import com.pholser.junit.quickcheck.generator.Generator;
import com.pholser.junit.quickcheck.random.SourceOfRandomness;
import de.schemmea.ma.TestExecutor;

import java.io.*;

public class NextflowCommandGenerator extends Generator<String[]> {

    Generator<File> baseGenerator;

    public NextflowCommandGenerator() throws IOException {
        super(String[].class);
        boolean useBaseline = TestExecutor.getARGS().getUseBaseline();
        if (useBaseline) {
            baseGenerator = new BaselineGenerator();
        } else {
            baseGenerator = new WorkflowFileGenerator();
        }
    }


    //    static String[] commands = new String[]{"clean",  "config", "console", "drop", "help", "info", "list", "log", "pull", "run", "secrets", "view"};
    static String[] commands = new String[]{"help", "info", "run", "clean", "list", "log", "drop", "secrets"};
    //static String[] commands = new String[]{"run"}; // "help", "info", "run"};


    static String[] runOptions = new String[]{"-with-docker", "-with-report",
            "-with-trace", "-with-timeline"};
    //"-with-charliecloud", "-with-podman", "-with-singularity", "-with-apptainer",
    static String[] secretsOptions = new String[]{"delete", "list", "get", "put", "set"};


    @Override
    public String[] generate(SourceOfRandomness sourceOfRandomness, GenerationStatus generationStatus) {
        var command = sourceOfRandomness.choose(commands);

        switch (command) {
            case "run":
                if (sourceOfRandomness.nextBoolean()) {
                    return new String[]{command, baseGenerator.generate(sourceOfRandomness, generationStatus).getAbsolutePath(), sourceOfRandomness.choose(runOptions)};
                } else {
                    return new String[]{command, baseGenerator.generate(sourceOfRandomness, generationStatus).getAbsolutePath()};
                }
            case "secrets":
                String option = sourceOfRandomness.choose(secretsOptions);
                if (option == "set" || option == "put")
                    return new String[]{command, option, String.valueOf(sourceOfRandomness.nextChar('a', 'z')), "\"" + sourceOfRandomness.nextChar('a', 'z') + "\""};
                else if (option != "list")
                    return new String[]{command, option};
                else
                    return new String[]{command, option, String.valueOf(sourceOfRandomness.nextChar('a', 'z'))};
            case "pull":
            case "drop":
            case "console":
            case "log":
            case "clean":
            case "view":
                return new String[]{command, sourceOfRandomness.nextChar('a', 'z') + ""};
            case "list":
            case "info":
            case "help":
            default:
                return new String[]{command};
        }
    }

}