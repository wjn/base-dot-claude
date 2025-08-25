# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

An AI-powered fitness and wellness coach with advanced medical tracking capabilities, specifically designed for users with complex health needs including post-thyroidectomy management. The system includes both a CLI fitness coach and an MCP (Model Context Protocol) server for integration with AI assistants.

## Essential Commands

### Development Environment Setup
```bash
# Activate virtual environment (ALWAYS use this first)
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -e .
pip install -e ".[dev]"  # For development dependencies
```

### Running the Application
```bash
# MCP CLI Wrapper (RECOMMENDED for development/testing)
./fitness-mcp.py --help
./fitness-mcp.py meal log "test meal" --type snack --time 14:00
./fitness-mcp.py dashboard nutrition

# CLI Fitness Coach (Interactive)
fitness-coach

# MCP Server Mode (for Claude Code integration)
python mcp_fitness_server.py

# Test MCP server startup
./venv/bin/python test_mcp_server_startup.py
```

### Testing Commands
```bash
# Run all tests (MUST use virtual environment)
./venv/bin/pytest tests/ -v

# Run specific test file
./venv/bin/pytest tests/test_medicine_repository_coverage.py -v

# Run with coverage
./venv/bin/pytest --cov=src --cov-report=term-missing tests/

# QUALITY GATE: Run tests with coverage enforcement (85% minimum)
./scripts/quality_gate.py

# QUALITY GATE: Temporarily lower threshold for development
COVERAGE_THRESHOLD=60 ./scripts/quality_gate.py

# Run specific test
./venv/bin/pytest tests/test_medicine_repository.py::TestMedicineRepository::test_create_medicine -xvs

# Test categories
./venv/bin/pytest -m unit        # Unit tests only
./venv/bin/pytest -m integration # Integration tests only
./venv/bin/pytest -m "not slow"  # Skip slow tests
```

### Code Quality & Linting
```bash
# PEP 8 compliance check (maintain >90% rating)
./venv/bin/python -m flake8 src/ tests/

# Format code with Black
./venv/bin/python -m black src/ tests/

# Type checking
./venv/bin/python -m mypy src/
```

### Database Management
```bash
# Database location
sqlite3 fitness_tracker.db

# Run migrations
./venv/bin/python -m alembic upgrade head

# Database initialization happens automatically via DatabaseManager.init_database()
```

## CLI Tools Available

### MCP CLI Wrapper (`fitness-mcp.py`)
**RECOMMENDED** for development and testing. Provides direct CLI access to all MCP functionality:

```bash
# Meal logging with precise timing (fixes MCP server timing issues)
./fitness-mcp.py meal log "protein shake" --type snack --time 14:00

# Full nutrition dashboard (same as MCP server output)
./fitness-mcp.py dashboard nutrition

# Health tracking
./fitness-mcp.py track weight 175 --unit lbs
./fitness-mcp.py track water 64 --unit oz

# Medicine management  
./fitness-mcp.py medicine log "vitamin D"
./fitness-mcp.py medicine create "magnesium" "400mg" --category mineral

# User management
./fitness-mcp.py user info
./fitness-mcp.py user create "Test User" 30 male 75 180 moderately_active
```

**Benefits over MCP server:**
- Direct command execution (no Claude Code required)
- Time-specific meal logging works correctly
- Batch operation capability
- Full access to nutrition dashboards and visualizations
- Perfect for testing and automation

See `docs/CLI_WRAPPER.md` for complete documentation.

## Architecture & Key Components

### Core Architecture Pattern
The codebase follows a **Repository Pattern** with async/await throughout:
- **Models** (`src/fitness_coach/models.py`): SQLAlchemy ORM models
- **Repositories** (`src/fitness_coach/repositories/`): Data access layer with async operations
- **Services** (`src/fitness_coach/services/`): Business logic layer
- **Database** (`src/fitness_coach/database.py`): Database management and session handling
- **MCP Server** (`mcp_fitness_server.py`): Model Context Protocol server for AI integration

### Critical Files for Understanding the System

