# Development MDC Rules

This directory contains MDC (Machine Directed Comments) rules for development workflows and tools
used in Android application development.

## Available Rules

### Problem Solving

- **File:** [problem-solving.mdc](problem-solving.mdc)
- **Description:** Standardized approach for problem analysis, solution design, and implementation
  planning.
- **Source:
  ** [Mawla/cursor_rules](https://github.com/Mawla/cursor_rules/blob/main/.cursor/rules/problem-solving.mdc)

### API Debugging

- **File:** [api-debugging.mdc](api-debugging.mdc)
- **Description:** Guidelines for debugging API interactions in Android applications.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/api-debugging.mdc)

### Log Checking

- **File:** [log-checking.mdc](log-checking.mdc)
- **Description:** Guidelines for safe and efficient log checking in Android development.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/log-checking.mdc)

### Auto Format

- **File:** [auto-format.mdc](auto-format.mdc)
- **Description:** Automatically format code files using appropriate formatters based on file type.
- **Source:
  ** [Mawla/cursor_rules](https://github.com/Mawla/cursor_rules/blob/main/.cursor/rules/auto-format.mdc)

### Bash

- **File:** [bash.mdc](bash.mdc)
- **Description:** Best practices and coding standards for Bash scripting to improve code quality,
  maintainability, and security.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/bash.mdc)

## Usage

These rules are applied to various development files in Android projects. They provide guidance for:

1. **Problem Solving:** Following a structured approach to analyze and solve problems
2. **API Debugging:** Effectively debugging API interactions and network issues
3. **Log Checking:** Safely and efficiently checking and analyzing application logs
4. **Code Formatting:** Maintaining consistent code formatting across the project
5. **Shell Scripting:** Writing maintainable and secure Bash scripts

## Dependencies

- For API debugging: Retrofit, OkHttp, Chucker, Flipper
- For log checking: ADB, Pidcat, Timber
- For auto-format: ktlint, google-java-format, spotless
- For Bash scripts: shellcheck, shfmt