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

### `main` - Base Configuration
The foundation branch with core technical writing framework.
```bash
git checkout main
```
**Contains:**
- Core writing quality framework
- Basic document templates
- Essential writing tools and scripts
- MCP integration setup

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

### Other Branches (Coming Soon)
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
| Technical Documentation | `main` | Writing framework, quality checks |
| Python API/Backend | `python` | PEP 8, FastAPI patterns, testing |
| Full-Stack Application | `python` + cherry-pick | Combine configurations |
| New Framework | `main` as base | Fork and customize |

## 🔧 Customization

### Creating Your Own Configuration Branch
```bash
# Create new branch from main
git checkout main
git checkout -b my-custom-config

# Add your customizations
echo "## My Custom Standards" >> CLAUDE.md
git add CLAUDE.md
git commit -m "Add custom configuration"

# Push new branch
git push origin my-custom-config
```

### Merging Updates from Base
```bash
# Update your custom branch with latest base changes
git checkout my-custom-config
git merge main  # or specific branch
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
- Some branches may have breaking changes from main
- Always review CLAUDE.md after switching branches
- Test configurations in a safe environment first

## 🏷️ Version History

- `main` - Stable base configuration
- `python` - Added 2025-01-16 with Python standards
- More branches coming soon...

---

*For detailed usage of each configuration, switch to the respective branch and review its CLAUDE.md file.*