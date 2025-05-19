# Build Tools MDC Rules

This directory contains MDC (Machine Directed Comments) rules for build tools and continuous
integration/continuous deployment (CI/CD) systems used in Android development.

## Available Rules

### Gradle

- **File:** [gradle.mdc](gradle.mdc)
- **Description:** Comprehensive rules for Gradle best practices, covering code organization,
  performance, security, testing, and more.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/gradle.mdc)

### GitHub Actions

- **File:** [github-actions.mdc](github-actions.mdc)
- **Description:** Guidelines for GitHub Actions workflows focusing on Android CI/CD pipelines,
  covering best practices for build, test, and deployment automation.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/github-actions.mdc)

## Usage

These rules are applied to build configuration and CI/CD workflow files in Android projects. They
provide guidance for:

1. **Build Configuration:** Optimizing Gradle build scripts for performance and maintainability
2. **Dependency Management:** Proper handling of dependencies in build files
3. **CI/CD Workflows:** Setting up efficient GitHub Actions workflows for Android projects
4. **Release Management:** Automating the release process for Android applications
5. **Security:** Ensuring secure handling of sensitive information in build and CI processes

## Dependencies

- Gradle 8.0+
- GitHub Actions (for workflow files)
- For optimal performance with Gradle rules: Gradle wrapper configuration