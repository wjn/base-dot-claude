# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Java-based enterprise application template with comprehensive testing, quality gates, and best practices for building reliable, maintainable software systems.

## Essential Commands

### Development Environment Setup
```bash
# Java version check (requires Java 11+ or 17+ for Spring Boot 3.x)
java -version
javac -version

# Maven setup
mvn --version

# Gradle setup (alternative to Maven)
gradle --version

# Install dependencies
mvn clean install
# OR
gradle clean build
```

### Running the Application
```bash
# Maven
mvn spring-boot:run
mvn exec:java -Dexec.mainClass="com.example.Main"

# Gradle
gradle bootRun
gradle run

# Running JAR directly
java -jar target/application.jar
java -jar build/libs/application.jar
```

### Testing Commands
```bash
# Run all tests (Maven)
mvn clean test

# Run all tests (Gradle)
gradle clean test

# Run specific test class
mvn test -Dtest=UserServiceTest
gradle test --tests UserServiceTest

# Run with coverage (Maven with JaCoCo)
mvn clean test jacoco:report

# Run with coverage (Gradle)
gradle clean test jacocoTestReport

# QUALITY GATE: Run tests with coverage enforcement (85% minimum)
mvn clean verify -Pcoverage-check

# Integration tests only
mvn clean verify -DskipUnitTests
gradle integrationTest

# Run specific test method
mvn test -Dtest=UserServiceTest#testCreateUser
gradle test --tests UserServiceTest.testCreateUser
```

### Code Quality & Static Analysis
```bash
# Checkstyle (Google Java Style Guide compliance)
mvn checkstyle:check
gradle checkstyleMain checkstyleTest

# SpotBugs (finds bugs and potential issues)
mvn spotbugs:check
gradle spotbugsMain spotbugsTest

# PMD (source code analyzer)
mvn pmd:check
gradle pmdMain pmdTest

# SonarQube analysis
mvn sonar:sonar
gradle sonarqube

# All quality checks at once
mvn clean verify -Pquality
gradle clean check
```

### Database Management
```bash
# H2 Console (for development)
# Access at: http://localhost:8080/h2-console

# Flyway migrations (Maven)
mvn flyway:migrate
mvn flyway:clean
mvn flyway:info

# Flyway migrations (Gradle)
gradle flywayMigrate
gradle flywayClean
gradle flywayInfo

# Liquibase migrations (alternative)
mvn liquibase:update
gradle liquibaseUpdate
```

## Architecture & Key Components

### Core Architecture Pattern
The codebase follows **Domain-Driven Design (DDD)** with layered architecture:
- **Controller Layer** (`src/main/java/com/example/controller/`): REST API endpoints
- **Service Layer** (`src/main/java/com/example/service/`): Business logic
- **Repository Layer** (`src/main/java/com/example/repository/`): Data access with Spring Data JPA
- **Domain/Model Layer** (`src/main/java/com/example/domain/`): Entity classes and value objects
- **Configuration** (`src/main/java/com/example/config/`): Spring configuration classes
- **Exception Handling** (`src/main/java/com/example/exception/`): Global exception handlers

### Critical Files for Understanding the System

1. **`pom.xml` or `build.gradle`**: Build configuration and dependencies
   - Dependency management
   - Plugin configuration
   - Build profiles

2. **`src/main/resources/application.yml`**: Application configuration
   - Database settings
   - Server configuration
   - Profile-specific settings

3. **`src/main/java/com/example/Application.java`**: Main Spring Boot application class
   - @SpringBootApplication annotation
   - Component scanning configuration
   - Bean definitions

4. **`src/main/java/com/example/config/SecurityConfig.java`**: Security configuration
   - Authentication and authorization
   - CORS settings
   - JWT or OAuth2 configuration

5. **`src/test/java/com/example/BaseIntegrationTest.java`**: Base test configuration
   - Test containers setup
   - Mock beans
   - Test data builders

### Spring Boot Integration Points

The application uses Spring Boot features:
- **REST Controllers**: @RestController, @RequestMapping
- **Service Layer**: @Service, @Transactional
- **Repository Layer**: JpaRepository, @Repository
- **Dependency Injection**: @Autowired, Constructor injection (preferred)
- **Configuration**: @Configuration, @Bean
- **Validation**: @Valid, Bean Validation API
- **Exception Handling**: @ControllerAdvice, @ExceptionHandler

