/*
 * © Copyright 2015 -  SourceClear Inc
 */

package com.sourceclear.gramtest;

import com.pholser.junit.quickcheck.random.SourceOfRandomness;

import java.util.*;

import static java.util.Collections.swap;

/**
 *
 */
public class GeneratorVisitor extends bnfBaseVisitor {

    ///////////////////////////// Class Attributes \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    ////////////////////////////// Class Methods \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    //////////////////////////////// Attributes \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    private final Map<String, bnfParser.RhsContext> productionsMap = new HashMap<>();
    private int maxNum = 100;
    private int maxDepth = 2;
    private int maxSize = 4;
    private int minSize = 1;
    private boolean useMinimalGenerator = true;
    private List<String> tests = new LinkedList<>();
    private final Stack<String> prodHist = new Stack<>();

    private SourceOfRandomness sourceOfRandomness;
    private Map<String, Integer> choicesMade;
    private Map<String, Integer> shuffled;

    /////////////////////////////// Constructors \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    public GeneratorVisitor() {
    }

    public GeneratorVisitor(int num, int depth, int min, int max, boolean useMinimalGenerator, SourceOfRandomness sourceOfRandomness) {
        this.maxNum = num;
        this.maxDepth = depth;
        this.minSize = min;
        this.maxSize = max;
        this.useMinimalGenerator = useMinimalGenerator;
        this.sourceOfRandomness = sourceOfRandomness;
        this.choicesMade = new HashMap<>();
        this.shuffled = new HashMap<>();
    }

    ////////////////////////////////// Methods \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    //------------------------ Implements:
    //------------------------ Overrides:

    @Override
    public Object visitId(bnfParser.IdContext ctx) {
        return super.visitId(ctx);
    }

    @Override
    public String visitText(bnfParser.TextContext ctx) {
        return unquote(ctx.getText());
    }

    @Override
    public String visitCaptext(bnfParser.CaptextContext ctx) {
        return ctx.getText();
    }

    @Override
    public Object visitOneormore(bnfParser.OneormoreContext ctx) {
        return super.visitOneormore(ctx);
    }

    @Override
    public Object visitZeroormore(bnfParser.ZeroormoreContext ctx) {
        return super.visitZeroormore(ctx);
    }

    @Override
    public Object visitOptional(bnfParser.OptionalContext ctx) {
        return super.visitOptional(ctx);
    }

    @Override
    public List<String> visitElement(bnfParser.ElementContext ctx) {
        List<String> result = new LinkedList<>();
        if (ctx.zeroormore() != null) {
            result = visitAlternatives(ctx.zeroormore().alternatives()); // one time
            List<String> twoLs = combineTwoLists(result, Collections.singletonList("")); // zero time
            result.addAll(twoLs);
        } else if (ctx.oneormore() != null) {
            result = visitAlternatives(ctx.oneormore().alternatives()); // one time
            List<String> twoLs = combineTwoLists(result, result); //two times
            result.addAll(twoLs);
        } else if (ctx.optional() != null) {
            result = visitAlternatives(ctx.optional().alternatives()); // one time
            result.add(""); // zero time
        } else if (ctx.captext() != null) {
            result.add(visitCaptext(ctx.captext()));
        } else if (ctx.text() != null) {
            result.add(visitText(ctx.text()));
        } else {
            String lhs = ctx.id().getText();
            prodHist.push(lhs);
            bnfParser.RhsContext rhs = productionsMap.get(lhs);
            try {

                if (rhs.alternatives() == null ||
                        rhs.alternatives().alternative().stream().allMatch(ac -> isTerminalContext(ac.element())) ||
                        prodHist.size() < productionsMap.size()) {
                    return visitRhs(productionsMap.get(lhs));
                } else {
                    int rand = 0;
                    int choices = rhs.alternatives().alternative().size();
                    if (choices > 1) {
                        try {
                            rand = sourceOfRandomness.nextInt(choices);
                            int c = choicesMade.getOrDefault(lhs, 0);
                            choicesMade.put(lhs, ++c);
                        } catch (Exception e) {
                            // e.printStackTrace();
                            System.out.println("~~~~~ End of Random ~~~~~ Choices Made: " + choicesMade + " ~~~~");
                            return result;
                        }
                    }

                    result = visitAlternative(rhs.alternatives().alternative(rand));
                    if (!prodHist.empty()) prodHist.pop();
                    return result;
                }
            } catch (Exception e) {
                System.out.println(rhs.getText() + "\n" + e.getCause().toString());
            }
        }
        return result;
    }

    @Override
    public List<String> visitAlternative(bnfParser.AlternativeContext ctx) {
        List<List<String>> comStr = new LinkedList<>();
        for (bnfParser.ElementContext ec1 : ctx.element()) {
            if (prodHist.size() < maxDepth) {
                List<String> slist = visitElement(ec1);
                if (!slist.isEmpty()) comStr.add(slist);
            }
        }
        List<String> emptyStr = new LinkedList<>();
        emptyStr.add("");
        return generateAllStrings(comStr, emptyStr);
    }

    @Override
    public List<String> visitAlternatives(bnfParser.AlternativesContext ctx) {
        List<String> altStrs = new LinkedList<>();
        List<bnfParser.AlternativeContext> acList = ctx.alternative();
        if (acList.size() > 1) {
            try {
                shuffle(acList, sourceOfRandomness);
                int c = shuffled.getOrDefault(ctx.getText(), 0);
                shuffled.put(ctx.getText(), ++c);
            } catch (Exception e) {
                // e.printStackTrace();
                System.out.println("~~~~~ End of Random in shuffle~~~~");
                System.out.println("~~~~~ Choices Made: " + choicesMade + " ~~~~");
            }
        }
        for (bnfParser.AlternativeContext ac : acList) {
            altStrs.addAll(visitAlternative(ac));
        }
        return altStrs;
    }

    @Override
    public List<String> visitRhs(bnfParser.RhsContext ctx) {
        List<String> tmp = visitAlternatives(ctx.alternatives());
        if (!prodHist.empty()) prodHist.pop();
        return tmp;
    }

    @Override
    public Object visitLhs(bnfParser.LhsContext ctx) {
        return super.visitLhs(ctx);
    }

    @Override
    public List<String> visitRule_(bnfParser.Rule_Context ctx) {
        return visitRhs(ctx.rhs());
    }

    @Override
    public Object visitRulelist(bnfParser.RulelistContext ctx) {
        List<String> sentences = new LinkedList<>();
        for (bnfParser.Rule_Context rc : ctx.rule_()) {
            productionsMap.put(rc.lhs().id().getText(), rc.rhs());
        }
        maxDepth = maxDepth + productionsMap.size();
        // Should not visit all the rules, but start from the top one
    /*
    for(bnfParser.Rule_Context rc : ctx.rule_()) {
      sentences.addAll(visitRule_(rc));
    }
    */
        sentences.addAll(visitRule_(ctx.rule_(0)));
        //sentences.removeIf(s -> s.length() < minSize);
        if (sentences.size() > maxNum)
            tests = sentences.subList(0, maxNum); // return only top maxNum test cases
        else tests = sentences;
        return super.visitRulelist(ctx);
    }

    //---------------------------- Abstract Methods -----------------------------

    //---------------------------- Utility Methods ------------------------------

    private String unquote(String s) {
        try {
            if (s != null &&
                    ((s.startsWith("\"") && s.endsWith("\"")) ||
                            (s.startsWith("'") && s.endsWith("'")))) {
                s = s.substring(1, s.length() - 1);
            }
        } catch (Exception e) {
            System.out.println(s);
        }
        return s;
    }

    private List<String> generateAllStrings(List<List<String>> strList, List<String> result) {
        if (strList.size() > 0) {
            List<String> newResult = combineTwoLists(result, strList.remove(0));
            if (newResult.isEmpty()) return result;
            else return generateAllStrings(strList, newResult);
        }
        return result;
    }

    private List<String> combineTwoLists(List<String> preList, List<String> postList) {
        List<String> combList = new LinkedList<>();

        if (useMinimalGenerator) {
            Stack<String> preStack = new Stack<>();
            preStack.addAll(preList);
            Stack<String> postStack = new Stack<>();
            postStack.addAll(postList);
            while (!preStack.empty() && !postStack.empty()) {
                String s1 = preStack.pop();
                String s2 = postStack.pop();
                if (combList.size() < maxNum && (s1.length() + s2.length()) > minSize
                        && !(s1.isEmpty() && s2.isEmpty()))
                    combList.add(s1 + s2);
            }
        }
        for (String s1 : preList) {
            for (String s2 : postList) {
                if (combList.size() < maxNum && (s1.length() + s2.length()) < maxSize
                        && !(s1.isEmpty() && s2.isEmpty()))
                    combList.add(s1 + s2);
            }
        }
        return combList;
    }

    private Boolean isTerminalContext(List<bnfParser.ElementContext> eclist) {
        for (bnfParser.ElementContext ec : eclist) {
            if (ec.text() == null && ec.captext() == null) return false;
        }
        return true;
    }

    private static void swap(Object[] arr, int i, int j) {
        Object tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
    }

    public static void shuffle(List<?> list, SourceOfRandomness rnd) {
        int size = list.size();
        if (size >= 5 && !(list instanceof RandomAccess)) {
            Object[] arr = list.toArray();

            for (int i = size; i > 1; --i) {
                swap(arr, i - 1, rnd.nextInt(i));
            }

            ListIterator it = list.listIterator();
            Object[] var5 = arr;
            int var6 = arr.length;

            for (int var7 = 0; var7 < var6; ++var7) {
                Object e = var5[var7];
                it.next();
                it.set(e);
            }
        } else {
            for (int i = size; i > 1; --i) {
                Collections.swap(list, i - 1, rnd.nextInt(i));
            }
        }

    }
    //---------------------------- Property Methods -----------------------------

    public List<String> getTests() {
        // int sum = choicesMade.values().stream().mapToInt(Integer::intValue).sum() +
        //         shuffled.values().stream().mapToInt(Integer::intValue).sum();
        // System.out.println("~~~~~ Choices Made: " + choicesMade +
        //         ", \nShuffled: " + shuffled + "\nSum: " + sum +" ~~~~");
        return tests;
    }

}
