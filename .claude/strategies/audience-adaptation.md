# Audience Adaptation Standards ## Philosophy One size fits no one. Documents must be explicitly crafted for specific audiences with measurable adaptations in complexity, tone, examples, and depth. Generic documentation fails everyone; targeted documentation succeeds for its intended readers. ## Audience Classifications ### 1. Beginner (0-6 months experience)
**Characteristics:**
- Learning fundamental concepts
- Needs extensive context and explanation
- Benefits from step-by-step screenshots
- Requires confidence-building language **Adaptation Requirements:**
- **Reading Level**: Flesch score 70-80 (7th-8th grade)
- **Sentence Length**: 12-15 words average
- **Technical Terms**: All defined immediately
- **Examples**: Real-world, relatable scenarios
- **Tone**: Encouraging, supportive, patient **Content Structure:**
```markdown
## What You'll Do (Not just "Overview")
You'll learn to set up Docker, like creating individual containers for your applications... ## Step 1: Download Docker
1. Go to https://docker.com/get-started
2. Click the blue "Download Docker Desktop" button
3. Your browser will download a file called "Docker Desktop Installer.exe" - This goes to your Downloads folder
``` ### 2. Intermediate (6 months - 2 years experience)
**Characteristics:**
- Understands basic concepts
- Wants efficient, focused guidance
- Appreciates shortcuts and best practices
- Can troubleshoot simple issues independently **Adaptation Requirements:**
- **Reading Level**: Flesch score 60-70 (high school)
- **Sentence Length**: 15-18 words average
- **Technical Terms**: Brief definition on first use
- **Examples**: Task-focused, less hand-holding
- **Tone**: Collaborative, professional **Content Structure:**
```markdown
## Prerequisites
- Basic command line experience
- Understanding of containers concept
- Admin access to your machine ## Installation Process
1. Download Docker Desktop from docker.com
2. Run the installer with admin privileges
3. Restart your machine when prompted
``` ### 3. Advanced (2+ years experience)
**Characteristics:**
- Familiar with domain concepts
- Values comprehensive reference information
- Wants to understand edge cases and limitations
- Needs integration details and architecture context **Adaptation Requirements:**
- **Reading Level**: Flesch score 30-50 (college/graduate)
- **Sentence Length**: 18-25 words average
- **Technical Terms**: Used without definition
- **Examples**: Complex, real-world scenarios
- **Tone**: Peer-to-peer, technical precision **Content Structure:**
```markdown
## Docker Desktop Installation
Standard installation via official installer with enterprise considerations: 1. `wget https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe`
2. Install with `--quiet --accept-license` flags for automation
3. Configure daemon.json for custom registry endpoints
``` ## Tone Adaptation Requirements ### Beginner Tone Standards
✅ **Encouraging Language:**
- "Great job! You've completed..."
- "Don't worry if this seems complex..."
- "This is a common question..."
- "You're doing exactly the right thing by..." ❌ **Avoid for Beginners:**
- "Obviously..."
- "Simply..."
- "Just do X..." (implies it's easy when it might not be)
- "Everyone knows..." ### Intermediate Tone Standards
✅ **Collaborative Language:**
- "You'll want to consider..."
- "A common approach is..."
- "This method works well when..."
- "You can also..." ### Advanced Tone Standards
✅ **Technical Precision:**
- "The implementation leverages..."
- "Performance characteristics include..."
- "Edge cases to consider..."
- "Alternative architectures..." ## Content Depth Adaptation ### Beginner Content Requirements
- **Context First**: Why before how
- **Screenshots**: Visual confirmation for every step
- **Error Prevention**: Common mistakes highlighted upfront
- **Success Indicators**: Clear "you did it right" confirmation
- **Next Steps**: Guided progression path ### Intermediate Content Requirements
- **Efficient Steps**: Combined actions where safe
- **Options**: Multiple approaches with trade-offs
- **Troubleshooting**: Self-service problem solving
- **Integration**: How this fits with other tools
- **Customization**: Configuration options explained ### Advanced Content Requirements
- **Architecture**: System design implications
- **Performance**: Benchmarks and optimization
- **Security**: Threat model and mitigations
- **Extensibility**: APIs and customization points
- **Operations**: Monitoring and maintenance ## Example Adaptation Validation ### The Same Concept for Different Audiences #### Beginner Version:
```markdown
## What is Docker?
Docker is like having separate apartments for your applications. Just like how each apartment has its own kitchen, bathroom, and bedroom, each Docker container has everything your application needs to run independently. This means if one application breaks, it won't affect the others - just like a problem in apartment 3B doesn't affect apartment 3C.
``` #### Intermediate Version:
```markdown
## Docker Overview
Docker containerizes applications with their dependencies, ensuring consistent environments across development, testing, and production. This eliminates "works on my machine" issues by packaging applications with their required libraries and configurations.
``` #### Advanced Version:
```markdown
## Docker Architecture
Docker uses Linux kernel namespaces and cgroups to provide process isolation and resource limiting. The daemon manages container lifecycle through a REST API, with containerd handling runtime operations and runc executing OCI-compliant containers.
``` ## Quality Gates for Audience Adaptation ### Automated Audience Validation
```bash
# Check reading level matches target audience
audience-check docs/beginner-guide.md --target beginner --flesch-min 70 # Validate tone appropriateness
tone-check docs/intermediate-guide.md --audience intermediate # Screenshot coverage for beginner content
screenshot-coverage docs/beginner-guide.md --min-coverage 80
``` ### Audience Testing Requirements
- **Beginner Content**: Must be tested by actual beginners
- **Task Completion**: >90% success rate for intended audience
- **Time Estimates**: Validated with real users
- **Confusion Points**: Identified and addressed ## Multi-Audience Document Strategy ### When to Create Multiple Versions
Create separate documents when:
- Audiences have different needs
- Single document would be >5000 words
- Reading levels differ by >20 Flesch points
- Prerequisites vary significantly ### When to Use Progressive Disclosure
Use single document with layered content when:
- Core task is the same
- Advanced users want quick access to basics
- Maintenance overhead of multiple docs is high ### Implementation Pattern
```markdown
# Installing Docker ## Quick Start (Intermediate/Advanced)
<details>
<summary>Skip to installation commands</summary>
[Streamlined steps for experienced users]
</details> ## Complete Guide (Beginner-Friendly)
[Full detailed walkthrough]
``` ## Audience Feedback Integration ### Required Feedback Mechanisms
- **Difficulty Rating**: "Was this too easy, just right, or too hard?"
- **Clarity Rating**: "Was this clear or confusing?"
- **Completion Success**: "Did you achieve the goal?"
- **Time Tracking**: "How long did this take?" ### Feedback Analysis Process
1. **Quantitative Metrics**: Success rates, time-to-completion
2. **Qualitative Feedback**: Where people got stuck
3. **Content Adjustment**: Adapt based on patterns
4. **A/B Testing**: Compare audience adaptations
5. **Continuous Improvement**: Regular content updates ## Implementation Checklist ### Before Publishing Any Document
- [ ] Target audience explicitly identified
- [ ] Reading level measured and appropriate
- [ ] Tone consistent throughout
- [ ] Example complexity matches audience
- [ ] Prerequisites align with audience skill level
- [ ] Success criteria appropriate for experience level
- [ ] Troubleshooting depth matches audience capability ### Audience Validation Process
1. **Define target audience** with specific characteristics
2. **Set measurable adaptation criteria** (reading level, tone, depth)
3. **Create content** following audience guidelines
4. **Test with representative users** from target audience
5. **Measure success metrics** (completion rate, satisfaction)
6. **Iterate based on feedback** and performance data