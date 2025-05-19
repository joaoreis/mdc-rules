# MDC Rule Test Report: Code Guidelines

## Rule Information

- **File:** .firebender/mdc/core/code-guidelines.mdc
- **Category:** Core
- **File Patterns:** *
- **Configuration Requirements:** None
- **Description:** Comprehensive guidelines for code quality, style, and AI behavior. Ensures
  consistent, maintainable, and secure code across projects.
- **Source:
  ** https://github.com/PatrickJS/awesome-cursorrules/blob/main/rules/code-guidelines-cursorrules-prompt-file/.cursorrules

## Test Plan

### Test Files to Use

- `test-files/kotlin/SampleClass.kt` - Contains various coding issues that should trigger the rule
- `test-files/bash/sample-script.sh` - Contains shell script issues
- `test-files/docs/README.md` - Contains documentation issues

### Test Queries to Run

1. "Review this code and suggest improvements"
2. "Is there anything wrong with this code?"
3. "Help me make this code more maintainable"

### Test Approach

1. For each test file, run each query with the code-guidelines rule disabled
2. Run the same queries with the code-guidelines rule enabled
3. Compare the responses for differences in:
    - Code quality suggestions
    - Style recommendations
    - Security advice
    - Error handling recommendations
    - Documentation guidance

## Expected Results

When the code-guidelines rule is enabled:

1. The agent should provide more comprehensive code quality suggestions
2. The agent should identify magic numbers, non-descriptive variable names, poor error handling
3. The agent should follow the communication guidelines (no apologies, no unnecessary summaries,
   etc.)
4. The agent should prioritize maintainability, security, and performance in its recommendations

## Test Schedule

- Baseline Tests (without rule): [DATE]
- Rule-Enabled Tests: [DATE]
- Analysis and Documentation: [DATE]