1. **`mcp_fitness_server.py`**: Main MCP server implementation
   - Tool definitions and handlers
   - Global state management (current_user_id)
   - Integration point for all fitness tracking features

2. **`src/fitness_coach/models.py`**: All database models
   - UserProfile, MealEntry, ExerciseEntry, Medicine tracking
   - Thyroid tracking models for post-thyroidectomy users
   - Unit preferences for metric/imperial conversion

3. **`src/fitness_coach/repositories/base.py`**: Base repository pattern
   - AsyncRepositoryBase with generic CRUD operations
   - FilterBuilder for complex queries
   - All repositories inherit from this

4. **`src/fitness_coach/services/unit_converter.py`**: Unit conversion system
   - Handles metric ↔ imperial conversions
   - User preference-based display formatting

5. **`src/fitness_coach/core/datetime_utils.py`**: Centralized datetime handling
   - **MANDATORY**: ALL datetime operations must use this module
   - Consistent timezone handling (America/Chicago)
   - Functions: `get_local_now()`, `get_local_date()`, `format_time_for_display()`
   - NO ad hoc datetime imports - always use these utilities

### MCP Server Integration Points

The MCP server exposes tools for:
- User profile management
- Nutrition tracking (meals, macros, calories)
- Exercise logging with heart rate zones
- Medicine management with interaction checking
- Weight and telemetry tracking
- Visualization dashboards
- Unit preference management

### Database Schema Key Relationships
```
UserProfile (1) → (*) MealEntry
UserProfile (1) → (*) ExerciseEntry  
UserProfile (1) → (*) Medicine/MedicineGroup
UserProfile (1) → (1) UnitPreferences
UserProfile (1) → (*) TelemetryData
```

## Important Medical Safety Features

### Synthroid/Levothyroxine Tracking
- Enforces 30-60 minute empty stomach requirement
- Tracks 4-hour separation from calcium/iron
- Monitors coffee interactions (1-hour window)
- Detects soy product interference (40% absorption reduction)

### Medicine Interaction System
Located in `src/fitness_coach/services/medicine_interaction_checker.py`:
- Drug-drug interactions
- Drug-food interactions
- Timing validation
- Automatic warnings in medicine logs

## Data Storage Locations

- **SQLite Database**: `fitness_tracker.db` (main data store)
- **Apple Health Import**: `data/healthdata/apple_health_export/export.xml`
- **Test Database**: Uses in-memory SQLite for tests
- **Cache**: Redis-based caching with circuit breaker pattern

## Testing Strategy

### Test Organization
- `tests/test_repository_*.py`: Repository layer tests
- `tests/test_service_*.py`: Service layer tests  
- `tests/test_medicine_*.py`: Medicine-specific features
- `tests/test_mcp_*.py`: MCP server integration tests

### Coverage Requirements
- Maintain >85% test coverage
- All new features require corresponding tests
- Use pytest fixtures for common test data

## Test Quality Philosophy - MANDATORY

### Test-Driven Development vs Coverage-Driven Development
- ✅ **DO**: Write tests that validate business logic, edge cases, and user workflows
- ❌ **DON'T**: Write tests just to increase coverage percentages
- ✅ **DO**: Start with failing tests that describe expected behavior
- ❌ **DON'T**: Create "coverage_*" test files that mock everything without testing anything

### Meaningful Test Criteria
Tests must demonstrate actual functionality:
- **Integration tests**: Validate real database operations, API endpoints, user workflows
- **Unit tests**: Test specific business logic, edge cases, error conditions  
- **Behavioral tests**: Verify system responds correctly to various inputs
- **No pure mocking**: Avoid tests that mock all dependencies and test nothing real

### Quality Over Quantity Standards
- 85% coverage achieved through FUNCTIONAL tests, not padding
- Every test must have a clear purpose beyond coverage
- Tests should fail when the code they're testing breaks
- No "test_*_exists" or "test_*_initialization" without real validation

### Test File Organization Standards
- Group tests by architectural layer: `test_repositories/`, `test_services/`, `test_api/`
- Name files by functionality: `test_user_management.py`, not `test_coverage_boost.py`
- One comprehensive test suite per major component
- Integration tests preferred over heavily mocked unit tests

