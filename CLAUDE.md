# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Python-based application template with comprehensive testing, quality gates, and best practices for building reliable, maintainable software systems using modern Python development standards.

## Essential Commands

### Development Environment Setup
```bash
# Python version check (requires Python 3.8+)
python --version
python3 --version

# Virtual environment setup (ALWAYS use this first)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
pip install -e .  # For editable installation
pip install -e ".[dev]"  # For development dependencies
```

### Running the Application
```bash
# Run main application
python main.py
python -m app

# Run with specific configuration
python main.py --config config.yaml
python main.py --env production

# Run Flask/FastAPI development server
flask run
uvicorn app.main:app --reload

# Run Django development server
python manage.py runserver
```

### Testing Commands
```bash
# Run all tests
pytest
pytest tests/ -v

# Run specific test file
pytest tests/test_user_service.py -v

# Run specific test
pytest tests/test_user_service.py::TestUserService::test_create_user -xvs

# Run with coverage
pytest --cov=src --cov-report=term-missing
pytest --cov=app --cov-report=html

# QUALITY GATE: Run tests with coverage enforcement (85% minimum)
pytest --cov=src --cov-fail-under=85

# Run tests by marker
pytest -m unit        # Unit tests only
pytest -m integration # Integration tests only
pytest -m "not slow"  # Skip slow tests

# Run tests in parallel
pytest -n auto  # Requires pytest-xdist

# Run with different test runners
python -m unittest discover
nose2
tox
```

### Code Quality & Linting
```bash
# PEP 8 compliance check
flake8 src/ tests/
pylint src/ tests/

# Type checking
mypy src/
pytype src/

# Security scanning
bandit -r src/
safety check

# Code formatting
black src/ tests/
autopep8 --in-place --recursive src/
yapf -i -r src/

# Import sorting
isort src/ tests/

# All quality checks at once
pre-commit run --all-files
tox -e quality
```

### Database Management
```bash
# SQLAlchemy migrations (Alembic)
alembic init alembic
alembic revision --autogenerate -m "Description"
alembic upgrade head
alembic downgrade -1

# Django migrations
python manage.py makemigrations
python manage.py migrate
python manage.py showmigrations

# Database console access
python manage.py dbshell  # Django
flask db-shell  # Flask

# SQLite direct access
sqlite3 database.db
```

## Architecture & Key Components

### Core Architecture Pattern
The codebase follows **Clean Architecture** with clear separation of concerns:
- **API Layer** (`src/api/` or `app/api/`): REST/GraphQL endpoints, request/response handling
- **Service Layer** (`src/services/` or `app/services/`): Business logic and orchestration
- **Repository Layer** (`src/repositories/` or `app/repositories/`): Data access abstraction
- **Domain/Model Layer** (`src/models/` or `app/models/`): Entity classes and domain logic
- **Infrastructure** (`src/infrastructure/`): External service integrations
- **Configuration** (`src/config/` or `config/`): Application settings and environment config

### Critical Files for Understanding the System

1. **`requirements.txt` or `pyproject.toml`**: Dependencies and project metadata
   - Production dependencies
   - Development dependencies
   - Optional dependencies by feature

2. **`setup.py` or `setup.cfg`**: Package configuration
   - Entry points
   - Package metadata
   - Distribution settings

3. **`config.py` or `settings.py`**: Application configuration
   - Environment-specific settings
   - Database configuration
   - External service credentials

4. **`main.py` or `app.py`**: Application entry point
   - Application initialization
   - Middleware configuration
   - Route registration

5. **`conftest.py`**: Pytest configuration and fixtures
   - Test database setup
   - Mock configurations
   - Shared test utilities

### Framework Integration Points

The application supports multiple frameworks:

#### FastAPI
- **Routes**: `@app.get()`, `@app.post()`, etc.
- **Dependency Injection**: `Depends()`
- **Validation**: Pydantic models
- **Async Support**: `async def` endpoints

