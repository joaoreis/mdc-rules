# MDC Rules Inventory

## Overview

This document tracks all MDC rules in the repository, their categories, file patterns, and testing
status. Rules are sorted by category, with simpler rules listed first and Android-specific rules
last.

## Rules Status Summary

- Total Rules: 19
- Rules Tested: 1
- Rules Pending: 18

## Testing Notes

- Rules must be tested in separate Firebender conversations
- Changes to firebender.json only take effect when starting a new conversation
- Use test-workflow.sh script to guide through the complete testing process

## Detailed Inventory

### Core Rules

| Rule Name            | File Path                                     | File Patterns | Status          | Configuration Requirements |
|----------------------|-----------------------------------------------|---------------|-----------------|----------------------------|
| Code Guidelines      | .firebender/mdc/core/code-guidelines.mdc      | *             | COMPLETED ★★★★★ | None                       |
| Meta Rule Management | .firebender/mdc/core/meta-rule-management.mdc | **/*          | IN_PROGRESS     | None                       |

### Documentation Rules

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| Documentation Reference | .firebender/mdc/documentation/documentation-reference.mdc | **/* | NOT_STARTED | None |
| Git Commit Standards | .firebender/mdc/documentation/git-commit-standards.mdc | **/* | NOT_STARTED | None |
| Plan Updates | .firebender/mdc/documentation/plan-updates.mdc | **/*.gradle*\|**/*.toml | NOT_STARTED | None |

### Development Rules

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| Problem Solving | .firebender/mdc/development/problem-solving.mdc | **/*.kt | NOT_STARTED | None |
| API Debugging | .firebender/mdc/development/api-debugging.mdc | **/* | NOT_STARTED | None |
| Log Checking | .firebender/mdc/development/log-checking.mdc | **/* | NOT_STARTED | None |
| Auto Format | .firebender/mdc/development/auto-format.mdc | **/* | NOT_STARTED | None |
| Bash | .firebender/mdc/development/bash.mdc | **/*.sh | NOT_STARTED | None |

### Build Tools Rules

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| Gradle | .firebender/mdc/build-tools/gradle.mdc | **/*.gradle*\|**/*.toml | NOT_STARTED | None |
| GitHub Actions | .firebender/mdc/build-tools/github-actions.mdc | **/*.yml\|**/*.yaml | NOT_STARTED | None |

### Testing Rules

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| JUnit | .firebender/mdc/testing/junit.mdc | **/*Test.kt | NOT_STARTED | None |
| Test Driven Development | .firebender/mdc/testing/test-driven-development.mdc | **/*Test.kt | NOT_STARTED | None |

### Monitoring Rules

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| Sentry | .firebender/mdc/monitoring/sentry.mdc | **/* | NOT_STARTED | Possibly requires Sentry API keys |

### Android Rules (to be tested last)

| Rule Name | File Path | File Patterns | Status | Configuration Requirements |
|-----------|-----------|--------------|--------|----------------------------|
| Android SDK | .firebender/mdc/android/android-sdk.mdc | **/*.kt, **/*.java, **/*.gradle, **/*.gradle.kts | NOT_STARTED | Android SDK setup |
| Android Memory Management | .firebender/mdc/android/android-memory-management.mdc | **/*.kt | NOT_STARTED | Android SDK setup |
| Jetpack Compose | .firebender/mdc/android/jetpack-compose.mdc | **/*.kt | NOT_STARTED | Android SDK, Jetpack Compose |