## Common Development Patterns

### Adding New MCP Tools
1. Add tool definition in `list_tools()` function
2. Implement handler in `call_tool()` function  
3. Use global `current_user_id` for user context
4. Return `TextContent` objects with formatted responses

### Repository Pattern Usage
```python
# All repositories follow this pattern:
async with self.get_session() as session:
    # Perform database operations
    result = await session.execute(query)
    return result.scalars().all()
```

### Error Handling
- Use `handle_database_error()` for database exceptions
- Custom exceptions in `src/fitness_coach/core/exceptions.py`
- MCP tools should catch and return user-friendly error messages

## Working with Apple Health Data

Import scripts located in `scripts/`:
- `import_apple_health_weight.py`: Import weight history
- `clean_weight_data.py`: Remove erroneous entries
- `analyze_weight_history.py`: Generate weight analytics

## Unit Preferences System

Users can set preferences for:
- Weight: kg/lbs/oz
- Height: cm/in/ft  
- Distance: km/mi
- Volume: L/oz/cups/ml
- Temperature: C/F
- Energy: kcal/kJ

Conversion happens automatically in dashboards and displays.

## Strategy Documents

Critical strategies are defined in `.claude/strategies/`:
- **code-quality.md**: PEP 8 compliance (>90%), refactoring requirements
- **reliability.md**: Testing requirements, error handling
- **test-quality.md**: Test quality standards, anti-pattern detection
- **documentation.md**: Documentation standards
- **security.md**: Security practices for medical data

## Test Development Standards

- **General Standards**: `.claude/strategies/test-quality.md` - Universal test quality principles
- **Project Implementation**: `docs/development/test-standards-implementation.md` - Fitness coach specific patterns

## Development Workflow Requirements - MANDATORY QUALITY ENFORCEMENT

⚠️ **CRITICAL: ALL development must follow mandatory quality gates - NO BYPASSES ALLOWED**

### Quality-First Development Process:

1. **Start Development Session (REQUIRED)**:
   ```bash
   source venv/bin/activate  # Always first
   ./scripts/dev_workflow.py start  # Validates environment & installs git hooks
   ```

2. **During Development**:
   ```bash
   ./scripts/dev_workflow.py check  # Quick quality check (run frequently)
   ```

3. **Before ANY Commit (MANDATORY)**:
   ```bash
   ./scripts/dev_workflow.py commit  # Full quality gate - CANNOT BE BYPASSED
   ```

4. **Simulate CI Locally**:
   ```bash
   ./scripts/dev_workflow.py ci  # Test full GitHub Actions pipeline
   ```

### Mandatory Quality Standards:
- **100% Test Pass Rate**: ALL tests must pass (zero tolerance)
- **85% Test Coverage**: No regressions in coverage allowed  
- **90% PEP 8 Compliance**: Code quality standards enforced
- **Import Validation**: All dependencies must work correctly
- **Security Scan**: Basic security issue detection

### Automated Enforcement:
- **Pre-commit hooks**: Block commits that fail quality standards
- **GitHub Actions**: CI/CD pipeline enforces all standards
- **No bypass mechanisms**: Quality gates cannot be disabled or skipped

### Quality Gate Integration:
```bash
# Quality gate commands (in priority order)
./scripts/mandatory_quality_gate.py  # Full mandatory quality check
./scripts/quality_gate.py           # Legacy quality check
./scripts/dev_workflow.py commit    # Development workflow integration
```

⚠️ **Breaking Changes Policy**: Any code change that breaks tests, reduces coverage, or violates quality standards will be automatically rejected.

## Known Issues & Workarounds

- **Asyncio Event Loop**: Fixed in cache.py - avoid using `asyncio.run()` in MCP context
- **Session Management**: Always extract data from SQLAlchemy objects before session closes
- **Apple Health Import**: Filter data <160 lbs as erroneous
- **Nutrition Estimation**: AI may underestimate complex meals - verify calorie counts