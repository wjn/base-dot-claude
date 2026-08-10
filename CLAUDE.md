# CLAUDE.md

Guidance for Claude Code working on technical documentation in this repository.

> **This is a template.** Replace the bracketed sections with facts about *this*
> project. Anything you cannot state truthfully, delete — a wrong instruction is
> worse than a missing one.

## Symphony Orchestration

This project uses the Symphony Orchestration framework: multiple Claude
instances and agents work as an ensemble, not solo.

**Read [`.claude/strategies/symphony-orchestration.md`](.claude/strategies/symphony-orchestration.md)
before starting work.** It defines the roles (Writer, Reviewer, Editor,
Publisher) and the handoff protocol. Two rules carry most of the weight:

- Your "done" means **ready for the ensemble**, not finished — another agent
  must verify your work before it counts.
- Hand off explicitly. An unannounced handoff is a dropped note.

## Working agreement

- **Prefer SME subagents.** Before writing directly, check whether a specialized
  agent covers the area and use it.
- **Worktree isolation.** Never work on `main`. Branch, then ship as a PR.
- **Docs go in `docs/`.** Never create a `generated_documents/` directory.
- Track outcomes with markdown checkboxes: `- [ ]` open, `- [x]` done.

## Project overview

<!-- REPLACE: what this project documents, for whom, in 2–3 sentences. -->
[A framework for technical documentation — API references, ADRs, RFCs — with
enforced quality gates.]

## Essential commands

**Only three scripts exist.** Do not invent others — if a task needs a script
that isn't here, say so rather than calling one that doesn't exist.

```bash
./scripts/write-init.sh rfc "Streaming ingestion"   # new doc from template
./scripts/write-check.sh all docs/ --strict         # the quality gate
./scripts/mcp-quality-gate.sh                       # MCP-side gate
```

Third-party tools, if installed: `vale`, `write-good`, `proselint`, `alex`,
`textstat`, `markdown-link-check`, `pandoc`.

<!-- REPLACE: if this project adds scripts, list them here and delete this note.
     Every command listed must actually run. -->

## Document types

Templates live in `templates/`. **Open the template rather than working from a
summary** — a copied outline in this file can only drift from the file it
describes.

| Type | Use for | Template |
|---|---|---|
| API documentation | Endpoint reference, auth, rate limits, SDKs | `templates/api-documentation.md.template` |
| Architecture / ADR | A decision: context, drivers, options, consequences | `templates/architecture-design.md.template` |
| RFC / proposal | A change under discussion: motivation, design, risks | `templates/rfc-proposal.md.template` |
| How-to | Steps to complete one specific task | `templates/howto.md.template` |

Choosing wrongly is the common failure. An ADR records a decision **already
made** and its consequences; an RFC proposes one **still open**. Writing an RFC
as an ADR removes the reader's ability to disagree.

## Quality gates (mandatory)

Every one of these must hold before a commit:

| Gate | Threshold |
|---|---|
| Flesch Reading Ease | 30–50 (technical reference) |
| Gunning Fog | <12 |
| Grammar score | ≥95% |
| Structure compliance | 100% of template sections present |
| Links valid | 100% |
| Image alt text | 100% |
| Inclusive language (alex) | zero violations |
| Passive voice | <10% of sentences |

Run `./scripts/write-check.sh all docs/ --strict` before committing.

Prose targets: sentences 15–20 words, paragraphs 3–5 sentences, technical terms
defined on first use, acronyms expanded on first use, one term per concept.

## Writing rules that actually change the output

- **Every code sample and command is tested, not plausible.** An untested
  example in technical documentation is the most damaging thing published here.
- **State what the reader cannot infer.** Skip restating what the API signature
  already says; document the constraint, the failure mode, the ordering
  requirement.
- **Record the alternatives you rejected and why.** A decision without its
  discarded options gets relitigated every six months.
- **Version and date anything that can go stale** — endpoints, limits, versions.
- Write for the stated audience. If the audience isn't stated, ask.

## Known traps in this repository

<!-- REPLACE with real, specific traps found here. Delete generic writing
     advice — Claude already knows it. -->
- **Documented-but-absent scripts.** This file previously listed 20 helper
  scripts when 3 existed. Before referencing a script, confirm it is in
  `scripts/`.
- **Inline template copies.** Full template outlines used to live in this file
  alongside the real templates in `templates/`. Point at the template; never
  re-summarize it.
- [trap]