#### Flask
- **Blueprints**: Modular route organization
- **Extensions**: Flask-SQLAlchemy, Flask-Migrate
- **Context**: Application and request contexts

#### Django
- **URLs**: URLconf patterns
- **Views**: Class-based and function-based views
- **ORM**: Django models and QuerySets
- **Middleware**: Request/response processing pipeline

### Database Schema Key Relationships
```
User (1) → (*) Post
Post (1) → (*) Comment
User (1) → (*) Role (Many-to-Many)
Category (1) → (*) Post
```

## Test-Driven Development (TDD)

### TDD Workflow (RED-GREEN-REFACTOR)
1. **RED**: Write a failing test first
   ```python
   def test_user_creation():
       user = create_user("john@example.com", "password123")
       assert user.email == "john@example.com"
       assert user.is_active is True
   ```

2. **GREEN**: Write minimal code to pass
   ```python
   def create_user(email: str, password: str) -> User:
       return User(email=email, is_active=True)
   ```

3. **REFACTOR**: Improve code while tests pass
   ```python
   def create_user(email: str, password: str) -> User:
       validate_email(email)
       hashed_password = hash_password(password)
       return User(email=email, password=hashed_password, is_active=True)
   ```

### TDD Best Practices
- **Write test first, code second** - Never write production code without a failing test
- **One test, one assertion** - Keep tests focused and specific
- **Test behavior, not implementation** - Tests should survive refactoring
- **YAGNI (You Ain't Gonna Need It)** - Only implement what tests require
- **Fast feedback loop** - Tests should run in milliseconds
- **Test isolation** - Each test should be independent

### TDD Testing Pyramid
```
         /\
        /  \  E2E Tests (5%)
       /    \  - User journeys
      /------\  Integration Tests (15%)
     /        \  - API, Database
    /----------\  Unit Tests (80%)
   /            \  - Business logic
  /--------------\
```

### BDD with pytest-bdd
```gherkin
Feature: User Registration
    Scenario: Successful registration
        Given I am on the registration page
        When I enter valid credentials
        Then I should be registered successfully
        And receive a welcome email
```

## Testing Strategy

### Test Organization
- `tests/unit/`: Unit tests for individual functions/methods
- `tests/integration/`: Integration tests with database/external services
- `tests/e2e/`: End-to-end tests simulating user workflows
- `tests/fixtures/`: Shared test data and fixtures
- `tests/conftest.py`: Pytest configuration and fixtures

### Testing Frameworks
- **pytest**: Primary testing framework
- **unittest**: Standard library testing (legacy support)
- **pytest-mock**: Enhanced mocking capabilities
- **pytest-asyncio**: Async test support
- **pytest-bdd**: Behavior-driven development
- **hypothesis**: Property-based testing
- **pytest-benchmark**: Performance testing
- **factory_boy**: Test data factories
- **faker**: Realistic test data generation

### Coverage Requirements
- Maintain >85% test coverage
- All new features require corresponding tests
- Use fixtures for test data management
- Mock external dependencies appropriately
- Test both success and error paths
- Coverage reports in multiple formats (term, html, xml)

## Common Development Patterns

### Repository Pattern
```python
class UserRepository:
    def __init__(self, db_session):
        self.session = db_session
    
    async def get_by_id(self, user_id: int) -> Optional[User]:
        return await self.session.query(User).filter_by(id=user_id).first()
    
    async def create(self, user_data: dict) -> User:
        user = User(**user_data)
        self.session.add(user)
        await self.session.commit()
        return user
```

### Service Layer Pattern
```python
class UserService:
    def __init__(self, user_repository: UserRepository):
        self.repository = user_repository
    
    async def create_user(self, user_data: UserCreateDTO) -> UserResponseDTO:
        # Business logic and validation
        user = await self.repository.create(user_data.dict())
        return UserResponseDTO.from_orm(user)
```

### Error Handling
```python
class AppException(Exception):
    """Base application exception"""
    pass

class ValidationError(AppException):
    """Validation error exception"""
    pass

@app.exception_handler(ValidationError)
async def validation_error_handler(request, exc):
    return JSONResponse(
        status_code=400,
        content={"detail": str(exc)}
    )
```

### Async/Await Patterns
```python
async def process_data(data_id: int):
    async with get_session() as session:
        data = await session.get(Data, data_id)
        result = await external_api.process(data)
        return result
```

## Configuration Management

### Environment Variables
```python
# Using python-dotenv
from dotenv import load_dotenv
load_dotenv()

# Using pydantic settings
from pydantic import BaseSettings

class Settings(BaseSettings):
    database_url: str
    api_key: str
    debug: bool = False
    
    class Config:
        env_file = ".env"
```

### Configuration Profiles
- `development`: Local development with SQLite
- `testing`: Test configuration with in-memory database
- `staging`: Pre-production environment
- `production`: Production settings with optimizations

## Quality Standards

### Code Style
- PEP 8 compliance (enforced by flake8/black)
- Maximum line length: 88 characters (black default)
- Maximum function length: 50 lines
- Maximum cyclomatic complexity: 10
- Type hints for all public functions

### Static Analysis Rules
- Flake8: Zero violations
- Pylint: Score >9.0/10
- MyPy: No type errors in strict mode
- Bandit: No high-severity security issues

## Security Best Practices

- Input validation using Pydantic/Marshmallow
- SQL injection prevention with ORM/parameterized queries
- XSS prevention in template rendering
- CSRF protection in web frameworks
- Secure password hashing (bcrypt/argon2)
- Environment variables for secrets (never hardcode)
- Regular dependency updates (`pip-audit`, `safety`)
- Rate limiting and DDoS protection
- Proper authentication/authorization (JWT, OAuth2)

## Performance Optimization

### Database Optimization
- Connection pooling (SQLAlchemy pool_size)
- Query optimization (eager loading, select_related)
- Database indexing strategies
- Caching with Redis/Memcached
- Pagination for large datasets

### Application Performance
- Async/await for I/O operations
- Background tasks (Celery, RQ, FastAPI BackgroundTasks)
- Response caching strategies
- CDN for static assets
- Profile with cProfile/py-spy
- Memory profiling with memory_profiler

## Development Workflow Requirements

### Quality Gates (MANDATORY)
1. **Before ANY Commit**:
   ```bash
   # Run quality checks
   pre-commit run --all-files
   
   # Run tests with coverage
   pytest --cov=src --cov-fail-under=85
   
   # Type checking
   mypy src/
   ```

2. **Mandatory Standards**:
   - 100% Test Pass Rate
   - 85% Code Coverage minimum
   - PEP 8 compliance (flake8 clean)
   - Type hints for public APIs
   - No security vulnerabilities (bandit clean)

3. **Pre-commit Hooks Setup**:
   ```bash
   # Install pre-commit
   pip install pre-commit
   pre-commit install
   ```

## Dependency Management

### Package Management
```bash
# Update requirements
pip freeze > requirements.txt

# Use pip-tools for better dependency management
pip-compile requirements.in
pip-sync

# Poetry (alternative)
poetry add package
poetry update
poetry lock

# Pipenv (alternative)
pipenv install package
pipenv update
```

### Virtual Environment Best Practices
- Always use virtual environments
- Never commit venv/ directory
- Pin exact versions in requirements.txt
- Separate dev and production dependencies
- Regular security audits with `pip-audit`

## API Documentation

### Auto-generated Documentation
- **FastAPI**: Automatic OpenAPI/Swagger at `/docs`
- **Flask**: Flask-RESTX or Flasgger for Swagger
- **Django**: DRF with drf-spectacular
- **GraphQL**: GraphiQL or Apollo Studio

### Documentation Standards
- Docstrings for all public functions (Google/NumPy style)
- Type hints for better IDE support
- README with setup instructions
- API examples in documentation
- Changelog maintenance

## Robust Logging Architecture

### Logging Configuration
```python
import logging
import logging.config
import json
from pythonjsonlogger import jsonlogger

# Development configuration
LOGGING_CONFIG = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'detailed': {
            'format': '%(asctime)s - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s'
        },
        'json': {
            '()': 'pythonjsonlogger.jsonlogger.JsonFormatter',
            'format': '%(asctime)s %(name)s %(levelname)s %(message)s'
        }
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'level': 'INFO',
            'formatter': 'detailed',
            'stream': 'ext://sys.stdout'
        },
        'file': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'DEBUG',
            'formatter': 'json',
            'filename': 'logs/app.log',
            'maxBytes': 10485760,  # 10MB
            'backupCount': 5
        },
        'error_file': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'ERROR',
            'formatter': 'json',
            'filename': 'logs/errors.log',
            'maxBytes': 10485760,  # 10MB
            'backupCount': 5
        }
    },
    'loggers': {
        '': {  # root logger
            'level': 'DEBUG',
            'handlers': ['console', 'file', 'error_file']
        },
        'app': {
            'level': 'DEBUG',
            'handlers': ['console', 'file'],
            'propagate': False
        },
        'sqlalchemy.engine': {
            'level': 'WARNING',  # Reduce SQL noise
            'handlers': ['file'],
            'propagate': False
        }
    }
}

logging.config.dictConfig(LOGGING_CONFIG)
logger = logging.getLogger(__name__)
```

### Structured Logging Best Practices
```python
# Use structured logging for better parsing
logger.info(
    "User action completed",
    extra={
        "user_id": user.id,
        "action": "login",
        "ip_address": request.remote_addr,
        "duration_ms": elapsed_time,
        "metadata": {"browser": user_agent}
    }
)

# Context managers for request tracking
import contextvars
import uuid

request_id = contextvars.ContextVar('request_id', default=None)

class RequestIdFilter(logging.Filter):
    def filter(self, record):
        record.request_id = request_id.get()
        return True

# Add to all handlers
for handler in logging.root.handlers:
    handler.addFilter(RequestIdFilter())
```

### Log Levels and When to Use Them
- **DEBUG**: Detailed diagnostic information (variable values, function entry/exit)
- **INFO**: General informational messages (process started, configuration loaded)
- **WARNING**: Something unexpected but handled (deprecated feature used, retry attempted)
- **ERROR**: Error occurred but application continues (failed to send email, API call failed)
- **CRITICAL**: System is unusable (database connection lost, out of disk space)

### Performance Logging
```python
import time
import functools

def log_performance(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        try:
            result = func(*args, **kwargs)
            elapsed = (time.perf_counter() - start) * 1000
            logger.info(
                f"Function executed successfully",
                extra={
                    "function": func.__name__,
                    "duration_ms": elapsed,
                    "status": "success"
                }
            )
            return result
        except Exception as e:
            elapsed = (time.perf_counter() - start) * 1000
            logger.error(
                f"Function failed",
                extra={
                    "function": func.__name__,
                    "duration_ms": elapsed,
                    "status": "error",
                    "error": str(e)
                },
                exc_info=True
            )
            raise
    return wrapper
```

### Correlation IDs for Distributed Tracing
```python
from flask import g, request
import uuid

@app.before_request
def before_request():
    g.correlation_id = request.headers.get('X-Correlation-ID', str(uuid.uuid4()))
    request_id.set(g.correlation_id)
    logger.info(
        "Request started",
        extra={
            "correlation_id": g.correlation_id,
            "method": request.method,
            "path": request.path,
            "remote_addr": request.remote_addr
        }
    )

@app.after_request
def after_request(response):
    response.headers['X-Correlation-ID'] = g.correlation_id
    logger.info(
        "Request completed",
        extra={
            "correlation_id": g.correlation_id,
            "status_code": response.status_code,
            "content_length": response.content_length
        }
    )
    return response
```

### Security Logging (OWASP Guidelines)
```python
# Log security events without sensitive data
def log_security_event(event_type: str, user_id: str, details: dict):
    # Never log passwords, tokens, or PII
    safe_details = {k: v for k, v in details.items() 
                   if k not in ['password', 'token', 'ssn', 'credit_card']}
    
    logger.warning(
        f"Security event: {event_type}",
        extra={
            "event_type": event_type,
            "user_id": user_id,
            "details": safe_details,
            "timestamp": datetime.utcnow().isoformat()
        }
    )

# Examples of security events to log
log_security_event("failed_login", user_id, {"ip": ip, "attempts": 3})
log_security_event("privilege_escalation", user_id, {"role": "admin"})
log_security_event("data_export", user_id, {"records": 1000})
```

### Monitoring and Alerting Integration
```python
# Sentry integration for error tracking
import sentry_sdk
from sentry_sdk.integrations.logging import LoggingIntegration

sentry_logging = LoggingIntegration(
    level=logging.INFO,        # Capture info and above
    event_level=logging.ERROR  # Send errors as events
)

sentry_sdk.init(
    dsn="your-sentry-dsn",
    integrations=[sentry_logging],
    traces_sample_rate=0.1,
    environment="production"
)

# Custom metrics for monitoring
from prometheus_client import Counter, Histogram, Gauge

request_count = Counter('app_requests_total', 'Total requests', ['method', 'endpoint', 'status'])
request_duration = Histogram('app_request_duration_seconds', 'Request duration', ['method', 'endpoint'])
active_users = Gauge('app_active_users', 'Active users')

# Use in application
@request_duration.time()
def process_request():
    # Your code here
    pass
```

### Log Aggregation and Analysis
- **ELK Stack**: Elasticsearch, Logstash, Kibana
- **Grafana Loki**: Lightweight log aggregation
- **AWS CloudWatch**: Cloud-native logging
- **Google Cloud Logging**: GCP integration
- **Azure Monitor**: Azure native solution

### Logging Best Practices
1. **Always use structured logging** - JSON format for machine parsing
2. **Include correlation IDs** - Track requests across services
3. **Never log sensitive data** - No passwords, tokens, or PII
4. **Use appropriate log levels** - Don't log everything at DEBUG
5. **Implement log rotation** - Prevent disk space issues
6. **Centralize logs** - Single source of truth
7. **Set up alerts** - Proactive monitoring for CRITICAL/ERROR
8. **Performance impact** - Async logging for high-throughput
9. **Contextual information** - Include user, session, request IDs
10. **Audit trail** - Log all security-relevant events

## Docker Support

### Dockerfile Best Practices
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies first (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Run as non-root user
USER nobody

CMD ["python", "main.py"]
```

## Known Issues & Best Practices

- **Circular Imports**: Use TYPE_CHECKING and forward references
- **Async Context**: Proper session management in async code
- **Memory Leaks**: Close resources properly (files, connections)
- **Global State**: Avoid mutable global state, use dependency injection
- **Testing Async**: Use pytest-asyncio fixtures properly
- **Database Connections**: Use connection pooling, avoid connection leaks
- **Import Organization**: Follow PEP 8 import ordering (standard, third-party, local)

## Debugging Tips

```bash
# Python debugger
import pdb; pdb.set_trace()  # Breakpoint

# IPython debugger (better REPL)
import ipdb; ipdb.set_trace()

# Remote debugging with debugpy
python -m debugpy --listen 5678 main.py

# Memory profiling
python -m memory_profiler main.py

# Performance profiling
python -m cProfile -s cumulative main.py
```

## CI/CD Pipeline

### GitHub Actions / GitLab CI
- Automated testing on push/PR
- Code quality checks
- Security scanning
- Coverage reporting
- Automated deployment to staging/production
- Docker image building and registry push