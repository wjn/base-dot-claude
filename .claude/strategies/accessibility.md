# Documentation Accessibility Standards

## Philosophy

Accessible documentation serves everyone better. Clear structure, inclusive language, and multiple format support ensure that knowledge is available regardless of ability, technology, or reading preferences. Accessibility is not optional—it's a quality requirement.

## Web Content Accessibility Guidelines (WCAG) Compliance

### Level AA Compliance (MANDATORY)
All documentation must meet WCAG 2.1 Level AA standards:

#### 1. Perceivable Content
- **Alt text for all images**: Descriptive, not decorative
- **Color contrast**: 4.5:1 minimum for normal text, 3:1 for large text
- **Scalable text**: Readable at 200% zoom without horizontal scrolling
- **Multiple format support**: HTML, PDF, plain text available

#### 2. Operable Interface  
- **Keyboard navigation**: All interactive elements accessible via keyboard
- **No seizure triggers**: No flashing content >3 times per second
- **Logical tab order**: Sequential navigation makes sense
- **Skip links**: Jump to main content available

#### 3. Understandable Content
- **Consistent navigation**: Same structure across documents
- **Clear instructions**: Unambiguous action steps
- **Error identification**: Clear feedback when something goes wrong
- **Predictable interactions**: Similar actions work the same way

#### 4. Robust Markup
- **Valid HTML**: Passes W3C validation
- **Semantic structure**: Proper heading hierarchy
- **Screen reader compatible**: Works with assistive technology
- **Progressive enhancement**: Core content available without JavaScript

## Structural Accessibility Requirements

### Heading Hierarchy (MANDATORY)
```markdown
# Document Title (H1 - One per document)
## Major Section (H2)
### Subsection (H3)
#### Detail Level (H4)
##### Specific Point (H5 - Rarely used)
###### Granular Detail (H6 - Avoid if possible)
```

**Validation:**
```bash
# Check heading hierarchy
./scripts/check-headings.sh docs/howto.md --validate-hierarchy
```

### List Structure Standards
```markdown
✅ Proper list formatting:
1. **Ordered lists** for sequential steps
   - Sub-steps indented properly
   - Consistent numbering

• **Unordered lists** for related items
  - Parallel structure maintained
  - Logical grouping

❌ Avoid:
- Using manual numbering (1. 2. 3.) instead of markdown
- Inconsistent bullet styles
- Overly nested lists (>3 levels)
```

### Table Accessibility
```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |

Requirements:
- Column headers always present
- Row headers when data is categorized
- Caption explaining table purpose
- Scope attributes in HTML output
```

## Image and Media Accessibility

### Alt Text Standards (MANDATORY)
Every image must have descriptive alt text:

```markdown
✅ Good alt text:
![Screenshot showing the Docker Desktop dashboard with three containers running: nginx, postgres, and redis. The status column shows all containers are healthy.](docker-dashboard.png)

❌ Bad alt text:
![Docker screenshot](docker-dashboard.png)
![Screenshot](docker-dashboard.png)
![](docker-dashboard.png)
```

### Alt Text Guidelines
- **Informative images**: Describe the information conveyed
- **Functional images**: Describe the action or link destination
- **Decorative images**: Use empty alt="" (rare in documentation)
- **Complex images**: Provide long description in surrounding text

### Video and Audio Accessibility
```markdown
Required for all media:
- Captions for videos (auto-generated + human-reviewed)
- Transcripts for audio content
- Audio descriptions for visual-only information
- Play/pause controls accessible via keyboard
```

## Inclusive Language Standards

### Required Language Practices
**Use person-first language:**
- "People with disabilities" not "disabled people"
- "Person who uses a wheelchair" not "wheelchair user"
- "Person with autism" not "autistic person"

**Avoid ableist language:**
❌ Prohibited terms:
- "Sanity check" → Use "logic check" or "validation"
- "Blind spot" → Use "gap" or "missed area"
- "Crippled" → Use "broken" or "non-functional"
- "Dummy" → Use "placeholder" or "example"

**Use inclusive pronouns:**
- Default to "they/them" when referring to generic users
- "The user" instead of "he/she"
- "You" for direct instruction

### Cultural Sensitivity
- **Time zones**: Specify when using time references
- **Currency**: Use multiple currency examples when relevant
- **Holidays**: Avoid assuming specific cultural/religious holidays
- **Names**: Use diverse name examples in documentation
- **Geographic references**: Include global examples, not just US-centric

## Multi-Format Support (MANDATORY)

### Required Format Availability
Every document must be available in:
1. **Web HTML**: Primary format with full interactivity
2. **PDF**: Downloadable, printable version
3. **Plain text**: Screen reader optimized
4. **EPUB**: E-reader compatible (for longer documents)

