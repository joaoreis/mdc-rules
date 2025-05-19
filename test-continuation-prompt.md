# MDC Rules Testing Continuation Prompt

## Context

I'm working on a comprehensive testing project for Machine Directed Comments (MDC) rules used with AI coding assistants like Firebender. These rules provide guidance to AI models for better code completion, suggestions, and problem-solving in the context of Android development.

## Current Progress

I've set up the testing framework with:
- Test files organized by file type (kotlin, gradle, yaml, docs, bash)
- Scripts for enabling/disabling rules and running test queries
- Templates for documenting test results
- Initial tests for some core rules (particularly code-guidelines.mdc)

## What I Need Help With

Please help me continue the systematic testing of MDC rules. For each rule, we need to:

1. **Run baseline tests** without the rule enabled to establish baseline AI behavior
2. **Run tests with the rule enabled** to observe how the rule affects AI responses
3. **Compare and analyze** the differences in the responses
4. **Document findings** including effectiveness, token usage, response quality, and any issues

## Next Rules to Test

Please focus on testing the following rules (in this order):
1. meta-rule-management.mdc (from core category)
2. test-driven-development.mdc (from testing category)
3. problem-solving.mdc (from development category)
4. documentation-reference.mdc (from documentation category)
5. gradle.mdc (from build-tools category)

## For Each Rule Test

For each rule, please:

1. **Review the rule content** to understand its purpose and guidance
2. **Select appropriate test files** that would trigger the rule
3. **Formulate 2-3 test queries** relevant to the rule's purpose
4. **Document the testing process** including:
   - Test setup
   - Queries used
   - Baseline response
   - Response with rule enabled
   - Analysis of differences
   - Observations on rule effectiveness
   - Any performance metrics (token usage, response speed)
   - Recommendations for rule improvements

## Testing Workflow Reference

```bash
# Example workflow for testing a rule
# 1. Back up current configuration
./test-setup.sh --backup

# 2. Run baseline test (without rule)
./run-test-query.sh --rule .firebender/mdc/[category]/[rule-name].mdc \
                  --file test-files/[file-type]/[test-file] \
                  --query "Your test query here" \
                  --mode baseline \
                  --output test-results/[category]/[rule-name]-baseline-[test-number].txt

# 3. Run test with rule enabled
./run-test-query.sh --rule .firebender/mdc/[category]/[rule-name].mdc \
                  --file test-files/[file-type]/[test-file] \
                  --query "Your test query here" \
                  --mode with_rule \
                  --output test-results/[category]/[rule-name]-with-rule-[test-number].txt

# 4. Restore original configuration
./test-setup.sh --restore
```

## Documentation Format

Please use the test result template found in test-results/test-result-template.md as a base for documenting findings. For simplified analysis, you can also reference the format in test-results/simplified/analysis-template.md.

## Additional Considerations

- Some rules may depend on or interact with other rules. Note these interactions.
- Focus on qualitative analysis of how the rule affects the AI's guidance, suggestions, and adherence to best practices.
- Note any setup requirements or limitations for specific rules.
- If a rule references external tools or services, document any assumptions made during testing.

Thank you for helping continue this testing project. Your systematic approach to evaluating these rules will help improve the effectiveness of AI coding assistants for Android development.
