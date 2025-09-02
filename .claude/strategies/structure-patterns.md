# Document Structure Patterns

## Philosophy

Consistent structure enables predictable navigation and comprehension. Readers should always know where they are, what's coming next, and how long tasks will take. Structure patterns are templates that enforce cognitive consistency across all documentation.

## Core Structure Templates

### 1. How-To Guide Pattern (MANDATORY Structure)
```markdown
# How to [Achieve Specific Goal]
## Prerequisites
- Skill level required
- Tools/software needed  
- Time estimate: X minutes
- Access requirements

## Overview
One paragraph: what you'll accomplish and why it matters

## Steps
### Step 1: [Action Verb + Object]
Specific instruction with:
- Exact command or click path
- Expected result/feedback
- Screenshot if UI-heavy

### Step 2: [Action Verb + Object]
...

## Verification
How to confirm success:
- What you should see
- How to test the result

## Troubleshooting
### Common Issue: [Specific Error]
- **Cause**: Why this happens
- **Solution**: Step-by-step fix
- **Prevention**: How to avoid

## Next Steps
- Related tutorials
- Advanced techniques
- Additional resources
```

### 2. Tutorial Pattern (MANDATORY Structure)
```markdown
# Tutorial: [Learning Objective]
## What You'll Learn
- Specific skill 1
- Specific skill 2
- Final outcome

## Before You Begin
Prerequisites and environment setup

## Part 1: [Foundation Concept]
### Understanding [Core Idea]
Explanation with examples

### Hands-On: [Practice Exercise]
Interactive element

### Check Your Understanding
Self-assessment question

## Part 2: [Building Complexity]
### [Advanced Concept]
Builds on Part 1

### Project: [Apply Knowledge]
Comprehensive exercise

## Summary
- Key takeaways
- Skills acquired
- Confidence checkpoint

## What's Next
- Advanced tutorials
- Real-world applications
- Community resources
```

### 3. Reference Pattern (MANDATORY Structure)
```markdown
# [API/Tool/Feature] Reference
## Quick Reference
Most common use cases in a table/list

## Complete Documentation
### Method/Feature Name
- **Purpose**: One sentence
- **Syntax**: Code example
- **Parameters**: Table with types
- **Returns**: What you get back
- **Example**: Working code sample
- **Notes**: Edge cases, limitations

## Error Messages
### Error: [Exact Message]
- **Meaning**: What went wrong
- **Solution**: How to fix
- **Related**: Similar errors
```

## Structure Compliance Validation

### Required Section Compliance
Every document type MUST have all required sections:

```bash
# Validate structure compliance
./scripts/structure-check.sh docs/howto.md --template howto
./scripts/structure-check.sh docs/tutorial.md --template tutorial
```

### Anti-Patterns to Prevent

❌ **Prohibited Structure Violations:**
1. **Missing Prerequisites**: No setup information
2. **Skipped Overview**: Diving straight into steps
3. **Unclear Steps**: Vague instructions without verification
4. **No Troubleshooting**: Ignoring error scenarios
5. **Orphaned Content**: Information without clear placement

✅ **Correct Structure Enforcement:**
1. Every how-to MUST have Prerequisites → Overview → Steps → Verification
2. Every tutorial MUST have Learning objectives → Prerequisites → Progressive parts → Summary
3. Every reference MUST have Quick access → Complete documentation → Error handling

## Information Architecture Principles

### 1. Inverted Pyramid Structure
```
Most Important (What/Why)
    ↓
Supporting Details (How)
    ↓
Additional Context (When/Where)
```

### 2. Progressive Disclosure
- **Level 1**: Essential information everyone needs
- **Level 2**: Details for implementation
- **Level 3**: Advanced configuration/troubleshooting
- **Level 4**: Reference links and deep-dive resources

### 3. Scannable Organization
- **Headers**: Descriptive and hierarchical
- **Lists**: Parallel structure and logical order
- **Code blocks**: Syntax highlighting and comments
- **Tables**: Column headers and consistent formatting

## Quality Gates for Structure

### Automated Structure Validation
```python
def validate_howto_structure(document):
    required_sections = [
        "Prerequisites", "Overview", "Steps", 
        "Verification", "Troubleshooting"
    ]
    
    for section in required_sections:
        if not section_exists(document, section):
            return False, f"Missing required section: {section}"
    
    if not has_numbered_steps(document):
        return False, "Steps must be numbered sequentially"
        
    return True, "Structure compliant"
```

### Manual Structure Review Checklist
- [ ] Title clearly states the goal/outcome
- [ ] Prerequisites list all requirements
- [ ] Overview explains value and scope
- [ ] Steps are sequential and complete
- [ ] Each step has verification criteria
- [ ] Troubleshooting covers likely issues
- [ ] Next steps provide logical progression

## Template Library

### Template Files Required
- `templates/howto.md.template`
- `templates/tutorial.md.template`
- `templates/troubleshooting.md.template`
- `templates/reference.md.template`
- `templates/quickstart.md.template`

### Template Usage Validation
```bash
# Ensure document follows template
./scripts/template-compliance.sh docs/new-howto.md --template howto

# Generate template-compliant document
./scripts/write-init.sh howto "Installing Docker" --from-template
```

## Section-Specific Requirements

### Prerequisites Section Standards
- Time estimate in minutes
- Skill level (Beginner/Intermediate/Advanced)
- Required tools with version numbers
- Access permissions needed
- Links to prerequisite knowledge

### Steps Section Standards
- Numbered list (1, 2, 3...)
- One action per step
- Expected result after each step
- Code blocks with syntax highlighting
- UI elements in **bold**

### Troubleshooting Section Standards
- Error message exactly as displayed
- Root cause explanation
- Step-by-step solution
- Prevention guidance
- When to escalate

## Continuous Structure Improvement

### Structure Analytics
Track these metrics:
- Section completion rates (where users drop off)
- Most skipped sections
- Most referenced troubleshooting items
- Time spent per section type

### Template Evolution Process
1. **Usage analysis**: Which sections get most attention
2. **User feedback**: Where people get confused
3. **Template updates**: Improve based on data
4. **Validation testing**: Ensure new templates work
5. **Migration planning**: Update existing content