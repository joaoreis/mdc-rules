# Revised MDC Rules Testing Methodology

## Understanding Rule Loading in Firebender

This revised methodology acknowledges a crucial aspect of how Firebender loads and applies rules:

1. Rules are loaded from firebender.json at the start of a conversation
2. Rules remain constant throughout a conversation
3. Changing rules requires modifying firebender.json and starting a new conversation

## Revised Testing Approach

### Preparation Phase

1. Create a backup of the original firebender.json configuration
2. Prepare test files that will trigger specific rules
3. Create a testing matrix documenting which rules to test and which test files to use

### Baseline Testing (No Target Rule)

1. Use test-setup.sh to disable the specific rule being tested:
   ```bash
   ./test-setup.sh --disable .firebender/mdc/core/code-guidelines.mdc
   ```
2. Start a new Firebender conversation
3. Verify in the "Rules Used" section that the target rule is not active
4. Ask your test query with the test file
5. Document the response in a baseline file
6. End the conversation

### Rule-Enabled Testing

1. Use test-setup.sh to enable the specific rule being tested:
   ```bash
   ./test-setup.sh --enable .firebender/mdc/core/code-guidelines.mdc
   ```
2. Start a new Firebender conversation
3. Verify in the "Rules Used" section that the target rule is active
4. Ask the identical test query with the identical test file
5. Document the response in a with-rule file
6. End the conversation

### Analysis Phase

1. Compare the baseline and rule-enabled responses
2. Document differences in communication style, content quality, and other metrics
3. Create a detailed comparison analysis
4. Write a comprehensive test report with recommendations

## Multiple Rule Testing Considerations

When testing how rules interact with each other:

1. For each unique rule combination, create a specific firebender.json configuration
2. Start a new conversation for each configuration
3. Verify active rules in the "Rules Used" section
4. Use the same test query and file across all combinations
5. Document and analyze results across combinations

## Streamlining the Process

To make testing more efficient while respecting how rules work:

1. Create a test-run.sh script that:
    - Creates a backup of firebender.json
    - Modifies the configuration for the specific test
    - Opens a browser to start a new conversation (or provides instructions)
    - Provides the test query to copy/paste
    - Creates a placeholder file for documenting the response

2. Organize testing sessions to minimize the number of conversation restarts:
    - Group tests that use the same rule configuration
    - Complete all tests for one configuration before changing rules

3. Consider creating template configurations:
    - No rules active (complete baseline)
    - Core rules only
    - Full rule set
    - Targeted combinations for specific interactions

## Documentation Best Practices

For each test:

1. Document which rules were active during the test
2. Include a screenshot of the "Rules Used" section as verification
3. Record the exact query used and the full response
4. Note any variables that might affect response quality (time of day, context window limitations,
   etc.)

## Testing Metrics

Continue to track:

- Response quality and accuracy
- Communication style differences
- Token usage and efficiency
- Content comprehensiveness
- Value/cost ratio

This revised approach ensures that testing accurately reflects how rules actually function in the
Firebender environment.