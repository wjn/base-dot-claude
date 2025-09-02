# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with writing projects in this repository.

## Project Overview

A comprehensive writing framework for creating high-quality how-to guides, tutorials, and instructional documentation with measurable quality gates, automated verification, and consistent standards for human-readable content.

## Essential Commands

### Writing Environment Setup
```bash
# Check for required writing tools
which vale || echo "Vale style checker not installed"
which alex || echo "Alex inclusive language checker not installed"
which write-good || echo "Write-good prose linter not installed"

# Install writing tools (Node.js required)
npm install -g write-good alex
npm install -g @retextjs/retext-readability

# Install Vale style checker
wget https://github.com/errata-ai/vale/releases/download/v3.0.0/vale_3.0.0_Linux_64-bit.tar.gz
tar -xzf vale_3.0.0_Linux_64-bit.tar.gz
sudo mv vale /usr/local/bin/

# Install Python-based analysis tools
pip install textstat pypandoc proselint language-tool-python
pip install readability-lxml markdown2 
```

### Document Creation & Management
```bash
# Initialize new document from template
./scripts/write-init.sh howto "Installing Docker on Ubuntu"
./scripts/write-init.sh tutorial "Building Your First Web App"
./scripts/write-init.sh guide "Troubleshooting Network Issues"

# Check document status and metrics
./scripts/write-status.sh docs/howto-docker.md

# Preview formatted output
./scripts/write-preview.sh docs/howto-docker.md --format html
pandoc docs/howto-docker.md -o preview.html --standalone

# Convert between formats
pandoc docs/howto-docker.md -o docs/howto-docker.pdf
pandoc docs/howto-docker.md -o docs/howto-docker.docx
```

### Quality Checks & Validation
```bash
# Readability analysis
textstat docs/howto-docker.md --metrics all
readability docs/howto-docker.md --target-audience technical

# Grammar and style checking
vale docs/howto-docker.md
write-good docs/howto-docker.md --parse
proselint docs/howto-docker.md

# Inclusive language check
alex docs/howto-docker.md --why

# QUALITY GATE: Full document validation (equivalent to pytest --cov)
./scripts/write-check.sh all docs/howto-docker.md --strict

# Check specific quality metrics
./scripts/write-check.sh readability docs/howto-docker.md --flesch-target 65
./scripts/write-check.sh structure docs/howto-docker.md --template howto
./scripts/write-check.sh grammar docs/howto-docker.md --min-score 95

# Batch validation for entire documentation
./scripts/write-check.sh all docs/ --recursive --report

# Link validation
markdown-link-check docs/howto-docker.md
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

## Document Architecture & Structure

### Core Document Types

#### 1. How-To Guides
**Purpose**: Step-by-step instructions for completing specific tasks
**Structure**:
```markdown
# How to [Achieve Specific Goal]

## Prerequisites
- Required knowledge
- Required tools/access
- Time estimate

## Overview
Brief description of what will be accomplished

## Steps
### Step 1: [Action]
Clear instruction with:
- Command or action
- Expected result
- Troubleshooting tips

### Step 2: [Action]
...

## Verification
How to verify success

## Troubleshooting
Common issues and solutions

## Next Steps
Related guides or advanced topics
```

#### 2. Tutorials
**Purpose**: Learning-oriented guides that teach concepts through examples
**Structure**:
```markdown
# Tutorial: [Learning Objective]

## What You'll Learn
- Learning outcome 1
- Learning outcome 2

## Before You Begin
Prerequisites and setup

## Part 1: [Concept]
### Understanding [Topic]
Explanation with examples

### Try It Yourself
Hands-on exercise

## Part 2: [Building on Concept]
...

## Summary
Key takeaways

## Practice Exercises
Self-assessment questions
```

#### 3. Troubleshooting Guides
**Purpose**: Problem-solving documentation
**Structure**:
```markdown
# Troubleshooting: [Problem Area]

## Quick Diagnosis
Flowchart or decision tree

## Common Issues

### Issue: [Symptom]
**Cause**: Explanation
**Solution**: Step-by-step fix
**Prevention**: How to avoid

## Advanced Diagnostics
Detailed investigation steps

## When to Escalate
Criteria for seeking help
```

### Quality Standards & Metrics

#### Readability Metrics (Enforced)
- **Flesch Reading Ease**: 
  - How-to guides: 60-70 (high school level)
  - Tutorials: 50-60 (some college)
  - Technical reference: 30-50 (college/graduate)
- **Gunning Fog Index**: <12 for all documentation
- **Average Sentence Length**: 15-20 words
- **Average Paragraph Length**: 3-5 sentences

#### Structure Compliance
- **Required Sections**: All template sections must be present
- **Heading Hierarchy**: Proper H1→H2→H3 nesting
- **List Formatting**: Consistent bullet/number usage
- **Code Block Formatting**: Language specification required

#### Grammar & Style (Vale Rules)
- **Passive Voice**: <10% of sentences
- **Sentence Variety**: Mix of simple, compound, complex
- **Technical Terms**: Defined on first use
- **Acronyms**: Spelled out initially
- **Consistency**: Same terminology throughout

#### Inclusive Language (Alex)
- **Gendered Language**: Neutral alternatives required
- **Ableist Language**: Accessible alternatives
- **Cultural Sensitivity**: Respectful terminology
- **Technical Jargon**: Plain language alternatives when possible

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

## Quality Gates (MANDATORY)

### Before ANY Document Commit
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