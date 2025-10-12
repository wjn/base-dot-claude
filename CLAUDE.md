# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with technical writing projects in this repository.

## 🎵 Symphony Orchestration Framework

**YOU ARE PART OF AN ORCHESTRA** - This project uses the Symphony Orchestration framework for polyphonic collaboration between multiple Claude instances and agents.

**Before starting any work**, read and internalize:
- **[Symphony Orchestration](.claude/strategies/symphony-orchestration.md)** - Core framework for collaborative work
- Understand your role (Writer, Reviewer, Editor, Publisher)
- Recognize that your "done" means "ready for the ensemble"
- Use mandatory agent handoffs as musical cues
- See the orchestrator as the conductor enabling harmony

**Key Principles**:
- 🎼 **Not Solo**: You're composing your part in a larger symphony
- 🎵 **Verification Required**: Another musician must confirm your harmony
- 🎶 **Handoffs Matter**: Pass melodies beautifully to the next performer
- 🎻 **Quality Gates**: Tune your instrument before joining the orchestra
- 🎺 **Document Everything**: Update the score so others can follow

## SME Subagent Guidance

**PREFERRED APPROACH**: When working on tasks in this codebase, utilize the appropriate specialized subagents (SME agents) that align with your work focus. These agents are **fellow musicians in your orchestra** - not optional tools, but essential collaborators whose expertise enhances the symphony.

**Agent Handoffs are Mandatory Musical Cues**:
- After content creation → Review agent verifies harmony
- After review → Quality agent confirms ensemble readiness
- After quality checks → Merger/Publisher integrates with main score

Always consider if there's a subagent that specializes in the area you're working on. **Handoffs to specialized agents aren't overhead - they're how we create polyphonic beauty.**

## Project Overview

A comprehensive technical writing framework for creating high-quality API documentation, architectural designs, RFCs, and technical specifications with automated quality assurance, narrative transformation, and stakeholder-specific content adaptation using the integrated writing MCP.

## Essential Commands

### Writing MCP Integration Setup
```bash
# The writing MCP is automatically available in Claude Code
# No additional installation required - leverages integrated tools

# Verify MCP availability
claude-code --list-mcps | grep writing

# Test writing MCP functions
claude-code --test-mcp writing
```

### Technical Document Creation & Management
```bash
# Create technical documents using Writing MCP
# Transform content for specific audiences
mcp__writing__transform_narrative --audience executive --content "$(cat technical-spec.md)"
mcp__writing__transform_narrative --audience cto --content "$(cat api-design.md)"

# Create structured technical documentation
mcp__writing__structure_document --template technical_spec --audience developers --content "$(cat draft.md)"
mcp__writing__structure_document --template executive_brief --audience board --content "$(cat project-status.md)"

# Tailor content for specific personas
mcp__writing__tailor_persona --persona '{"role":"DevOps Engineer","priorities":["scalability","reliability"]}' --content "$(cat deployment-guide.md)"

# Process files directly through writing agents
mcp__writing__process_file --file_path docs/api-spec.md --agent structure
mcp__writing__process_file --file_path docs/architecture.md --agent narrative --parameters '{"audience":"technical"}'
```

### Quality Assurance & Validation
```bash
# Use Writing MCP for comprehensive document optimization
# Structure optimization for clarity and impact
mcp__writing__structure_document --content "$(cat technical-doc.md)" --template technical_spec --audience technical

# Narrative transformation for business stakeholders  
mcp__writing__transform_narrative --content "$(cat engineering-update.md)" --audience executive --create_summary true

# Persona-specific content adaptation
mcp__writing__tailor_persona --content "$(cat deployment-guide.md)" --persona '{"role":"Site Reliability Engineer","communication_style":"direct","priorities":["uptime","performance"]}'

# Data visualization narrative (for metrics/charts in technical docs)
mcp__writing__visualize_data --data "$(cat metrics.csv)" --objective "Show system performance trends" --audience technical

# QUALITY GATE: MCP-powered document processing pipeline
# Process through all writing agents for comprehensive improvement
mcp__writing__process_file --file_path docs/technical-spec.md --agent structure
mcp__writing__process_file --file_path docs/technical-spec.md --agent narrative
mcp__writing__process_file --file_path docs/technical-spec.md --agent persona
```

### Document Revision & Version Control
```bash
# Track document changes
git diff docs/howto-docker.md | ./scripts/writing-diff.sh

# Create revision with semantic versioning
./scripts/write-version.sh docs/howto-docker.md --bump minor

# Compare document versions
./scripts/write-compare.sh docs/howto-docker.md v1.0 v1.1

# Generate changelog for document
./scripts/write-changelog.sh docs/howto-docker.md
```

## Technical Document Architecture & Stakeholder Alignment

