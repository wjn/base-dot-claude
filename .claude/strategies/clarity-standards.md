# Writing Clarity Standards

## Philosophy

Clear writing is the foundation of effective documentation. Every sentence must serve the reader's need to understand and take action. Clarity is measured objectively through readability metrics and subjectively through user comprehension testing.

## Measurable Clarity Requirements

### 1. Readability Metrics (MANDATORY)
- **Flesch Reading Ease**: 60-70 for how-to guides (high school level)
- **Gunning Fog Index**: <12 for all documentation
- **Average Sentence Length**: 15-20 words maximum
- **Syllables per Word**: <1.6 average
- **Passive Voice**: <10% of sentences

### 2. Sentence Structure Standards
✅ **Preferred Patterns:**
```markdown
Do X to achieve Y.
X happens when you do Y.
Follow these steps: 1. Action, 2. Action, 3. Result.
```

❌ **Avoid These Patterns:**
```markdown
It should be noted that X might be done by the user.
There are several ways in which this could be accomplished.
One could potentially consider doing X in order to...
```

### 3. Word Choice Guidelines
- **Use common words**: "help" not "facilitate"
- **Be specific**: "Click Save" not "save your work"
- **Avoid hedging**: "Do this" not "you might want to try doing this"
- **Active voice**: "Configure the server" not "the server should be configured"

## Anti-Patterns to Detect and Prevent

### 1. Bureaucratic Language
❌ **Prohibited Patterns:**
- "It should be noted that..."
- "Please be aware that..."
- "Users are advised to..."
- "One should consider..."

✅ **Clear Alternatives:**
- "Note:"
- "Remember:"
- "You should..."
- "Consider..."

### 2. Unnecessary Complexity
❌ **Prohibited Patterns:**
- Technical jargon without definition
- Multiple negatives ("not uncommon", "not impossible")
- Nominalizations ("make a decision" → "decide")
- Wordy phrases ("in order to" → "to")

### 3. Vague Instructions
❌ **Prohibited Patterns:**
```markdown
Configure the appropriate settings.
Adjust the parameters as needed.
Ensure proper setup before proceeding.
```

✅ **Specific Instructions:**
```markdown
Set the timeout to 30 seconds in the Configuration panel.
Change the buffer size to 1024MB.
Install Node.js version 18 or higher before continuing.
```

## Quality Gates

### Before Document Commit
```bash
# Readability must pass target range
textstat-check docs/howto.md --flesch-min 60 --flesch-max 70

# No passive voice violations
passive-voice-check docs/howto.md --threshold 10

# Jargon detection
jargon-check docs/howto.md --define-technical-terms
```

### Automated Clarity Checks
1. **Sentence Length Analysis**: Flag sentences >25 words
2. **Reading Level**: Must match target audience
3. **Passive Voice Detection**: <10% threshold
4. **Weak Words**: Eliminate "very", "quite", "rather"
5. **Jargon Detection**: All technical terms defined

## Implementation Checklist

- [ ] Every technical term defined on first use
- [ ] No sentence exceeds 20 words without justification
- [ ] Active voice used for instructions
- [ ] Specific examples provided for abstract concepts
- [ ] Step-by-step sequences numbered clearly
- [ ] Error messages and troubleshooting included
- [ ] Success criteria explicitly stated

## Measurement and Improvement

### Quality Metrics Dashboard
Track these metrics for every document:
- Flesch Reading Ease score
- Average sentence length
- Percentage passive voice
- Technical terms defined ratio
- Reader completion rate (if available)

### Continuous Improvement Process
1. **Baseline measurement** of existing content
2. **Target setting** based on audience needs
3. **Regular assessment** using automated tools
4. **User testing** for comprehension validation
5. **Iterative improvement** based on feedback