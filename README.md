# Android MDC Rules

A collection of Machine Directed Comments (MDC) rules for Android development with AI coding
assistants like Firebender.

## Overview

This repository contains a carefully curated set of MDC rules designed to enhance Android
development workflows when working with AI coding assistants. These rules provide guidance on best
practices, coding standards, and development patterns for various aspects of Android application
development.

## MDC Rule Categories

### Core Rules

- **[Code Guidelines](.firebender/mdc/code-guidelines.mdc)**: General coding standards and quality
  guidelines
- **[Meta Rule Management](.firebender/mdc/meta-rule-management.mdc)**: Guidelines for managing and
  organizing MDC rules

### Android Development

- **[Android SDK](.firebender/mdc/android-sdk.mdc)**: Best practices for Android SDK usage
- **[Jetpack Compose](.firebender/mdc/jetpack-compose.mdc)**: Modern UI development with Jetpack
  Compose
- **[Android Memory Management](.firebender/mdc/android-memory-management.mdc)**: Memory
  optimization strategies for Android

### Build & Deployment

- **[Gradle](.firebender/mdc/gradle.mdc)**: Build system configuration and optimization
- **[GitHub Actions](.firebender/mdc/github-actions.mdc)**: CI/CD pipelines for Android projects
- **[Plan Updates](.firebender/mdc/plan-updates.mdc)**: Guidelines for planning and implementing app
  updates

### Testing & Quality Assurance

- **[JUnit](.firebender/mdc/junit.mdc)**: Testing patterns and practices
- **[Test-Driven Development](.firebender/mdc/test-driven-development.mdc)**: TDD approach for
  Android development

### Development Workflows

- **[Git Commit Standards](.firebender/mdc/git-commit-standards.mdc)**: Version control best
  practices
- **[Problem Solving](.firebender/mdc/problem-solving.mdc)**: Systematic approaches to
  problem-solving
- **[API Debugging](.firebender/mdc/api-debugging.mdc)**: Techniques for debugging API interactions
- **[Log Checking](.firebender/mdc/log-checking.mdc)**: Effective logging practices

### Utilities

- **[Bash](.firebender/mdc/bash.mdc)**: Shell scripting for Android development
- **[Auto Format](.firebender/mdc/auto-format.mdc)**: Code formatting standards
- **[Sentry](.firebender/mdc/sentry.mdc)**: Error tracking and monitoring
- **[Documentation Reference](.firebender/mdc/documentation-reference.mdc)**: Documentation
  standards

## Setup

1. Ensure you have [Firebender](https://firebender.com/) installed and configured.
2. Clone this repository or use it as a template for your own MDC rules.
3. The rules are already configured in the `firebender.json` file to be used with Firebender.

## Usage

The MDC rules are organized and applied based on file types and paths as configured in the
`firebender.json` file:

- Kotlin files (.kt) will use Android-specific rules
- Gradle files will use build-specific rules
- Test files will use testing-specific rules
- General rules apply across all files

### Customizing Rules

To customize the rules for your specific project:

1. Edit the MDC files in the `.firebender/mdc/` directory
2. Modify the `firebender.json` file to adjust which rules apply to which files

## Contributing

Contributions to expand and improve these rules are welcome! Please feel free to submit pull
requests or open issues with suggestions.

## License

This project is available under the MIT License.