### Database Schema Key Relationships
```
User (1) → (*) Order
Order (1) → (*) OrderItem
Product (1) → (*) OrderItem
User (1) → (*) Role (Many-to-Many)
```

## Testing Strategy

### Test Organization
- `src/test/java/com/example/unit/`: Unit tests
- `src/test/java/com/example/integration/`: Integration tests
- `src/test/java/com/example/e2e/`: End-to-end tests
- `src/test/java/com/example/contract/`: Contract tests

### Testing Frameworks
- **JUnit 5**: Core testing framework
- **Mockito**: Mocking framework
- **AssertJ**: Fluent assertions
- **RestAssured**: REST API testing
- **TestContainers**: Integration testing with real databases
- **WireMock**: HTTP service mocking

### Coverage Requirements
- Maintain >85% test coverage using JaCoCo
- All new features require corresponding tests
- Use @SpringBootTest for integration tests
- Use @WebMvcTest for controller tests
- Use @DataJpaTest for repository tests

## Common Development Patterns

### Adding New REST Endpoints
1. Create controller method with appropriate annotations
2. Implement service layer business logic
3. Add repository methods if needed
4. Create DTOs for request/response
5. Add validation annotations
6. Write unit and integration tests
7. Update API documentation (Swagger/OpenAPI)

### Repository Pattern Usage
```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.status = :status")
    List<User> findByStatus(@Param("status") Status status);
}
```

### Service Layer Pattern
```java
@Service
@Transactional
public class UserService {
    private final UserRepository userRepository;
    
    // Constructor injection (preferred)
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    public UserDto createUser(CreateUserRequest request) {
        // Business logic here
    }
}
```

### Error Handling
```java
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(ResourceNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(new ErrorResponse(ex.getMessage()));
    }
}
```

## Build Profiles

### Maven Profiles
- `development`: Local development with H2 database
- `test`: Testing with TestContainers
- `production`: Production settings with connection pooling
- `quality`: Runs all quality checks

### Gradle Build Types
- `bootJar`: Creates executable JAR
- `bootWar`: Creates deployable WAR
- `docker`: Builds Docker image

## Quality Standards

### Code Style
- Google Java Style Guide compliance
- Maximum method length: 30 lines
- Maximum class length: 300 lines
- Cyclomatic complexity: <10

### Static Analysis Rules
- Zero critical violations in SpotBugs
- Zero blocker issues in PMD
- Checkstyle score >90%
- SonarQube quality gate: Pass

## Security Best Practices

- Use parameterized queries (no SQL injection)
- Validate all inputs with Bean Validation
- Implement proper authentication/authorization
- Use HTTPS in production
- Store secrets in environment variables
- Regular dependency updates for security patches
- OWASP Top 10 compliance

## Performance Optimization

- Use database connection pooling (HikariCP)
- Implement caching with Spring Cache
- Use pagination for large datasets
- Optimize N+1 queries with @EntityGraph
- Monitor with Spring Boot Actuator
- Profile with JProfiler or YourKit

## Development Workflow Requirements

### Quality Gates (MANDATORY)
1. **Before ANY Commit**:
   ```bash
   mvn clean verify -Pquality
   # OR
   gradle clean check
   ```

2. **Mandatory Standards**:
   - 100% Test Pass Rate
   - 85% Code Coverage (JaCoCo)
   - Zero Critical Static Analysis Issues
   - All Security Scans Pass

3. **Pre-commit Hooks**:
   ```bash
   # Install pre-commit hooks
   ./scripts/install-hooks.sh
   ```

## Known Issues & Best Practices

- **Lazy Loading**: Always use @Transactional or fetch joins to avoid LazyInitializationException
- **N+1 Queries**: Use @EntityGraph or JOIN FETCH in JPQL
- **Connection Pool**: Configure HikariCP properly for production
- **Test Isolation**: Use @DirtiesContext sparingly, prefer @Transactional with @Rollback
- **DTO Mapping**: Use MapStruct or ModelMapper for entity-DTO conversion