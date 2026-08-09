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
[Python project. Describe the actual purpose, entry point, and runtime.]

## Essential commands

<!-- REPLACE: only the commands that actually work here. Delete the rest.
     Do not list alternatives the project doesn't use. -->

```bash
[python -m venv venv && source venv/bin/activate]
[pip install -e ".[dev]"]
[pytest --cov=src --cov-fail-under=85]
[flake8 src/ tests/ && mypy src/]
```

## Architecture

<!-- REPLACE with the real layout. The default below is Clean Architecture;
     if this project doesn't follow it, describe what it does follow. -->

| Layer | Location | Holds |
|---|---|---|
| API | `src/api/` | endpoints, request/response handling |
| Service | `src/services/` | business logic and orchestration |
| Repository | `src/repositories/` | data access abstraction |
| Domain | `src/models/` | entities and domain logic |
| Infrastructure | `src/infrastructure/` | external service integrations |
| Config | `src/config/` | settings, environment |

<!-- REPLACE: the actual data model. Do not leave this as a guess — an
     invented schema will be believed and acted on. -->
**Data model:** [describe the real entities and relationships, or delete]

## Quality gates (mandatory)

Every one of these must hold before a commit:

| Gate | Threshold |
|---|---|
| Test pass rate | 100% |
| Coverage | ≥85% |
| Flake8 | zero violations |
| Pylint | >9.0/10 |
| MyPy | no errors in strict mode |
| Bandit | no high-severity findings |

Style: PEP 8, 88-char lines (black), functions ≤50 lines, cyclomatic complexity
≤10, type hints on all public functions.

Run `pre-commit run --all-files` before committing.

## Testing

- `tests/unit/` · `tests/integration/` · `tests/e2e/` · `tests/fixtures/`
- Shared fixtures and config in `tests/conftest.py`
- Test behavior, not implementation — tests should survive refactoring
- Test both success and error paths; mock external dependencies
- Write the failing test first

## Security rules

- Validate all input at the boundary; never trust caller-supplied data
- Parameterized queries / ORM only — no string-built SQL
- Secrets from environment, never hardcoded, never committed
- Hash passwords with bcrypt or argon2
- **Never log passwords, tokens, PII, or credentials** — filter before logging
- Audit dependencies regularly (`pip-audit`, `safety`)

## Logging

- Structured JSON logging, so logs are machine-parseable
- Include a correlation/request ID on every entry to trace across services
- Log levels mean: DEBUG diagnostic · INFO normal operation · WARNING handled
  surprise · ERROR failed but running · CRITICAL unusable
- Log every security-relevant event (auth failures, privilege changes, exports)
- Rotate logs; never let them grow unbounded

## Known traps in this codebase

<!-- REPLACE with real, specific traps discovered here. Delete generic Python
     advice — Claude already knows it. Good entries look like:
     "The X client must be closed explicitly or connections leak in tests."  -->
- [trap]
