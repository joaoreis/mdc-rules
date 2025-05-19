# Testing MDC Rules

This directory contains MDC (Machine Directed Comments) rules for testing practices and frameworks
used in Android development.

## Available Rules

### JUnit

- **File:** [junit.mdc](junit.mdc)
- **Description:** Rules and best practices for writing effective JUnit tests in Android projects.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/junit.mdc)

### Test-Driven Development

- **File:** [test-driven-development.mdc](test-driven-development.mdc)
- **Description:** Standards for Test-Driven Development in Android projects, covering unit testing,
  integration testing, and UI testing.
- **Source:** Based
  on [Mawla/cursor_rules](https://github.com/Mawla/cursor_rules/blob/main/.cursor/rules/test_driven_development.mdc)
  but completely adapted for Android development.

## Usage

These rules are applied to test files and testing-related code in Android projects. They provide
guidance for:

1. **Test Design:** Creating effective and maintainable tests
2. **Test-Driven Development:** Following the TDD workflow
3. **Testing Frameworks:** Using JUnit, Mockito, MockK, and other testing libraries
4. **Android-Specific Testing:** Testing Android components effectively
5. **UI Testing:** Testing user interfaces with Espresso and Compose Testing

## Dependencies

- JUnit 4.13+ or JUnit 5
- AndroidX Test libraries
- Mockito or MockK for mocking
- For UI testing: Espresso or Compose Testing
- For advanced testing: Robolectric, Kaspresso, etc.