# Verification Checklist ## Philosophy Documents must be verifiable before publication, just like code must pass tests before deployment. This checklist provides mandatory gates that ensure quality, accuracy, and user success. No document ships without passing all verification criteria. ## Pre-Publication Quality Gates (MANDATORY) ### 1. Technical Accuracy Gate
**All code examples and instructions must be tested** ```bash
# Required testing commands./scripts/test-code-examples.sh docs/howto-docker.md./scripts/verify-links.sh docs/howto-docker.md --check-external./scripts/validate-screenshots.sh docs/howto-docker.md --check-current
``` **Verification Criteria:**
- [ ] Every command executed successfully in clean environment
- [ ] All links return 200 status (or appropriate redirects)
- [ ] Screenshots reflect current UI (within 30 days)
- [ ] Version numbers match current releases
- [ ] File paths and directory structures exist ### 2. Readability Gate
**Measurable reading difficulty appropriate for target audience** ```bash
# Readability validation./scripts/readability-check.sh docs/howto-docker.md \ --audience technical \ --flesch-min 60 \ --flesch-max 70 \ --fog-max 12
``` **Verification Criteria:**
- [ ] Flesch Reading Ease within target range (±5 points)
- [ ] Gunning Fog Index <12
- [ ] Average sentence length 15-20 words
- [ ] Passive voice <10% of sentences
- [ ] Technical jargon defined on first use ### 3. Structure Compliance Gate
**Document follows approved template pattern** ```bash
# Structure validation./scripts/structure-check.sh docs/howto-docker.md --template howto --strict
``` **Verification Criteria:**
- [ ] All required sections present
- [ ] Heading hierarchy correct (H1→H2→H3)
- [ ] Step numbering sequential and clear
- [ ] Code blocks have language specification
- [ ] Lists use consistent formatting ### 4. Grammar and Style Gate
**Professional writing quality maintained** ```bash
# Language quality checks
vale docs/howto-docker.md --config.vale.ini
write-good docs/howto-docker.md
alex docs/howto-docker.md --quiet
``` **Verification Criteria:**
- [ ] Grammar score ≥95% (Vale or LanguageTool)
- [ ] No inclusive language violations (Alex)
- [ ] Consistent terminology throughout
- [ ] Style guide compliance (company voice)
- [ ] Spelling errors eliminated ### 5. User Success Gate
**Document enables target audience to achieve stated goal** **Verification Criteria:**
- [ ] Prerequisites clearly listed and achievable
- [ ] Success criteria explicitly stated
- [ ] Time estimate provided and realistic
- [ ] Troubleshooting covers common failure points
- [ ] Verification steps confirm goal achievement ## Detailed Verification Procedures ### Technical Accuracy Verification Process #### Code Example Testing
```bash
#!/bin/bash
# scripts/test-code-examples.sh # Extract all code blocks from markdown
grep -A 10 '```bash' "$1" | grep -v '```' > temp_commands.sh # Test in isolated environment
docker run --rm -v $(pwd):/workspace ubuntu:latest bash -c " cd /workspace bash temp_commands.sh 2>&1 | tee test_output.log
" # Verify expected outputs match./scripts/verify-expected-output.sh temp_commands.sh test_output.log
``` #### Link Validation Process
```bash
#!/bin/bash
# scripts/verify-links.sh # Check all markdown links
markdown-link-check "$1" --config link-check-config.json # Check external links with custom retry
curl-check-links "$1" --retry 3 --timeout 10 --ignore-patterns "localhost,127.0.0.1"
``` ### Readability Verification Process #### Automated Readability Analysis
```python
#!/usr/bin/env python3
# scripts/readability-check.py import textstat
import argparse
import sys def check_readability(file_path, audience): with open(file_path, 'r') as f: text = f.read() flesch_score = textstat.flesch_reading_ease(text) fog_score = textstat.gunning_fog(text) targets = { 'beginner': (70, 80), 'technical': (60, 70), 'expert': (30, 50) } min_score, max_score = targets.get(audience, (60, 70)) if not (min_score <= flesch_score <= max_score): print(f"FAIL: Flesch score {flesch_score} outside target {min_score}-{max_score}") return False if fog_score > 12: print(f"FAIL: Fog index {fog_score} exceeds maximum 12") return False print(f"PASS: Readability appropriate for {audience} audience") return True
``` ### Structure Compliance Verification #### Template Validation
```python
#!/usr/bin/env python3
# scripts/structure-check.py import re
import sys def validate_howto_structure(content): required_sections = [ r'# How to.+', # Title r'## Prerequisites', # Prerequisites r'## Overview', # Overview r'## Steps', # Steps r'## Verification', # Verification r'## Troubleshooting' # Troubleshooting ] for i, section_pattern in enumerate(required_sections): if not re.search(section_pattern, content, re.MULTILINE): print(f"FAIL: Missing required section matching {section_pattern}") return False # Check step numbering step_pattern = r'### Step \d+:' steps = re.findall(step_pattern, content) if not steps: print("FAIL: No numbered steps found") return False # Verify sequential numbering expected_numbers = list(range(1, len(steps) + 1)) actual_numbers = [int(re.search(r'Step (\d+)', step).group(1)) for step in steps] if actual_numbers!= expected_numbers: print(f"FAIL: Step numbering not sequential. Found: {actual_numbers}") return False print("PASS: Document structure compliant with howto template") return True
``` ## Quality Assurance Workflow ### Pre-Commit Verification (Automated)
```bash
#!/bin/bash
#.git/hooks/pre-commit for writing projects echo "Running document quality checks..." # Get all staged markdown files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(md|markdown)$') if [ -z "$STAGED_FILES" ]; then echo "No markdown files to check" exit 0
fi FAILED=false for FILE in $STAGED_FILES; do echo "Checking $FILE..." # Technical accuracy if!./scripts/test-code-examples.sh "$FILE"; then echo "❌ Code examples failed for $FILE" FAILED=true fi # Readability if!./scripts/readability-check.sh "$FILE"; then echo "❌ Readability check failed for $FILE" FAILED=true fi # Structure if!./scripts/structure-check.sh "$FILE"; then echo "❌ Structure check failed for $FILE" FAILED=true fi # Grammar and style if! vale "$FILE" --config.vale.ini --minAlertLevel error; then echo "❌ Grammar/style check failed for $FILE" FAILED=true fi
done if [ "$FAILED" = true ]; then echo "❌ Document quality checks failed. Commit blocked." exit 1
else echo "✅ All document quality checks passed" exit 0
fi
``` ### Manual Review Checklist #### Content Review (Human Required)
- [ ] **Goal Achievement**: Document enables stated outcome
- [ ] **Audience Appropriate**: Matches target user needs
- [ ] **Logical Flow**: Information presented in optimal order
- [ ] **Completeness**: No critical steps or information missing
- [ ] **Clarity**: Complex concepts explained adequately
- [ ] **Examples**: Relevant and helpful illustrations provided #### Technical Review (Subject Matter Expert)
- [ ] **Accuracy**: Technical information correct and current
- [ ] **Best Practices**: Recommendations align with industry standards
- [ ] **Security**: No security anti-patterns or vulnerabilities
- [ ] **Compatibility**: Version numbers and requirements current
- [ ] **Scalability**: Guidance works at intended scale
- [ ] **Edge Cases**: Common failure scenarios addressed ## Verification Reporting ### Quality Report Generation
```bash
#!/bin/bash
# scripts/generate-quality-report.sh DOCS_DIR="$1"
REPORT_FILE="quality-report-$(date +%Y%m%d).html" cat > "$REPORT_FILE" << 'EOF'
<!DOCTYPE html>
<html>
<head> <title>Document Quality Report</title> <style>.pass { color: green; }.fail { color: red; }.metric { margin: 10px 0; } </style>
</head>
<body> <h1>Document Quality Report</h1>
EOF for doc in "$DOCS_DIR"/*.md; do echo "<h2>$(basename "$doc")</h2>" >> "$REPORT_FILE" # Run all checks and format results./scripts/readability-check.sh "$doc" --format html >> "$REPORT_FILE"./scripts/structure-check.sh "$doc" --format html >> "$REPORT_FILE"./scripts/test-code-examples.sh "$doc" --format html >> "$REPORT_FILE"
done echo "</body></html>" >> "$REPORT_FILE"
echo "Quality report generated: $REPORT_FILE"
``` ### Continuous Monitoring #### Quality Dashboard Metrics
```bash
# Track these metrics over time:
- Document readability scores (trend analysis)
- Code example pass/fail rates
- Link validity percentage - Time since last content update
- User success rates (if available)
- Feedback sentiment analysis
``` ## Verification Tool Configuration ### Vale Configuration (.vale.ini)
```ini
StylesPath =.vale/styles
MinAlertLevel = warning [formats]
mdx = md [*]
BasedOnStyles = Vale, write-good, alex [*.md]
Vale.Hedging = NO
Vale.Wordiness = YES
write-good.Weasel = YES
alex.Condescending = YES
``` ### Link Check Configuration (link-check-config.json)
```json
{ "timeout": "10s", "retryCount": 3, "retryOn429": true, "aliveStatusCodes": [200, 206, 301, 302, 404], "ignorePatterns": [ {"pattern": "^http://localhost"}, {"pattern": "^https://127.0.0.1"}, {"pattern": "^file://"} ]
}
``` ## Recovery and Improvement Process ### When Verification Fails #### Immediate Actions
1. **Block publication** until issues resolved
2. **Document specific failures** for improvement tracking
3. **Provide actionable feedback** to content creators
4. **Update verification tools** if legitimate edge cases found #### Continuous Improvement
1. **Analyze failure patterns** to improve verification
2. **Update templates** based on common issues
3. **Enhance tooling** to catch more problems automatically
4. **Training updates** for content creators ### Quality Metrics Tracking #### Monthly Quality Report
- Verification pass rates by document type
- Common failure categories
- Time-to-fix metrics for failed documents
- User success correlation with quality scores #### Verification Tool Evolution
- False positive rate monitoring
- Missing issue detection (things that passed but shouldn't)
- Performance optimization for verification speed
- New verification capabilities based on feedback