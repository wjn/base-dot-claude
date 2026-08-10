# CLAUDE.md

Guidance for Claude Code working on how-to guides and tutorials in this
repository.

> **This is a template.** Replace the bracketed sections with facts about *this*
> project. Anything you cannot state truthfully, delete — a wrong instruction is
> worse than a missing one.

## Working agreement

- **Prefer SME subagents.** Before writing directly, check whether a specialized
  agent covers the area and use it.
- **Worktree isolation.** Never work on `main`. Branch, then ship as a PR.
- **Docs go in `docs/`.** Never create a `generated_documents/` directory.
- Track outcomes with markdown checkboxes: `- [ ]` open, `- [x]` done.

## Project overview

<!-- REPLACE: what this project documents, for whom, in 2–3 sentences. -->
[A framework for writing how-to guides and tutorials with enforced quality
gates.]

## Essential commands

**Only two scripts exist.** Do not invent others — if a task needs a script that
isn't here, say so rather than calling one that doesn't exist.

```bash
./scripts/write-init.sh howto "Installing Docker on Ubuntu"   # new doc from template
./scripts/write-check.sh all docs/ --strict                   # the quality gate
./scripts/write-check.sh readability docs/x.md --flesch-target 65
./scripts/write-check.sh structure docs/x.md --template howto
```

Third-party tools, if installed: `vale`, `write-good`, `proselint`, `alex`,
`textstat`, `markdown-link-check`, `pandoc` (format conversion).

<!-- REPLACE: if this project adds scripts, list them here and delete this note.
     Every command listed must actually run. -->

## Document types

Templates live in `templates/`. Read the template rather than reproducing its
outline here — the file is the source of truth and cannot drift from itself.

| Type | Purpose | Template |
|---|---|---|
| How-to | Steps to complete one specific task | `templates/howto.md.template` |
| Tutorial | Teaching a concept through worked examples | [add if present] |
| Troubleshooting | Symptom → cause → fix → prevention | [add if present] |

A how-to is not a tutorial. How-to guides serve someone who knows what they want
and needs the steps; tutorials serve someone learning the domain. Mixing them
produces a document that fails both readers.

## Quality gates (mandatory)

Every one of these must hold before a commit:

| Gate | Threshold |
|---|---|
| Flesch Reading Ease | 60–70 how-to · 50–60 tutorial · 30–50 reference |
| Gunning Fog | <12 |
| Grammar score | ≥95% |
| Structure compliance | 100% of template sections present |
| Links valid | 100% |
| Image alt text | 100% |
| Inclusive language (alex) | zero violations |
| Passive voice | <10% of sentences |

Run `./scripts/write-check.sh all docs/ --strict` before committing.

Prose targets: sentences 15–20 words, paragraphs 3–5 sentences, technical terms
defined on first use, acronyms expanded on first use, one term per concept
throughout.

## Writing rules that actually change the output

- **Every step states its expected result.** A step the reader cannot verify
  they completed correctly is a step they will get wrong silently.
- **Commands must be tested, not plausible.** An untested command in a how-to is
  the single most damaging thing this repository can publish.
- **Progressive disclosure**: the common path first, edge cases after. Do not
  front-load caveats the reader cannot yet understand.
- **Prerequisites are concrete**: required access, tools, versions, and a time
  estimate — not "familiarity with Linux".
- Write for the stated audience. If the audience isn't stated, ask.

## Known traps in this repository

<!-- REPLACE with real, specific traps found here. Delete generic writing
     advice — Claude already knows it. -->
- **Documented-but-absent scripts.** This file previously listed 22 helper
  scripts when 2 existed. Before referencing a script, confirm it is in
  `scripts/`.
- [trap]
