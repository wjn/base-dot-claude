# Test Quality Standards ## Philosophy Tests must validate functionality, not achieve coverage numbers. The goal is meaningful functional validation that ensures code works correctly, not metrics gaming that provides false confidence. ## Anti-Patterns to Detect and Prevent ### 1. Coverage-Driven File Naming
❌ **Prohibited Patterns:**
- `test_coverage_*.py`
- `test_*_coverage.py` - `test_*_boost.py`
- `test_quick_wins.py` ✅ **Correct Patterns:**
- `test_user_management.py`
- `test_nutrition_tracking.py`
- `test_medicine_interactions.py` ### 2. Mock Saturation Testing
❌ **Prohibited Patterns:**
- Tests with >3 `@patch` decorators
- Tests that mock all dependencies without testing real integration
- Pure mocking tests that validate method calls, not functionality ✅ **Correct Patterns:**
- Integration tests with real database operations
- Unit tests with minimal, focused mocking
- Tests that validate actual business logic outcomes ### 3. Meaningless Assertions
❌ **Prohibited Patterns:**
```python
def test_service_initialization(): service = SomeService() assert service is not None # Meaningless def test_has_method(): obj = SomeClass() assert hasattr(obj, 'method') # No validation
``` ✅ **Correct Patterns:**
```python
def test_service_calculates_correctly(): service = SomeService() result = service.calculate(input_data) assert result == expected_output # Validates functionality def test_method_handles_edge_case(): obj = SomeClass() result = obj.method(edge_case_input) assert result.is_valid() # Validates behavior
``` ### 4. Redundant Test Files
❌ **Prohibited Patterns:**
- Multiple `test_[component]_*.py` files for same component
- `test_repository_user.py`, `test_user_repository_extended.py`, `test_user_repository_coverage.py` ✅ **Correct Patterns:**
- One comprehensive test file per major component
- Organized by architectural layer: `test_repositories/`, `test_services/`, `test_api/` ### 5. API Mismatch Testing
❌ **Prohibited Patterns:**
- Testing methods that don't exist in current codebase
- Using outdated constructor signatures
- Testing deprecated interfaces ✅ **Correct Patterns:**
- Tests aligned with current API implementation
- Regular validation that tests match actual code
- Update tests when APIs evolve, don't ignore failures ## Quality Metrics Beyond Coverage ### Functional Test Ratio
Target: >80% of tests should be integration or functional tests
```
Functional Tests / Total Tests > 0.8
``` ### Mock Dependency Ratio Target: <10% of tests should use heavy mocking
```
Tests with >3 mocks / Total Tests < 0.1
``` ### Test Effectiveness Score
Target: >95% of tests should fail when code breaks
```
Tests that fail when functionality breaks / Total Tests > 0.95
``` ### Coverage Quality Score
Target: >85% of coverage should come from functional tests
```
Lines covered by functional tests / Total coverage > 0.85
``` ## Test Development Process 1. **Start with failing tests** that describe expected behavior
2. **Write minimal code** to make tests pass
3. **Refactor** both code and tests for clarity
4. **Ensure tests fail** when functionality is broken
5. **Validate real integration** over mocked interactions ## Quality Gate Integration These standards should be enforced through automated quality gates: - **Pre-commit hooks** that detect anti-patterns
- **CI/CD validation** that blocks problematic test patterns
- **Coverage quality analysis** beyond percentage metrics
- **Test effectiveness measurement** through mutation testing or similar ## Enforcement Priority 1. **High Priority**: File naming patterns, API mismatches
2. **Medium Priority**: Mock saturation, redundant files 3. **Low Priority**: Assertion quality (harder to automate) The goal is preventing "coverage theater" while promoting meaningful functional validation that genuinely improves code reliability and maintainability.