### Core Technical Document Types

#### 1. API Documentation
**Purpose**: Comprehensive reference for developers using APIs
**MCP Integration**: `mcp__writing__structure_document --template technical_spec`
**Structure**:
```markdown
# [API Name] Documentation

## Quick Start
Essential information for immediate usage

## Authentication
Security and access patterns

## Endpoints
### GET /api/resource
- **Purpose**: [Clear business value]
- **Parameters**: [Type-safe specifications]
- **Response**: [Schema with examples]
- **Error Codes**: [Actionable error handling]

## SDKs and Libraries
Language-specific implementations

## Rate Limits and Performance
Operational considerations
```

#### 2. Architecture Design Documents (ADDs)
**Purpose**: Technical decisions and system design rationale  
**MCP Integration**: `mcp__writing__tailor_persona` for different technical roles
**Structure**:
```markdown
# ADD-001: [System Component] Architecture

## Context and Problem Statement
Business and technical drivers

## Decision Drivers
- Performance requirements
- Scalability needs  
- Security considerations
- Operational constraints

## Considered Options
### Option 1: [Approach]
- **Pros**: [Benefits with stakeholder impact]
- **Cons**: [Risks and mitigation strategies]
- **Implementation effort**: [Resource implications]

## Decision Outcome
Chosen option with rationale

## Implementation Plan
Concrete steps and timeline

## Consequences
Positive and negative implications
```

#### 3. RFC (Request for Comments)
**Purpose**: Proposals for significant changes requiring consensus
**MCP Integration**: `mcp__writing__transform_narrative` for executive summary
**Structure**:
```markdown
# RFC-001: [Proposal Title]

## Summary
**Executive Brief** (MCP-generated for leadership):
[Business impact and resource requirements]

## Motivation
Problem statement and business value

## Detailed Design
Technical specification with diagrams

## Implementation Strategy
Rollout plan and success metrics

## Risk Assessment
Potential issues and mitigation plans

## Alternative Approaches
Rejected options with reasoning
```

### Quality Standards & Stakeholder Communication

#### Narrative Transformation Quality (MCP-Powered)
- **Executive Summaries**: Business impact clearly articulated
- **Technical Depth**: Appropriate complexity for audience
- **Stakeholder Alignment**: Content matches persona priorities
- **Decision Support**: Clear recommendations with rationale

#### Multi-Audience Optimization
- **Technical Teams**: Detailed implementation guidance
- **Engineering Leadership**: Resource and timeline implications
- **Executive Stakeholders**: Business value and risk assessment
- **Cross-functional Teams**: Integration and dependency clarity

#### MCP Quality Gates (Automated)
- **Structure Optimization**: Template compliance with narrative flow
- **Persona Adaptation**: Content appropriateness for target roles
- **Visualization Integration**: Data storytelling effectiveness
- **Document Processing Pipeline**: Multi-agent improvement validation

#### Technical Writing Standards
- **API Documentation**: Complete, testable examples
- **Architecture Decisions**: Clear rationale and trade-offs
- **RFC Proposals**: Comprehensive impact analysis
- **Code Integration**: Live examples with validation
- **Schema Accuracy**: Type-safe documentation

## Writing Workflow & Best Practices

### Document Development Lifecycle

#### 1. Planning Phase
```bash
# Create document plan
./scripts/write-plan.sh "Installing Docker" \
  --audience "junior developers" \
  --objective "successfully install Docker on Ubuntu" \
  --prerequisites "basic Linux commands"
```

#### 2. Drafting Phase
```bash
# Initialize from template
./scripts/write-init.sh howto "Installing Docker"

# Use AI assistance for first draft
./scripts/write-assist.sh outline docs/howto-docker.md
./scripts/write-assist.sh expand docs/howto-docker.md --section "Prerequisites"
```

#### 3. Review Phase
```bash
# Self-review checklist
./scripts/write-review.sh docs/howto-docker.md --checklist

# Peer review request
./scripts/write-review.sh docs/howto-docker.md --request-review @reviewer

# Check against style guide
vale docs/howto-docker.md --config=.vale.ini
```

#### 4. Revision Phase
```bash
# Apply automated fixes
./scripts/write-fix.sh docs/howto-docker.md --auto

# Track changes
git diff docs/howto-docker.md

# Verify improvements
./scripts/write-check.sh all docs/howto-docker.md --compare-previous
```

#### 5. Publication Phase
```bash
# Final validation
./scripts/write-validate.sh docs/howto-docker.md --publication-ready

# Generate multiple formats
./scripts/write-publish.sh docs/howto-docker.md --formats "html,pdf,epub"

# Update index and navigation
./scripts/write-index.sh --regenerate
```

