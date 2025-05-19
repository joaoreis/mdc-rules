# Android Development MDC Rules

This directory contains MDC (Machine Directed Comments) rules specifically for Android application
development.

## Available Rules

### Android SDK

- **File:** [android-sdk.mdc](android-sdk.mdc)
- **Description:** Comprehensive best practices for Android SDK development covering architecture,
  performance, security, and testing.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/android-sdk.mdc)

### Android Memory Management

- **File:** [android-memory-management.mdc](android-memory-management.mdc)
- **Description:** Guidelines for memory management in Android applications to prevent leaks and
  improve performance.
- **Source:** Based
  on [Mawla/cursor_rules](https://github.com/Mawla/cursor_rules/blob/main/.cursor/rules/memory-management.mdc)
  but customized for Android-specific concerns.

### Jetpack Compose

- **File:** [jetpack-compose.mdc](jetpack-compose.mdc)
- **Description:** Best practices and coding standards for developing Android UI with Jetpack
  Compose, ensuring maintainable, performant, and accessible applications.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/jetpack-compose.mdc)

## Usage

These rules are applied to Kotlin and Java files in Android projects. They provide guidance for:

1. **Architecture:** Following best practices for structuring Android applications
2. **Performance:** Optimizing application performance and memory usage
3. **UI Development:** Creating robust and accessible user interfaces with Jetpack Compose
4. **Security:** Implementing proper security measures to protect user data
5. **Testing:** Effectively testing Android applications

## Dependencies

- Android Studio 2023.3 or newer
- Android Gradle Plugin 8.0.0+
- For Jetpack Compose rules: Compose version 1.5.0+