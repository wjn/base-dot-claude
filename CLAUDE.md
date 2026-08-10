# CLAUDE.md

Guidance for Claude Code working in this repository.

> **This is a template.** Replace the bracketed sections with facts about *this*
> project. Anything you cannot state truthfully, delete — a wrong instruction is
> worse than a missing one.

## Working agreement

- **Prefer SME subagents.** Before implementing directly, check whether a
  specialized agent covers the area you're working in and use it.
- **Worktree isolation.** Never work on `main`. Branch, then ship as a PR.
- **Code-review + SDET agents are mandatory** before integration.
- **Docs go in `docs/`.** Never create a `generated_documents/` directory.
- Track outcomes with markdown checkboxes: `- [ ]` open, `- [x]` done.

## Project overview

<!-- REPLACE: what this project does, in 2–3 sentences. What it is not. -->
[Java project. Describe the actual purpose, entry point, and runtime.]

## Essential commands

<!-- REPLACE: this project uses Maven OR Gradle, not both. Delete the one it
     doesn't use — listing both doubles this section and makes Claude guess. -->

```bash
[mvn clean install]
[mvn spring-boot:run]
[mvn clean verify -Pquality]          # tests + coverage + static analysis
[mvn test -Dtest=UserServiceTest#testCreateUser]
```

Gradle equivalents, if that's what this project uses: `gradle clean build`,
`gradle bootRun`, `gradle clean check`, `gradle test --tests X.y`.

## Architecture

<!-- REPLACE with the real layout. The default below is layered DDD; if this
     project doesn't follow it, describe what it does follow. -->

| Layer | Location | Holds |
|---|---|---|
| Controller | `controller/` | REST endpoints |
| Service | `service/` | business logic, `@Transactional` boundaries |
| Repository | `repository/` | Spring Data JPA data access |
| Domain | `domain/` | entities and value objects |
| Config | `config/` | Spring configuration, security |
| Exception | `exception/` | `@ControllerAdvice` handlers |

Read first to understand the system: `pom.xml`/`build.gradle`,
`application.yml`, `Application.java`, `config/SecurityConfig.java`,
`BaseIntegrationTest.java`.

<!-- REPLACE: the actual data model. Do not leave this as a guess — an
     invented schema will be believed and acted on. -->
**Data model:** [describe the real entities and relationships, or delete]

## Quality gates (mandatory)

Every one of these must hold before a commit:

| Gate | Threshold |
|---|---|
| Test pass rate | 100% |
| Coverage (JaCoCo) | ≥85% |
| SpotBugs | zero critical |
| PMD | zero blockers |
| Checkstyle (Google Java Style) | >90% |
| SonarQube quality gate | Pass |

Style: Google Java Style, methods ≤30 lines, classes ≤300 lines, cyclomatic
complexity <10. Constructor injection, never field `@Autowired`.

## Testing

- `unit/` · `integration/` · `e2e/` · `contract/` under `src/test/java/`
- JUnit 5 + Mockito + AssertJ; TestContainers for integration, WireMock for
  HTTP stubs, RestAssured for API tests
- Slice annotations: `@WebMvcTest` for controllers, `@DataJpaTest` for
  repositories, `@SpringBootTest` only when a full context is genuinely needed
- Prefer `@Transactional` + `@Rollback` over `@DirtiesContext` — the latter
  rebuilds the whole context and slows the suite disproportionately
- Test behavior, not implementation; write the failing test first

## Security rules

- Validate all input at the boundary with Bean Validation
- Parameterized queries / JPA only — no string-built JPQL or SQL
- Secrets from environment, never hardcoded, never committed
- **Never log passwords, tokens, PII, or credentials** — filter before logging
- Keep dependencies patched; treat OWASP Top 10 as the baseline

## Known traps in this codebase

<!-- REPLACE with real, specific traps discovered here. Delete generic Java
     advice — Claude already knows it. Good entries look like:
     "The X client must be closed explicitly or connections leak in tests." -->
- **LazyInitializationException**: entities accessed outside a transaction.
  Use a fetch join or keep the session open deliberately, not `@Transactional`
  sprinkled to make the error go away.
- **N+1 queries**: use `@EntityGraph` or `JOIN FETCH`. They do not show up in
  tests with small fixtures — check the generated SQL, not the assertion.
- [trap]
