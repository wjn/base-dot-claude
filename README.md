# Base .claude Configuration Repository

A comprehensive technical writing framework with multiple specialized configurations available through different branches. Each branch provides a tailored setup for specific use cases and industries.

## 🚀 Quick Start

### Recommended Setup (Best Practice)

The recommended approach is to integrate this as a secondary remote in your project:

```bash
# 1. Clone the base-dot-claude repository
git clone https://github.com/[username]/base-dot-claude.git my-project
cd my-project

# 2. Rename the remote from 'origin' to 'claude'
git remote rename origin claude

# 3. Add your actual project repository as 'origin'
git remote add origin https://github.com/[your-username]/[your-project].git

# 4. Verify your remotes
git remote -v
# Should show:
# claude    https://github.com/[username]/base-dot-claude.git (fetch)
# claude    https://github.com/[username]/base-dot-claude.git (push)
# origin    https://github.com/[your-username]/[your-project].git (fetch)
# origin    https://github.com/[your-username]/[your-project].git (push)

# 5. Select the appropriate configuration branch
git checkout -b main claude/python  # or claude/java, claude/writing-howto, etc.

# 6. Push to your project repository
git push -u origin main
```

### Keeping Configurations Updated

With this setup, you can easily pull updates from base-dot-claude:

```bash
# Fetch latest changes from base-dot-claude
git fetch claude

# Merge updates from a specific branch
git merge claude/python  # or any other branch

# Pull latest configuration updates
git pull claude python
```

### Alternative: Simple Clone

For quick testing or exploration:

```bash
# Clone and explore
git clone https://github.com/[username]/base-dot-claude.git
cd base-dot-claude

# View all available branches
git branch -a

# Switch to a specific configuration
git checkout [branch-name]
```

## 📁 Available Branches

### `python` - Python Development Standards
Enhanced configuration for Python projects with strict quality standards.
```bash
git checkout python
```
**Contains:**
- Python-specific development standards
- PEP 8 compliance tools
- FastAPI and backend development patterns
- Repository design patterns
- Python testing and quality gates
- Technical writing framework base

### `java` - Java Enterprise Development
Configuration for Java/Spring Boot projects with enterprise standards.
```bash
git checkout java
```
**Contains:**
- Java enterprise development standards
- Spring Boot patterns and best practices
- Maven/Gradle build configurations
- JUnit testing frameworks
- Google Java Style Guide compliance

### `writing-howto` - How-To Documentation Framework
Specialized for creating step-by-step instructional content.
```bash
git checkout writing-howto
```
**Contains:**
- How-to guide templates and structures
- Readability optimization tools
- Step-by-step instruction patterns
- Quality gates for instructional content
- User-focused writing standards

### `writing-technical` - Technical Documentation Framework
Advanced technical writing with MCP integration.
```bash
git checkout writing-technical
```
**Contains:**
- API documentation templates
- Architecture decision records (ADR)
- RFC templates and processes
- MCP-powered content transformation
- Multi-audience optimization tools

### Additional Branches (Coming Soon)
Additional specialized branches may be added for:
- `javascript` - Node.js and frontend development
- `devops` - Infrastructure and CI/CD pipelines
- `data-science` - Data analysis and ML projects
- `api-docs` - API documentation specialization

## 💡 Usage Patterns

### 1. Starting a New Project (Recommended)
```bash
# Clone base-dot-claude
git clone https://github.com/[username]/base-dot-claude.git my-new-project
cd my-new-project

# Set up remotes properly
git remote rename origin claude
git remote add origin https://github.com/[your-username]/my-new-project.git

# Create main branch from desired configuration
git checkout -b main claude/python  # or claude/java, etc.

# Push to your repository
git push -u origin main

# Future updates from base-dot-claude
git fetch claude
git merge claude/python  # when you want updates
```

### 2. Adding to Existing Project
```bash
# In your existing project
cd your-existing-project

# Add base-dot-claude as remote named 'claude'
git remote add claude https://github.com/[username]/base-dot-claude.git
git fetch claude

# Merge desired configuration
git merge claude/python --allow-unrelated-histories  # or claude/java, etc.

# Resolve conflicts if needed
git commit
```

