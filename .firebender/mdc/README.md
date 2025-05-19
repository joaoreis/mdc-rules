# MDC Rules Organization

This directory contains MDC (Machine Directed Comments) rules organized into logical categories to
enhance maintainability and ease of use.

## Category Structure

### Core

Foundational rules that apply broadly across development projects:

- `code-guidelines.mdc`: General coding standards and quality guidelines
- `meta-rule-management.mdc`: Guidelines for managing and organizing MDC rules

### Android

Rules specific to Android application development:

- `android-sdk.mdc`: Best practices for Android SDK usage
- `android-memory-management.mdc`: Memory optimization strategies for Android
- `jetpack-compose.mdc`: Modern UI development with Jetpack Compose

### Build

Rules related to build systems and continuous integration:

- `gradle.mdc`: Build system configuration and optimization
- `github-actions.mdc`: CI/CD pipelines for Android projects

### Testing

Rules for testing and quality assurance:

- `junit.mdc`: Testing patterns and practices
- `test-driven-development.mdc`: TDD approach for Android development

### Development

Rules for development workflows and tools:

- `api-debugging.mdc`: Techniques for debugging API interactions
- `log-checking.mdc`: Effective logging practices
- `problem-solving.mdc`: Systematic approaches to problem-solving
- `bash.mdc`: Shell scripting for Android development
- `auto-format.mdc`: Code formatting standards

### Documentation

Rules for documentation and planning:

- `documentation-reference.mdc`: Documentation standards
- `git-commit-standards.mdc`: Version control best practices
- `plan-updates.mdc`: Guidelines for planning and implementing app updates

### Monitoring

Rules for monitoring and error tracking:

- `sentry.mdc`: Error tracking and monitoring

## Organization Rationale

1. **Logical Grouping**: Files are organized based on their primary function or domain.
2. **Discoverability**: Categories make it easier to locate specific rules.
3. **Modularity**: Each category can be updated or extended independently.
4. **Hierarchy**: Categories progress from foundational (Core) to more specialized (Monitoring).
5. **Integration**: The structure aligns with typical Android development workflow.