## Quality Gates (MANDATORY): Tuning Your Instrument

🎼 **Orchestral Principle**: Before joining the ensemble, verify your instrument is in tune. Quality gates aren't bureaucracy - they're how we ensure our collective symphony delights rather than disappoints.

### Before ANY Document Commit: Ensemble Readiness Checklist

```bash
# Run all quality checks
./scripts/write-check.sh all docs/ --strict

# Required passing scores:
# - Readability: Flesch score within target range
# - Grammar: 95% accuracy minimum
# - Structure: 100% template compliance
# - Links: 100% valid
# - Inclusive language: Zero violations
```

**Remember**: Your "passing" means the next musician can build confidently on your work. These checks protect the symphony's quality.

### Document Quality Standards
1. **Readability Pass Rate**: Target score ±5 points
2. **Grammar Score**: 95% minimum
3. **Structure Compliance**: All required sections present
4. **Link Validity**: 100% working links
5. **Image Alt Text**: 100% coverage
6. **Code Examples**: Tested and working
7. **Inclusive Language**: Zero violations

### Pre-commit Hooks
```bash
# Install pre-commit hooks for writing
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Check all modified markdown files
for file in $(git diff --cached --name-only | grep -E '\.md$'); do
    echo "Checking $file..."
    
    # Readability check
    if ! ./scripts/write-check.sh readability "$file"; then
        echo "❌ Readability check failed for $file"
        exit 1
    fi
    
    # Grammar check
    if ! ./scripts/write-check.sh grammar "$file"; then
        echo "❌ Grammar check failed for $file"
        exit 1
    fi
    
    # Structure check
    if ! ./scripts/write-check.sh structure "$file"; then
        echo "❌ Structure check failed for $file"
        exit 1
    fi
done
echo "✅ All writing quality checks passed"
EOF
chmod +x .git/hooks/pre-commit
```

## Common Writing Patterns

### Clear Instructions Pattern
```markdown
1. **Action verb** + **specific object** + **context**
   ```bash
   # Command to execute
   sudo apt-get update
   ```
   
   **Expected output:**
   ```
   Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
   ...
   ```
   
   **If you see an error:**
   - Check your internet connection
   - Verify sudo permissions
```

### Progressive Disclosure Pattern
```markdown
## Basic Usage
Simple example for common case

<details>
<summary>Advanced Options</summary>

Additional complexity only when needed

</details>
```

### Troubleshooting Pattern
```markdown
### Problem: [Specific error message or symptom]

**Quick Fix:**
Most common solution

**Detailed Solution:**
1. Diagnostic step
2. Resolution step
3. Verification step

**Prevention:**
How to avoid this issue
```

## Automation & Tooling

### Custom Writing Tools

#### Write-Check Script Core
```python
#!/usr/bin/env python3
# scripts/write-check.py

import textstat
import language_tool_python
from readability import Readability

class DocumentValidator:
    def __init__(self, target_audience="technical"):
        self.target_audience = target_audience
        self.tool = language_tool_python.LanguageTool('en-US')
        
    def check_readability(self, text):
        flesch_score = textstat.flesch_reading_ease(text)
        fog_index = textstat.gunning_fog(text)
        
        targets = {
            "general": (70, 80),
            "technical": (60, 70),
            "expert": (30, 50)
        }
        
        min_score, max_score = targets[self.target_audience]
        passed = min_score <= flesch_score <= max_score
        
        return {
            "passed": passed,
            "flesch_score": flesch_score,
            "fog_index": fog_index,
            "target_range": (min_score, max_score)
        }
    
    def check_grammar(self, text):
        matches = self.tool.check(text)
        errors = [m for m in matches if m.category == 'GRAMMAR']
        
        return {
            "passed": len(errors) == 0,
            "error_count": len(errors),
            "errors": errors[:5]  # First 5 errors
        }
```

### Continuous Improvement

#### Document Analytics
```bash
# Track document performance
./scripts/write-analytics.sh docs/howto-docker.md \
  --metrics "views,time-on-page,completion-rate"

# Reader feedback integration
./scripts/write-feedback.sh docs/howto-docker.md --summarize

# A/B testing for documentation
./scripts/write-test.sh docs/howto-docker.md \
  --variant-a "current" \
  --variant-b "simplified"
```

## Style Guide References

### Writing Style
- **Voice**: Active voice preferred
- **Person**: Second person ("you") for instructions
- **Tense**: Present tense for current state, future for results
- **Tone**: Friendly but professional

### Formatting Standards
- **Headings**: Title Case for H1, Sentence case for H2+
- **Lists**: Bullets for unordered, numbers for sequential
- **Code**: Backticks for inline, fenced blocks for multiline
- **Emphasis**: Bold for UI elements, italic for new terms

