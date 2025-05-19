# Code Guidelines Rule Analysis

## Rule Overview

The code-guidelines.mdc rule is a core rule that applies to all file types (glob pattern: *). It
provides comprehensive guidelines for code quality, style, and AI behavior to ensure consistent,
maintainable, and secure code across projects.

## Rule Components

The rule has two main sections:

### 1. AI Communication Guidelines

These guidelines govern how the AI should interact with users and provide feedback:

- **No unnecessary communication** - Avoid apologies, understanding feedback, unnecessary
  confirmations
- **Code efficiency** - Single chunk edits, file-by-file changes, no unnecessary suggestions
- **Content preservation** - Don't remove unrelated code or functionality
- **Information accuracy** - Verify information before presenting it, don't make assumptions

### 2. Code Quality Guidelines

These are standard best practices for code quality that should be applied across languages:

- **Variable naming** - Use explicit variable names
- **Coding style** - Follow consistent style
- **Performance** - Prioritize performance in suggestions
- **Security** - Use a security-first approach
- **Testing** - Suggest appropriate test coverage
- **Error handling** - Implement robust error handling
- **Design principles** - Encourage modularity, edge case handling
- **Code clarity** - Avoid magic numbers, use assertions

## Testing Focus

Our testing should focus on both aspects of the rule:

1. **AI Communication Behavior**
    - Does the AI avoid apologies when the rule is enabled?
    - Does it avoid unnecessary confirmations and understanding feedback?
    - Are suggestions provided in a single chunk rather than multiple steps?
    - Does it avoid summarizing changes?

2. **Code Quality Guidance**
    - Does the AI detect and suggest fixes for magic numbers?
    - Does it recommend better variable naming?
    - Does it suggest proper error handling?
    - Does it identify security concerns?
    - Does it recommend test coverage?

## Test Files Selection Rationale

We've selected multiple file types to test this rule since it applies globally:

1. **SampleClass.kt** - Contains issues like:
    - Magic numbers
    - Poor variable naming
    - Null safety issues
    - Hardcoded values
    - Inadequate error handling

2. **sample-script.sh** - Contains issues like:
    - No error handling
    - Unsafe variable expansion
    - Unquoted variables
    - Hardcoded paths

3. **README.md** - Contains issues like:
    - Incomplete documentation
    - No version specifications
    - Security concerns (exposing API key structure)

## Expected Behavior When Rule Is Enabled

The AI should:

1. Provide more comprehensive code quality suggestions
2. Identify specific issues like magic numbers, poor naming, inadequate error handling
3. Suggest security improvements
4. Follow communication guidelines (no apologies, no summaries)
5. Provide concrete, actionable guidance rather than vague suggestions

## Evaluation Metrics

We'll evaluate the rule based on:

1. **Accuracy** - Does it correctly identify code issues?
2. **Comprehensiveness** - Does it cover all aspects mentioned in the guideline?
3. **Communication style** - Does it follow the AI communication guidelines?
4. **Actionability** - Are suggestions practical and implementable?
5. **Performance impact** - What's the token/time cost of enabling this rule?

## Test Queries Design

Our test queries are deliberately open-ended to assess how the rule influences general advice:

1. "Review this code and suggest improvements"
2. "Is there anything wrong with this code?"
3. "Help me make this code more maintainable"

These queries don't explicitly ask about specific issues, allowing us to see if the rule proactively
guides the AI to identify the problems we've intentionally introduced in the test files.