### Format Generation Pipeline
```bash
# Automated format generation
./scripts/generate-formats.sh docs/howto-docker.md

# Generates:
# - docs/howto-docker.html (with CSS and navigation)  
# - docs/howto-docker.pdf (print-optimized)
# - docs/howto-docker.txt (plain text, screen reader friendly)
# - docs/howto-docker.epub (for longer content)
```

### Format-Specific Requirements

#### HTML Output Standards
- Valid HTML5 markup
- Semantic elements (`<nav>`, `<main>`, `<article>`, `<section>`)
- Skip navigation links
- ARIA landmarks and labels
- Focus indicators visible
- Keyboard navigation support

#### PDF Output Standards  
- Bookmarks for navigation
- Logical reading order
- Alt text preserved
- High contrast mode support
- Searchable text (not image-based)

#### Plain Text Standards
- 80-character line width maximum
- Consistent indentation for structure
- ASCII art alternatives for diagrams
- URLs spelled out fully

## Accessibility Testing Requirements

### Automated Testing (MANDATORY)
```bash
# Run accessibility audits
./scripts/a11y-check.sh docs/howto-docker.html

# Tools integrated:
# - axe-core for WCAG compliance
# - Pa11y for command-line testing  
# - WAVE for web accessibility evaluation
# - Color contrast analyzers
```

### Manual Testing Checklist
- [ ] **Keyboard navigation**: Tab through entire document
- [ ] **Screen reader**: Test with NVDA, JAWS, or VoiceOver
- [ ] **High contrast**: Readable in high contrast mode
- [ ] **200% zoom**: Usable at high magnification
- [ ] **Print version**: Accessible when printed
- [ ] **Mobile responsive**: Works on small screens

### User Testing with Assistive Technology
- **Screen reader users**: Monthly testing sessions
- **Keyboard-only users**: Navigation validation
- **Voice control users**: Command compatibility
- **Low vision users**: Magnification and contrast testing

## Quality Gates for Accessibility

### Pre-Publication Requirements
```bash
# All accessibility checks must pass
./scripts/accessibility-gate.sh docs/howto-docker.md --strict

# Validation includes:
# - WCAG 2.1 AA compliance
# - Alt text coverage 100%
# - Heading hierarchy validation
# - Color contrast verification
# - Multi-format generation success
```

### Accessibility Metrics Dashboard
Track these metrics monthly:
- WCAG compliance score
- Alt text coverage percentage
- Heading hierarchy violations
- User feedback from assistive technology users
- Format download usage statistics

## Implementation Guidelines

### Content Creation Process
1. **Structure first**: Create accessible outline with proper headings
2. **Write alt text**: As you add images, write descriptive alt text
3. **Test early**: Run accessibility checks during draft phase
4. **Review language**: Check for inclusive language compliance
5. **Generate formats**: Create all required format variants
6. **User test**: Validate with actual assistive technology users

### Training Requirements for Content Creators
- **WCAG basics**: Understanding accessibility principles
- **Screen reader testing**: How to test with assistive technology
- **Inclusive language**: Recognizing and replacing problematic terms
- **Image accessibility**: Writing effective alt text
- **Keyboard navigation**: Testing without a mouse

## Accessibility Improvement Process

### When Accessibility Issues Are Found
1. **Immediate fix**: Address WCAG violations immediately
2. **Root cause analysis**: Why was this missed initially?
3. **Tool improvement**: Enhance automated checking if needed
4. **Process update**: Prevent similar issues in future content
5. **Retroactive checking**: Audit similar existing content

### Continuous Accessibility Enhancement
- **Monthly audits**: Random sampling of published content
- **User feedback integration**: Regular input from disabled users  
- **Technology updates**: Keep up with assistive technology changes
- **Training updates**: Ongoing education for content creators
- **Tool evaluation**: Regular assessment of accessibility testing tools

## Accessibility Resources

### Testing Tools
- **axe DevTools**: Browser extension for WCAG testing
- **WAVE**: Web accessibility evaluation tool
- **Pa11y**: Command-line accessibility testing
- **Colour Contrast Analyser**: Color contrast validation
- **NVDA**: Free screen reader for testing

### Reference Materials
- **WCAG 2.1 Guidelines**: https://www.w3.org/WAI/WCAG21/quickref/
- **WebAIM**: Comprehensive accessibility guidance
- **A11y Project**: Accessibility best practices
- **Inclusive Language Guide**: Preferred terminology reference
- **Screen Reader Testing Guide**: How to test effectively

### Community Resources
- **Disability advocacy groups**: User feedback and testing
- **Accessibility professionals**: Expert guidance and review
- **Open source projects**: Accessibility-focused tools and libraries
- **Standards organizations**: Latest accessibility requirements