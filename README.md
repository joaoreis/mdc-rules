# Android MDC Rules Repository

A comprehensive collection of Machine Directed Comments (MDC) rules for Android development with AI coding assistants like Firebender.

## Overview

This repository contains a carefully curated set of MDC rules for enhancing Android development workflows when working with AI coding assistants. The rules are organized into logical categories to improve maintainability, usability, and discoverability.

The project includes a simplified testing framework to evaluate and compare the effectiveness of different MDC rules.

## Repository Structure

```
.firebender/mdc/
├── README.md                # Overview of MDC rules organization
├── core/                    # Foundational rules
├── android/                 # Android-specific rules
├── build-tools/             # Build systems and CI/CD rules
├── testing/                 # Testing frameworks and practices
├── development/             # Development workflows and tools
├── documentation/           # Documentation practices and planning
└── monitoring/              # Error tracking and monitoring
```

## Rule Categories

### Core
Foundational rules that apply broadly across development projects.
- [code-guidelines.mdc](.firebender/mdc/core/code-guidelines.mdc) - General coding standards
- [meta-rule-management.mdc](.firebender/mdc/core/meta-rule-management.mdc) - Guidelines for managing rules

### Android
Rules specific to Android application development.
- [android-sdk.mdc](.firebender/mdc/android/android-sdk.mdc) - Android SDK best practices
- [android-memory-management.mdc](.firebender/mdc/android/android-memory-management.mdc) - Memory optimization
- [jetpack-compose.mdc](.firebender/mdc/android/jetpack-compose.mdc) - Jetpack Compose UI development

### Build Tools
Rules for build systems and CI/CD pipelines.
- [gradle.mdc](.firebender/mdc/build-tools/gradle.mdc) - Gradle build configuration
- [github-actions.mdc](.firebender/mdc/build-tools/github-actions.mdc) - GitHub Actions workflows

### Testing
Rules for testing frameworks and methodologies.
- [junit.mdc](.firebender/mdc/testing/junit.mdc) - JUnit testing guidelines
- [test-driven-development.mdc](.firebender/mdc/testing/test-driven-development.mdc) - TDD principles

### Development
Rules for development workflows and tools.
- [problem-solving.mdc](.firebender/mdc/development/problem-solving.mdc) - Methodical problem-solving
- [api-debugging.mdc](.firebender/mdc/development/api-debugging.mdc) - API debugging techniques
- [log-checking.mdc](.firebender/mdc/development/log-checking.mdc) - Efficient log analysis
- [auto-format.mdc](.firebender/mdc/development/auto-format.mdc) - Code formatting automation
- [bash.mdc](.firebender/mdc/development/bash.mdc) - Bash scripting standards

### Documentation
Rules for documentation and planning.
- [documentation-reference.mdc](.firebender/mdc/documentation/documentation-reference.mdc) - Documentation best practices
- [git-commit-standards.mdc](.firebender/mdc/documentation/git-commit-standards.mdc) - Git commit message standards
- [plan-updates.mdc](.firebender/mdc/documentation/plan-updates.mdc) - Update planning

### Monitoring
Rules for error tracking and monitoring.
- [sentry.mdc](.firebender/mdc/monitoring/sentry.mdc) - Sentry integration and usage

## Configuration

The rules are configured in the [firebender.json](./firebender.json) file, which maps different file patterns to relevant rules. This ensures that the appropriate guidance is provided based on the type of file being edited.

## Usage

1. Clone this repository to use as a reference for your own MDC rules
2. Create a symlink to your local Firebender configuration:
   ```bash
   ln -s /home/youruser/.firebender/firebender.json firebender.json
   ```
3. Add desired rules to your project following the structure in this repository
4. Use the testing framework in the `test/` directory to evaluate rule effectiveness

## Testing Framework

A simplified testing framework is provided to help evaluate the effectiveness of different MDC rules:

- **Location:** `test/` directory
- **Purpose:** Compare AI responses with and without specific rules enabled
- **Usage:** See `test/README.md` for detailed instructions

To test a rule:
```bash
cd test/scripts
./test-rule.sh --rule .firebender/mdc/core/code-guidelines.mdc --case ../cases/core/SampleClass.kt
```

This will guide you through testing the rule and analyzing its impact on AI responses.

## Contributing

Contributions to expand and improve these rules are welcome. Please feel free to:
- Add new MDC rules for useful libraries or tools
- Enhance existing rules with additional best practices
- Improve documentation and examples
- Fix errors or outdated information

## Sources

These MDC rules are based on various sources, including:
- [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc)
- [Mawla/cursor_rules](https://github.com/Mawla/cursor_rules)
- [PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules)

## License

This project is available under the MIT License.