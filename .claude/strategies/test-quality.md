# Test Quality Standards

## Philosophy

Tests must validate functionality, not achieve coverage numbers. The goal is meaningful functional validation that ensures code works correctly, not metrics gaming that provides false confidence.

## Anti-Patterns to Detect and Prevent

### 1. Coverage-Driven File Naming
❌ **Prohibited Patterns:**
- `*CoverageTest.java`
- `*TestCoverage.java` 
- `*BoostTest.java`
- `QuickWinsTest.java`

✅ **Correct Patterns:**
- `UserManagementTest.java`
- `NutritionTrackingTest.java`
- `MedicineInteractionsTest.java`

### 2. Mock Saturation Testing
❌ **Prohibited Patterns:**
- Tests with >3 `@Mock` annotations per test class
- Tests that use Mockito.when() for all dependencies without testing real integration
- Pure mocking tests that only verify() method calls, not functionality

✅ **Correct Patterns:**
- Integration tests with @SpringBootTest and real database operations
- Unit tests with minimal, focused mocking using @MockBean or @Mock
- Tests that validate actual business logic outcomes with assertions

### 3. Meaningless Assertions
❌ **Prohibited Patterns:**
```java
@Test
public void testServiceInitialization() {
    SomeService service = new SomeService();
    assertNotNull(service);  // Meaningless
}

@Test
public void testHasMethod() {
    SomeClass obj = new SomeClass();
    assertTrue(obj.getClass().getDeclaredMethods().length > 0);  // No validation
}
```

✅ **Correct Patterns:**
```java
@Test
public void testServiceCalculatesCorrectly() {
    SomeService service = new SomeService();
    Result result = service.calculate(inputData);
    assertEquals(expectedOutput, result);  // Validates functionality
}

@Test
public void testMethodHandlesEdgeCase() {
    SomeClass obj = new SomeClass();
    Result result = obj.method(edgeCaseInput);
    assertTrue(result.isValid());  // Validates behavior
}
```

### 4. Redundant Test Files
❌ **Prohibited Patterns:**
- Multiple `*Test.java` files for same component
- `UserRepositoryTest.java`, `UserRepositoryExtendedTest.java`, `UserRepositoryCoverageTest.java`

✅ **Correct Patterns:**
- One comprehensive test class per major component
- Organized by architectural layer: `repository/`, `service/`, `controller/` test packages

### 5. API Mismatch Testing
❌ **Prohibited Patterns:**
- Testing methods that don't exist in current codebase
- Using outdated constructor signatures
- Testing deprecated interfaces

✅ **Correct Patterns:**
- Tests aligned with current API implementation
- Regular validation that tests match actual code
- Update tests when APIs evolve, don't ignore failures

## Quality Metrics Beyond Coverage

### Functional Test Ratio
Target: >80% of tests should be integration or functional tests
```
Functional Tests / Total Tests > 0.8
```

### Mock Dependency Ratio  
Target: <10% of tests should use heavy mocking
```
Tests with >3 mocks / Total Tests < 0.1
```

### Test Effectiveness Score
Target: >95% of tests should fail when code breaks
```
Tests that fail when functionality breaks / Total Tests > 0.95
```

### Coverage Quality Score
Target: >85% of coverage should come from functional tests
```
Lines covered by functional tests / Total coverage > 0.85
```

## Test Development Process

1. **Start with failing tests** that describe expected behavior
2. **Write minimal code** to make tests pass
3. **Refactor** both code and tests for clarity
4. **Ensure tests fail** when functionality is broken
5. **Validate real integration** over mocked interactions

## Quality Gate Integration

These standards should be enforced through automated quality gates:

- **Pre-commit hooks** that detect anti-patterns
- **CI/CD validation** that blocks problematic test patterns
- **Coverage quality analysis** beyond percentage metrics
- **Test effectiveness measurement** through mutation testing or similar

## Enforcement Priority

1. **High Priority**: File naming patterns, API mismatches
2. **Medium Priority**: Mock saturation, redundant files  
3. **Low Priority**: Assertion quality (harder to automate)

The goal is preventing "coverage theater" while promoting meaningful functional validation that genuinely improves code reliability and maintainability.