# Monitoring MDC Rules

This directory contains MDC (Machine Directed Comments) rules for monitoring and error tracking in
Android applications.

## Available Rules

### Sentry

- **File:** [sentry.mdc](sentry.mdc)
- **Description:** Best practices for integrating and using Sentry for error tracking and monitoring
  in Android applications.
- **Source:
  ** [sanjeed5/awesome-cursor-rules-mdc](https://github.com/sanjeed5/awesome-cursor-rules-mdc/blob/main/rules-mdc/sentry.mdc)

## Usage

These rules provide guidance for:

1. **Error Tracking:** Capturing and monitoring exceptions and errors in your Android applications
2. **Performance Monitoring:** Tracking application performance metrics and identifying bottlenecks
3. **User Session Monitoring:** Tracking user sessions and user actions to identify issues affecting
   users
4. **Debugging:** Using monitoring tools to troubleshoot issues in production

## Integration with Development Workflow

- **Automatic Error Reporting:** Automatically capture uncaught exceptions and send them to
  monitoring services
- **Custom Error Tracking:** Add custom context and metadata to error reports
- **Performance Tracking:** Monitor application performance metrics in production

## Dependencies

- Sentry Android SDK (io.sentry:sentry-android)
- For specific integrations:
    - io.sentry:sentry-timber (Timber integration)
    - io.sentry:sentry-compose-android (Jetpack Compose integration)
    - io.sentry:sentry-okhttp (OkHttp integration)
    - io.sentry:sentry-fragment (Fragment integration)