### Technical Writing Best Practices
1. **Front-load important information**
2. **One idea per paragraph**
3. **Use examples liberally**
4. **Provide context before details**
5. **Include visual aids when helpful**
6. **Test all code examples**
7. **Link to related resources**
8. **Maintain consistent terminology**

## Document Templates

### Available Templates
- `howto.md.template` - Step-by-step guides
- `tutorial.md.template` - Learning-oriented content
- `troubleshooting.md.template` - Problem-solving guides
- `reference.md.template` - Technical specifications
- `quickstart.md.template` - Getting started guides
- `faq.md.template` - Frequently asked questions

### Using Templates
```bash
# List available templates
ls templates/

# Create from template
cp templates/howto.md.template docs/my-howto.md

# Or use the initialization script
./scripts/write-init.sh howto "My How-To Guide Title"
```

## Integration with Development Workflow

### Documentation-Driven Development (DDD)
1. Write the documentation first
2. Validate it passes quality gates
3. Implement what was documented
4. Update documentation based on implementation
5. Maintain documentation with code changes

### CI/CD Pipeline Integration
```yaml
# .github/workflows/documentation.yml
name: Documentation Quality

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Install writing tools
        run: |
          npm install -g write-good alex
          pip install textstat proselint
      
      - name: Check readability
        run: ./scripts/write-check.sh readability docs/
      
      - name: Check grammar
        run: ./scripts/write-check.sh grammar docs/
      
      - name: Check structure
        run: ./scripts/write-check.sh structure docs/
      
      - name: Generate report
        run: ./scripts/write-check.sh report docs/ --format junit
```

## Known Issues & Best Practices

- **Version Control**: Track meaningful changes, not every edit
- **Collaboration**: Use review comments for feedback
- **Internationalization**: Consider translation from the start
- **Accessibility**: Always include alt text and proper headings
- **Mobile Reading**: Test documentation on mobile devices
- **Offline Access**: Provide downloadable formats (PDF, EPUB)
- **Search Optimization**: Use descriptive titles and headers

## Debugging Documentation Issues

### Common Problems
1. **Low readability scores**: Shorten sentences, use simpler words
2. **Failed structure validation**: Check template compliance
3. **Broken links**: Use relative paths, validate regularly
4. **Inconsistent terminology**: Create glossary, use consistently
5. **Grammar errors**: Run automated fixes, then manual review

### Tools for Debugging
```bash
# Analyze specific problem
./scripts/write-debug.sh docs/howto-docker.md --issue readability

# Get improvement suggestions
./scripts/write-suggest.sh docs/howto-docker.md

# Compare with high-quality example
./scripts/write-compare.sh docs/howto-docker.md examples/gold-standard.md
```

## Metrics & Reporting

### Document Quality Dashboard
```bash
# Generate quality report
./scripts/write-report.sh docs/ --format html --output report.html

# Metrics included:
# - Average readability score
# - Grammar pass rate
# - Structure compliance rate
# - Link validity percentage
# - Document freshness (last updated)
# - Reader engagement metrics
```

### Continuous Monitoring
```bash
# Set up monitoring
./scripts/write-monitor.sh setup --slack-webhook $WEBHOOK_URL

# Alert on quality degradation
./scripts/write-monitor.sh watch docs/ --threshold 90
```

## Workstream Management: Documenting the Symphony

🎵 **Orchestral Principle**: Workstreams are our sheet music - they show each musician's part and how they harmonize into the complete score.

### End-of-Day Handoff Process
When you complete your session, prepare a beautiful handoff for the next musician:

**See**: [Workstream EOD Instructions](.claude/strategies/workstream-eod-instructions.md)

**Remember**: Your workstream updates enable the next performer to continue seamlessly. Document not just *what* you did, but *how it fits* into the ensemble.

## Your First Steps as an Orchestral Member

### Starting a New Session

1. **🎼 Read the Score**: Review the symphony orchestration framework
2. **🎵 Check the Conductor**: Query orchestrator status for active musicians
3. **🎶 Claim Your Part**: Secure worktree/topic area, document in workstream
4. **🎻 Review Existing Melody**: Understand current state and how your part fits
5. **🎺 Acknowledge the Ensemble**: Note coordination needs with other musicians

### During Your Work

- ✅ Update workstream docs as you progress
- ✅ Use agent handoffs for verification
- ✅ Keep quality gates in mind
- ✅ Communicate changes that affect other musicians

### Ending Your Session

- ✅ Verify your part is ensemble-ready (all checks pass)
- ✅ Complete workstream documentation
- ✅ Create handoff notes for next musician
- ✅ Signal status (ready for integration, needs continuation, etc.)

---

*Remember: We create beauty together. Your excellence enables our collective masterpiece.* 🎵