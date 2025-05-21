# MDC Rules Testing Framework

## Overview

This is a simplified testing framework for evaluating the effectiveness of Machine Directed Comments (MDC) rules with AI coding assistants like Firebender. The framework provides a structured approach to testing rules by comparing AI responses with and without specific rules enabled.

## Directory Structure

```
test/
├── cases/              # Test cases organized by rule category
│   ├── core/           # Test files for core rules
│   ├── android/        # Test files for android rules
│   └── ...
├── prompts/            # Standard prompts for each rule
├── results/            # Store test results here
│   ├── baseline/       # AI responses without rules
│   ├── with-rules/     # AI responses with rules enabled
│   └── analysis/       # Comparative analysis of results
└── scripts/            # Testing scripts
    ├── test-rule.sh    # Main testing script
    └── generate-summary.sh  # Summary generator
```

## Getting Started

### Prerequisites

- Firebender installed and configured
- jq command-line tool (`sudo apt install jq` or equivalent for your OS)
- Bash shell

### Basic Usage

1. Navigate to the scripts directory:
   ```
   cd test/scripts/
   ```

2. Run a test for a specific rule:
   ```
   ./test-rule.sh --rule .firebender/mdc/core/code-guidelines.mdc --case ../cases/core/SampleClass.kt
   ```

3. Follow the on-screen instructions to complete both the baseline test and the rule-enabled test

4. After testing, generate a summary:
   ```
   ./generate-summary.sh
   ```

## Testing Workflow

1. **Select a Rule to Test**: Choose which MDC rule you want to evaluate.

2. **Select or Create Test Cases**: Either use an existing test case from the `cases` directory or create a new one that would trigger the rule.

3. **Run the Test**: Execute the `test-rule.sh` script with appropriate parameters.

4. **Record Results**: For each test:
   - Start a new Firebender conversation
   - Verify that the correct rule(s) are loaded
   - Ask the given prompt about the test case
   - Save the AI's response in the designated result file

5. **Analyze Results**: Compare the baseline (no rules) and rule-enabled responses using the generated analysis template.

6. **Generate Summary**: After testing multiple rules, use `generate-summary.sh` to create an overview of all test results.

## Example Test Run

```bash
# Test the code-guidelines rule with a Kotlin sample class
./test-rule.sh --rule .firebender/mdc/core/code-guidelines.mdc --case ../cases/core/SampleClass.kt

# Test with a custom prompt
./test-rule.sh --rule .firebender/mdc/android/android-memory-management.mdc --case ../cases/android/SampleActivity.kt --prompt "How can I optimize memory usage in this code?"
```

## Contributing

To contribute new test cases:

1. Add your test file to the appropriate category under `cases/`
2. Add default prompts for the rule in the relevant prompts file
3. Run your test and document the results

## Recommended Testing Order

1. Start with **core rules** as they're the most generally applicable
2. Move to **documentation** and **development** rules next
3. Test **build-tools** and **testing** rules
4. Finally, test domain-specific rules like **android**

This approach lets you validate the testing framework with simpler rules before moving to more complex domain-specific ones.