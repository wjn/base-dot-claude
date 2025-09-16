# Base .claude Configuration Repository

A comprehensive technical writing framework with multiple specialized configurations available through different branches. Each branch provides a tailored setup for specific use cases and industries.

## 🚀 Quick Start

### Clone the Repository
```bash
# Clone with all branches
git clone https://github.com/[username]/base-dot-claude.git
cd base-dot-claude

# View all available branches
git branch -a
```

### Using Different Configurations

Each branch contains a specialized `.claude` configuration and associated tools:

```bash
# Switch to a specific configuration
git checkout [branch-name]

# Pull latest updates for current branch
git pull origin [branch-name]

# List all remote branches
git ls-remote --heads origin
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

### 1. Starting a New Project
```bash
# Clone and select appropriate branch
git clone https://github.com/[username]/base-dot-claude.git my-project
cd my-project
git checkout python  # or your preferred configuration

# Remove git history to start fresh
rm -rf .git
git init
git add .
git commit -m "Initial project setup from base-dot-claude"
```

### 2. Updating Existing Project
```bash
# Add as upstream to existing project
cd your-existing-project
git remote add claude-base https://github.com/[username]/base-dot-claude.git
git fetch claude-base

# Merge specific branch configuration
git merge claude-base/python --allow-unrelated-histories
```

### 3. Cherry-Pick Specific Features
```bash
# Fetch all branches
git fetch --all

# View files in a branch without switching
git show python:CLAUDE.md

# Copy specific file from another branch
git checkout python -- CLAUDE.md
git checkout main -- .claude/strategies/workstream-eod-instructions.md
```

### 4. Comparing Configurations
```bash
# Compare CLAUDE.md between branches
git diff main..python -- CLAUDE.md

# See what's unique in each branch
git log main..python --oneline
git log python..main --oneline
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
# Create new branch from an existing one (e.g., python)
git checkout python  # or any other base branch
git checkout -b my-custom-config

# Add your customizations
echo "## My Custom Standards" >> CLAUDE.md
git add CLAUDE.md
git commit -m "Add custom configuration"

# Push new branch
git push origin my-custom-config
```

### Merging Updates from Another Branch
```bash
# Update your custom branch with changes from another branch
git checkout my-custom-config
git merge python  # or any other branch
# Resolve any conflicts
git commit
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