# MDC Rules Comprehensive Testing Project

## Overview

This repository contains a comprehensive testing framework for evaluating Machine Directed
Comments (MDC) rules. The project aims to systematically test each MDC rule to evaluate its
effectiveness, document its behavior, and compare agent responses with versus without each rule.

## Repository Structure

```
mdc-rules/
├── firebender.json              # Configuration file for rules
├── rules-inventory.md           # Inventory of all MDC rules
├── testing-methodology.md       # Testing methodology documentation
├── project-status.md            # Current project status and progress
├── test-setup.sh                # Script to enable/disable rules for testing
├── run-test-query.sh            # Script to run test queries and record results
├── test-files/                  # Test files for triggering rules
│   ├── kotlin/                  # Kotlin test files
│   ├── gradle/                  # Gradle test files
│   ├── yaml/                    # YAML test files
│   ├── docs/                    # Documentation test files
│   └── bash/                    # Bash script test files
└── test-results/                # Test results organized by rule category
    ├── core/                    # Core rules test results
    ├── documentation/           # Documentation rules test results
    ├── development/             # Development rules test results
    ├── build-tools/             # Build tools rules test results
    ├── testing/                 # Testing rules test results
    ├── monitoring/              # Monitoring rules test results
    ├── android/                 # Android rules test results
    └── test-result-template.md  # Template for test results
```

## Getting Started

1. Clone this repository
2. Run `chmod +x *.sh` to make the scripts executable
3. Review the rules inventory in `rules-inventory.md`
4. Check the current project status in `project-status.md`
5. Start testing rules according to the methodology in `testing-methodology.md`

## Testing Workflow

1. **Prepare for testing**:
   ```bash
   # Make a backup of the current configuration
   ./test-setup.sh --backup
   ```

2. **Run baseline testing (without rule)**:
   ```bash
   ./run-test-query.sh --rule .firebender/mdc/core/code-guidelines.mdc \
                      --file test-files/kotlin/SampleClass.kt \
                      --query "Review this code and suggest improvements" \
                      --mode baseline \
                      --output test-results/core/code-guidelines-baseline-1.txt
   ```

3. **Run testing with rule enabled**:
   ```bash
   ./run-test-query.sh --rule .firebender/mdc/core/code-guidelines.mdc \
                      --file test-files/kotlin/SampleClass.kt \
                      --query "Review this code and suggest improvements" \
                      --mode with_rule \
                      --output test-results/core/code-guidelines-with-rule-1.txt
   ```

4. **Restore original configuration**:
   ```bash
   ./test-setup.sh --restore
   ```

5. **Document results** using the test result template

## Test Cases

Standard test cases that apply to most rules:

1. Basic Functionality Test
2. Edge Case Tests
3. Multiple Rules Test
4. Performance Test
5. Error Handling

## Performance Metrics

For each rule, measure and compare:

- Token Usage
- Response Speed
- Memory Usage
- Accuracy Tradeoffs
- Rate Limit Impact

## Contributing

1. Update the `project-status.md` as you complete testing of rules
2. Document all test results using the template
3. Add observations about rule behavior and interactions
4. Suggest improvements for rules based on test results

## Project Progress

Check `project-status.md` for the current status of the testing project.

## Notes

- Testing starts with simpler rules first and leaves Android rules for last
- Focus on rules that don't require complex configuration for initial testing