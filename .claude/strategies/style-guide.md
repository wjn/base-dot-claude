# Writing Style Guide

## Philosophy

Consistent style creates predictable, professional documentation that reduces cognitive load for readers. Every style choice should serve clarity and usability, not arbitrary preferences. Style rules are enforced through automation wherever possible.

## Voice and Tone Standards

### Organizational Voice (Consistent Across All Content)
- **Helpful**: We exist to solve problems and enable success
- **Clear**: Communication is direct and unambiguous  
- **Professional**: Competent without being intimidating
- **Inclusive**: Welcoming to all skill levels and backgrounds
- **Reliable**: Information is accurate and trustworthy

### Tone Adaptation by Document Type

#### How-To Guides (Instructional)
- **Encouraging**: "You've got this" attitude
- **Patient**: Step-by-step without rushing
- **Supportive**: Acknowledges potential challenges
- **Direct**: Clear actions without hedging

Example:
```markdown
✅ Good: "Click Save to store your changes."
❌ Poor: "You might want to consider perhaps saving your work."
```

#### Tutorials (Educational)  
- **Engaging**: Learning should be interesting
- **Progressive**: Building confidence with each step
- **Explanatory**: Why as well as how
- **Collaborative**: "Let's learn this together"

Example:
```markdown
✅ Good: "Now that you understand containers, let's see how they communicate."
❌ Poor: "The next section will cover inter-container communication protocols."
```

#### Reference Documentation (Informational)
- **Precise**: Exact technical specifications
- **Comprehensive**: Complete information available
- **Neutral**: Objective presentation
- **Efficient**: Quick access to needed information

Example:  
```markdown
✅ Good: "Returns HTTP 200 on success, 400 for invalid parameters."
❌ Poor: "You'll typically get a success response unless something goes wrong."
```

## Grammar and Punctuation Standards

### Sentence Structure Requirements
- **Active voice preferred**: "Configure the server" not "The server should be configured"
- **Parallel structure in lists**: All items follow same grammatical pattern
- **Sentence length**: 15-20 words average, 25 words maximum
- **Variety**: Mix simple, compound, and complex sentences

### Punctuation Rules (Enforced)
- **Oxford comma**: Always use in series of three or more
- **Contractions**: Avoid in formal documentation ("do not" not "don't")
- **Apostrophes**: Use correctly for possession, not for plurals
- **Quotation marks**: Double quotes for UI elements, single for quotes within quotes

### Common Grammar Fixes
❌ **Incorrect**:
- "There are several ways to do this"
- "It is recommended that you should..."  
- "The system will automatically..."
- "Please note that..."

✅ **Correct**:
- "You can do this in several ways"
- "We recommend..."
- "The system automatically..."
- "Note:"

## Word Choice and Usage

### Preferred Technical Terms
Maintain consistency in technical vocabulary:

| Use This | Not This |
|----------|----------|
| sign in | log in, login |
| set up (verb) | setup |
| email | e-mail |
| website | web site |
| username | user name |
| filename | file name |
| backup (noun) | back-up |
| back up (verb) | backup |

### Inclusive Language Requirements (MANDATORY)
Replace biased or exclusionary language:

| Avoid | Use Instead |
|-------|-------------|
| guys, mankind | everyone, people, team |
| master/slave | primary/secondary, leader/follower |
| whitelist/blacklist | allowlist/denylist |
| sanity check | logic check, validation |
| dummy | placeholder, example |
| native | built-in, original |

### Plain Language Principles
- **Choose simple words**: "use" not "utilize"
- **Avoid redundancy**: "close proximity" → "close"
- **Eliminate filler**: Remove "that" where unnecessary
- **Concrete specifics**: "5 minutes" not "a few minutes"

## Formatting Standards

### Heading Capitalization
- **H1 (Title)**: Title Case (Major Words Capitalized)
- **H2-H6**: Sentence case (Only first word and proper nouns)

```markdown
# How to Install Docker Desktop
## Prerequisites and system requirements  
### Checking your operating system
```

### List Formatting Rules
**Ordered lists** for sequential processes:
```markdown
1. Download the installer
2. Run the installer with admin privileges
3. Restart your computer
4. Verify the installation
```

**Unordered lists** for related items:
```markdown
- Docker Desktop
- Visual Studio Code
- Git command line tools
```

### Code and UI Element Formatting

#### Code Formatting Standards
- **Inline code**: Use backticks for commands, file names, variables
- **Code blocks**: Use fenced blocks with language specification
- **Output examples**: Show expected results after commands

```markdown
Run `docker --version` to check your installation.

```bash
docker run hello-world
```

Expected output:
```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```
```

