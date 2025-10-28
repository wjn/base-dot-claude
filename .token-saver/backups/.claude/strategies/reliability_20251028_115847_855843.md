# Reliability

## Testing

- All development should be test driven. This means we start with tests for new work or adding features.
- We ALWAYS run the entire test suite after making changes to prove no regressions have occurred.
- 85% test coverage is a minimum (using JaCoCo for coverage reporting)
- We start and end with tests in our development process.
- Tests should be run in parallel to support the fastest execution time.

  - If tests cannot run in parallel they should be segmented out, such that the tests in the segment run sequentially.
  - The segments themselves are run in parallel with the other tests.

- For JUnit/TestNG we should always be running tests through Maven or Gradle build systems.
- We do not ignore or suppress tests, warnings, or errors using @Ignore, @Disabled, or @SuppressWarnings.
- We fix root causes rather than just making tests pass.
- Goal for tests: the entire test suite runs with no errors, warnings, or failures and coverage is minimum 85%.
- We do not disable tests, test files, or test suites. We fix the root issues causing problems for those.

### Requirements for Running Test Suites
- Use designated build commands to prevent system resource exhaustion
- **Maven**: Use `mvn clean test` or `mvn clean verify` for integration tests
- **Gradle**: Use `gradle clean test` or `gradle clean check` for full validation
- **Spring Boot**: Use `mvn spring-boot:test` or `gradle bootTest` for Spring applications
- These commands enforce proper JVM memory allocation and fork settings to prevent OutOfMemoryError
- AI instances should coordinate test execution to avoid simultaneous resource-intensive operations
- Use `-DforkCount=1` for Maven Surefire or `maxParallelForks = 1` for Gradle when resource constrained

TODO: update to use the tools/quality app given it will generate reports.

### Triaging Failed Tests

- Whenever there are failing tests we want to resolve those failures by addressing the root cause causing the failure
- We don't just want to quiet the testing system and thereby swallow errors, failures, or warnings
- You should use the testing output AND the logs in the logs/ directory, e.g., application.log or test-output.log.
- The simpler resolution generally always should be preferred.

## Test Quality Requirements

### Functional Test Priority
- Tests must validate real functionality, not just code paths
- Integration tests preferred over heavily mocked unit tests
- Each test must have clear business value beyond coverage metrics
- "Coverage theater" tests that mock everything are prohibited

### Test Development Process
- Start with failing tests that describe expected behavior
- Write minimal code to make tests pass
- Refactor both code and tests for clarity
- Ensure tests fail appropriately when functionality breaks

### Test Failure Analysis Protocol
- Failing tests indicate real problems, not test issues  
- Fix the code/system, not the test (unless test is genuinely incorrect)
- Never disable tests to make CI green - fix root causes
- Investigate why existing tests didn't catch regressions

## Vigiliant Resiliency

- Reliability should be proactive, we seek to find and expose problems in the work we're doing.
- We're curious about edge cases and prove them out with tests.
- If there's opportunity to create failure states that are "less bad" then we should prefer those.
- Retries, load shedding, and high-quality health checks are basic and required.
- We prefer simplicity and clarity
- Handling errors is critical, we seek to guide failures that cannot be prevented to "less bad" outcomes.