### 3. Cherry-Picking Specific Files
```bash
# After adding claude remote
git fetch claude

# View file from specific branch without switching
git show claude/python:CLAUDE.md

# Copy specific files from claude branches
git checkout claude/python -- CLAUDE.md
git checkout claude/java -- .gitignore
git checkout claude/writing-technical -- .claude/strategies/

# Commit the cherry-picked files
git add .
git commit -m "Add configurations from base-dot-claude"
```

### 4. Comparing and Exploring Configurations
```bash
# Compare files between claude branches
git diff claude/python..claude/java -- CLAUDE.md

# See commits unique to each branch
git log claude/python..claude/java --oneline
git log claude/java..claude/python --oneline

# List files in a claude branch without switching
git ls-tree claude/writing-howto --name-only
```

### 5. Syncing Updates from base-dot-claude
```bash
# Fetch latest changes from base-dot-claude
git fetch claude

# See what's new
git log HEAD..claude/python --oneline

# Merge updates
git merge claude/python

# Or rebase if you prefer
git rebase claude/python
```

## 📋 Branch Selection Guide

Choose your branch based on your project type:

| Project Type | Recommended Branch | Key Features |
|-------------|-------------------|--------------|
| Python API/Backend | `python` | PEP 8, FastAPI patterns, testing |
| Java Enterprise | `java` | Spring Boot, Maven/Gradle, JUnit |
| How-To Guides | `writing-howto` | Step-by-step templates, readability |
| Technical Docs | `writing-technical` | API docs, ADRs, MCP integration |
| Full-Stack Application | Multiple branches | Cherry-pick from relevant branches |

## 🔧 Customization

### Creating Your Own Configuration Branch
```bash
# With the recommended remote setup
git fetch claude
git checkout -b my-custom-config claude/python  # Base it on desired branch

# Add your customizations
echo "## My Custom Standards" >> CLAUDE.md
git add CLAUDE.md
git commit -m "Add custom configuration"

# Push to your repository (origin)
git push -u origin my-custom-config
```

### Keeping Your Custom Branch Updated
```bash
# Fetch updates from base-dot-claude
git fetch claude

# Merge updates from the base branch you forked from
git checkout my-custom-config
git merge claude/python  # or whichever branch you based it on

# Resolve any conflicts and commit
git commit
git push origin my-custom-config
```

### Contributing Back
If you've made improvements that others might benefit from:
```bash
# Create a feature branch
git checkout -b feature/my-improvement claude/python

# Make your changes
# ... edit files ...
git add .
git commit -m "Add improvement description"

# Push to your fork and create a pull request
git push origin feature/my-improvement
```

## 🛠️ Tools and Scripts

All branches include core tools in `/scripts`:
- `write-check.sh` - Quality validation
- `write-fix.sh` - Automated fixes
- `write-init.sh` - Document initialization
- `write-assist.sh` - AI-powered assistance

Branch-specific tools are documented in each branch's CLAUDE.md.

## 📚 Documentation

Each branch contains:
- `CLAUDE.md` - Branch-specific Claude AI instructions
- `.claude/` - Configuration and strategies
- `docs/` - Example documents and templates
- `scripts/` - Automation tools

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Ensure all quality checks pass
5. Submit a pull request to the appropriate branch

## 📄 License

[Specify your license here]

## 🔗 Resources

- [Claude AI Documentation](https://claude.ai/docs)
- [Technical Writing Best Practices](./docs/writing-standards.md)
- [MCP Integration Guide](./docs/mcp-integration.md)

## ⚠️ Important Notes

- Each branch is independently maintained
- Branches may have different configurations and tools
- Always review CLAUDE.md after switching branches
- Test configurations in a safe environment first

## 🏷️ Version History

- `python` - Python development with strict quality standards
- `java` - Java enterprise development with Spring Boot
- `writing-howto` - Instructional documentation framework
- `writing-technical` - Technical documentation with MCP integration
- More branches coming soon...

---

*For detailed usage of each configuration, switch to the respective branch and review its CLAUDE.md file.*