#### UI Element Formatting
- **Buttons and menu items**: Use **bold formatting**
- **User input**: Use `code formatting` for text user types
- **File paths**: Use `code formatting` for paths
- **Keyboard shortcuts**: Use **Ctrl+C** format

```markdown
1. Click **File** > **Save As**
2. Type `my-document.txt` in the filename field  
3. Press **Ctrl+S** to save
```

## Content Organization Standards

### Information Hierarchy
Structure information by importance and logical flow:

```markdown
1. **What** (goal/outcome)
2. **Why** (context/importance) 
3. **Prerequisites** (requirements)
4. **How** (step-by-step process)
5. **Verification** (success confirmation)
6. **Troubleshooting** (common issues)
7. **Next steps** (related topics)
```

### Paragraph Length Guidelines
- **Maximum**: 5 sentences per paragraph
- **Optimal**: 3-4 sentences average
- **Minimum**: Avoid single-sentence paragraphs (except for emphasis)

### Transition and Connection
Use transition words to connect ideas:
- **Sequence**: First, next, then, finally
- **Cause/effect**: Because, therefore, as a result
- **Contrast**: However, although, instead
- **Addition**: Also, furthermore, in addition

## Numbers and Measurements

### Number Usage Rules
- **Spell out**: One through nine in body text
- **Use numerals**: 10 and above, all numbers in lists/tables
- **Technical contexts**: Always use numerals for versions, quantities, measurements

Examples:
```markdown
✅ "Follow these three steps to install five packages."
✅ "Configure port 8080 for the development server."
✅ "Version 3.2.1 requires at least 4GB of RAM."
```

### Time and Date Formatting
- **Time**: Use 12-hour format with AM/PM
- **Dates**: Use YYYY-MM-DD format for technical documentation
- **Duration**: "5 minutes" not "5 mins"
- **Time zones**: Always specify when relevant

## Link and Reference Standards

### Link Text Requirements
- **Descriptive**: Explain what the link contains
- **Contextual**: Makes sense when read alone
- **Action-oriented**: Use verbs when appropriate

```markdown
✅ Good: "Read the [Docker installation guide](link) for detailed setup instructions."
❌ Poor: "Click [here](link) for more information."
```

### Citation and Attribution
- **External sources**: Always attribute information
- **Code examples**: Credit original authors when adapted
- **Screenshots**: Include version/date information
- **Links**: Check validity before publication

## Abbreviations and Acronyms

### Acronym Usage Rules
1. **First use**: Spell out with acronym in parentheses
2. **Subsequent use**: Acronym only
3. **Well-known**: OK to use without definition (HTML, PDF, API)
4. **Document-specific**: Define even if common in field

```markdown
✅ "Configure the Application Programming Interface (API) endpoint. The API should respond within 200ms."

❌ "Configure the API endpoint. The Application Programming Interface should respond quickly."
```

## Quality Enforcement

### Automated Style Checking
```bash
# Required style validation tools
vale docs/howto.md --config .vale.ini
write-good docs/howto.md --parse
proselint docs/howto.md

# Style guide compliance check
./scripts/style-check.sh docs/howto.md --guide company
```

### Style Guide Violations That Block Publication
- **Inconsistent terminology**: Same concept described differently
- **Accessibility failures**: Missing alt text, poor heading hierarchy
- **Grammar errors**: Mistakes detected by automated tools
- **Format violations**: Incorrect heading capitalization, list formatting

### Manual Style Review Checklist
- [ ] Voice and tone appropriate for document type
- [ ] Consistent terminology throughout
- [ ] Inclusive language used exclusively  
- [ ] Active voice predominant
- [ ] Parallel structure in lists
- [ ] Proper heading hierarchy
- [ ] Code and UI elements formatted correctly
- [ ] Links descriptive and functional

## Style Guide Evolution

### Updating Style Standards
1. **Usage analysis**: Identify common patterns in existing content
2. **User feedback**: Gather input on clarity and effectiveness
3. **Industry changes**: Adapt to evolving technical language
4. **Accessibility updates**: Incorporate new inclusive language guidance
5. **Tool improvements**: Update enforcement mechanisms

### Style Consistency Monitoring
Track these metrics monthly:
- Terminology consistency score
- Automated style check pass rate
- Reading level variance
- User preference feedback
- Style guide violation categories

### Training and Adoption
- **New team member onboarding**: Style guide overview and tools
- **Regular refreshers**: Updates when guide changes
- **Examples library**: Good and bad examples for common situations  
- **Writing workshops**: Hands-on practice with style requirements
- **Peer review training**: How to identify and fix style issues