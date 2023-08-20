package de.schemmea.ma.generator;

import com.pholser.junit.quickcheck.generator.GenerationStatus;
import com.pholser.junit.quickcheck.generator.Generator;
import com.pholser.junit.quickcheck.random.SourceOfRandomness;
import com.sourceclear.gramtest.GeneratorVisitor;
import com.sourceclear.gramtest.bnfLexer;
import com.sourceclear.gramtest.bnfParser;
import de.schemmea.ma.utils.FileResourcesUtils;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.ParserRuleContext;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.stream.Collectors;

public class TestMiniGenerator extends Generator<String> {
    private static final int generateNumber = 1;
    private static final int depth = 4;
    private static final int max = 4;
    private static final int min = 1;

    List<String> scripts;

    private final ParserRuleContext tree;

    public TestMiniGenerator() throws IOException {
        super(String.class);
        System.out.println("Generator - ctor");

        InputStream bnfFile = new FileResourcesUtils().getResourceFileAsStream("/nextflow/bnfs/mini.bnf");

        Lexer lexer = new bnfLexer(new ANTLRInputStream(bnfFile));

        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tree = new bnfParser(tokens).rulelist();
    }

    public String generate(SourceOfRandomness sourceOfRandomness, GenerationStatus generationStatus) {

        System.out.println("\nGenerator - generate");

        try {
            GeneratorVisitor extractor = new GeneratorVisitor(generateNumber, depth, min, max, true, sourceOfRandomness);
            extractor.visit(tree);
            List<String> generatedTests = extractor.getTests();

            String genTest = generatedTests.get(0);

            char t1 = sourceOfRandomness.nextChar('a','z');
            char t2 = sourceOfRandomness.nextChar('a','z');
            genTest= genTest.replace(t1,t2);

            return genTest;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw e;
        }
    }

}