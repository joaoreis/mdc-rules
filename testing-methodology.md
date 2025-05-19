# MDC Rules Testing Methodology

## Approach

This document outlines our systematic approach to testing MDC rules. We'll follow a consistent
testing methodology to ensure thorough evaluation of each rule.

## Testing Environment

- **Test Project Structure:** We'll create a sample Android project structure with appropriate files
  that would trigger different MDC rules
- **Configuration:** Local firebender.json configured to enable/disable specific rules for testing
- **Tooling:** Tools for measuring token usage, response time, and other performance metrics

## Testing Process Flow

For each MDC rule, we'll follow this process:

1. **Rule Analysis**
    - Read and understand the rule's purpose and intended behavior
    - Identify target file patterns (globs)
    - Document any dependencies or configuration requirements

2. **Baseline Measurement (without rule)**
    - Create/modify appropriate test files that should trigger the rule
    - Record agent responses without the rule enabled
    - Measure baseline performance metrics (tokens, response time)

3. **Test with Rule Enabled**
    - Enable the specific rule in firebender.json
    - Run the same queries as in baseline measurement
    - Record agent responses and performance metrics

4. **Comparison Analysis**
    - Compare responses with vs. without the rule
    - Evaluate effectiveness based on predetermined criteria
    - Document differences in performance metrics
    - Note any unexpected behavior or issues

5. **Documentation**
    - Update rules-inventory.md with findings
    - Create a detailed report for each rule in the test-results directory

## Standard Test Cases

We'll develop the following standard test cases applicable to most rules:

1. **Basic Functionality Test:** Verify that the rule is triggered when expected
2. **Edge Case Tests:** Test with boundary conditions and unusual inputs
3. **Multiple Rules Test:** Test behavior when multiple related rules are enabled
4. **Performance Test:** Measure performance impact of the rule
5. **Error Handling:** Test how the rule behaves with incorrect inputs or configurations

## Test Case Templates

### 1. Basic Functionality Test Template

```
Test ID: BASIC-[RULE_NAME]
Rule: [RULE_NAME]
Purpose: Verify that the rule provides appropriate guidance when triggered
Test File: [FILE_PATH]
Test Query: [QUERY]
Expected Behavior: [EXPECTED_BEHAVIOR]
Actual Behavior (no rule): [ACTUAL_BEHAVIOR]
Actual Behavior (with rule): [ACTUAL_BEHAVIOR]
Pass/Fail: [PASS/FAIL]
Notes: [OBSERVATIONS]
```

### 2. Performance Test Template

```
Test ID: PERF-[RULE_NAME]
Rule: [RULE_NAME]
Purpose: Measure performance impact of the rule
Test File: [FILE_PATH]
Test Query: [QUERY]
Metrics without Rule:
- Token Usage: [COUNT]
- Response Time: [TIME]
- Memory Usage: [MEMORY]
Metrics with Rule:
- Token Usage: [COUNT]
- Response Time: [TIME]
- Memory Usage: [MEMORY]
Difference:
- Token Usage: [DIFFERENCE]%
- Response Time: [DIFFERENCE]%
- Memory Usage: [DIFFERENCE]%
Impact Assessment: [LOW/MEDIUM/HIGH]
Notes: [OBSERVATIONS]
```

## Evaluation Criteria

Each rule will be evaluated based on:

1. **Effectiveness:**
    - Does the rule provide helpful guidance?
    - Does it trigger in appropriate contexts?
    - Does it improve the quality of agent responses?

2. **Performance:**
    - Token usage impact
    - Response time impact
    - Memory usage impact

3. **Value/Cost Ratio:**
    - Does the value provided by the rule justify its performance impact?
    - Would users perceive a beneficial difference with the rule enabled?

4. **Integration:**
    - How well does the rule work with other rules?
    - Does it conflict with any other rules?

## Rating System

Rules will be rated on a scale of 1-5 for each criterion:

- **1-2:** Below Expectations - Rule provides little value or has significant negative impacts
- **3:** Meets Expectations - Rule performs as expected with acceptable performance impact
- **4-5:** Exceeds Expectations - Rule provides exceptional value with minimal performance impact

## Documentation and Reporting

For each rule, we'll create a detailed report including:

1. Test results for all test cases
2. Performance metrics and comparisons
3. Recommendations for improvements
4. Overall rating and assessment

All test results will be stored in the `test-results` directory, organized by rule category.