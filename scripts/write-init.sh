#!/bin/bash
# scripts/write-init.sh
# Initialize new documents from templates

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES_DIR="$PROJECT_ROOT/templates"
DOCS_DIR="$PROJECT_ROOT/docs"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

usage() {
    cat << EOF
Usage: $0 <template_type> <title> [options]

Template Types:
    howto          Step-by-step instructional guide
    tutorial       Learning-oriented educational content  
    troubleshooting Problem-solving documentation
    reference      Technical specifications and APIs
    quickstart     Getting started guide
    faq            Frequently asked questions

Options:
    --output FILE    Output file path (default: auto-generated)
    --audience TYPE  Target audience: beginner|technical|expert (default: technical)
    --time MINUTES   Estimated completion time (default: 15)
    --open          Open the file in default editor after creation
    --help          Show this help message

Examples:
    $0 howto "Install Docker Desktop"
    $0 tutorial "Building Your First API" --audience beginner --time 30
    $0 troubleshooting "Network Connection Issues" --output docs/net-troubleshooting.md

This will create a new document with the proper structure and placeholders
that you can fill in with your specific content.
EOF
}

log_info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

log_success() {
    echo -e "${GREEN}✅${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

log_error() {
    echo -e "${RED}❌${NC} $1"
}

# Generate filename from title
generate_filename() {
    local title="$1"
    local template_type="$2"
    
    # Convert title to lowercase, replace spaces with hyphens, remove special chars
    local filename=$(echo "$title" | \
        tr '[:upper:]' '[:lower:]' | \
        sed 's/[[:space:]]\+/-/g' | \
        sed 's/[^a-z0-9-]//g' | \
        sed 's/--*/-/g' | \
        sed 's/^-\|-$//g')
    
    echo "${template_type}-${filename}.md"
}

# Create docs directory if it doesn't exist
ensure_docs_dir() {
    if [[ ! -d "$DOCS_DIR" ]]; then
        log_info "Creating docs directory: $DOCS_DIR"
        mkdir -p "$DOCS_DIR"
    fi
}

# Process template with substitutions
process_template() {
    local template_file="$1"
    local output_file="$2"
    local title="$3"
    local audience="$4"
    local time_estimate="$5"
    
    local current_date=$(date +"%Y-%m-%d")
    local current_user=$(whoami)
    
    # Read template and make substitutions
    local processed_content
    processed_content=$(cat "$template_file")
    
    # Title substitutions
    processed_content="${processed_content//\[Achieve Specific Goal\]/$title}"
    processed_content="${processed_content//\[Learning Objective\]/$title}"
    processed_content="${processed_content//\[Problem Area\]/$title}"
    processed_content="${processed_content//\[API\/Tool\/Feature\]/$title}"
    
    # Audience and time substitutions
    processed_content="${processed_content//\[Beginner\/Intermediate\/Advanced\]/$audience}"
    processed_content="${processed_content//\[X minutes\]/$time_estimate minutes}"
    
    # Date substitutions
    processed_content="${processed_content//\[Date\]/$current_date}"
    
    # Write processed content to output file
    echo "$processed_content" > "$output_file"
}

# Validate template exists
validate_template() {
    local template_type="$1"
    local template_file="$TEMPLATES_DIR/${template_type}.md.template"
    
    if [[ ! -f "$template_file" ]]; then
        log_error "Template not found: $template_file"
        log_info "Available templates:"
        ls "$TEMPLATES_DIR"/*.template 2>/dev/null | sed 's/.*\//  - /' | sed 's/\.md\.template$//' || {
            log_warning "No templates found in $TEMPLATES_DIR"
        }
        return 1
    fi
    
    echo "$template_file"
}

# Main document creation
create_document() {
    local template_type="$1"
    local title="$2"
    local output_file="$3"
    local audience="$4"
    local time_estimate="$5"
    local open_after="$6"
    
    # Validate template
    local template_file
    template_file=$(validate_template "$template_type") || return 1
    
    # Ensure output directory exists
    local output_dir=$(dirname "$output_file")
    if [[ ! -d "$output_dir" ]]; then
        log_info "Creating directory: $output_dir"
        mkdir -p "$output_dir"
    fi
    
    # Check if file already exists
    if [[ -f "$output_file" ]]; then
        log_warning "File already exists: $output_file"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Cancelled by user"
            return 1
        fi
    fi
    
    # Process template and create file
    log_info "Creating $template_type document: $title"
    process_template "$template_file" "$output_file" "$title" "$audience" "$time_estimate"
    
    # Success feedback
    log_success "Document created: $output_file"
    log_info "Template: $template_type"
    log_info "Audience: $audience"
    log_info "Estimated time: $time_estimate minutes"
    
    # Run initial quality check
    if [[ -x "$SCRIPT_DIR/write-check.sh" ]]; then
        log_info "Running initial structure validation..."
        if "$SCRIPT_DIR/write-check.sh" structure "$output_file"; then
            log_success "Template structure valid"
        else
            log_warning "Template structure needs attention"
        fi
    fi
    
    # Open file if requested
    if [[ "$open_after" == true ]]; then
        if command -v code >/dev/null; then
            log_info "Opening in VS Code..."
            code "$output_file"
        elif command -v vim >/dev/null; then
            log_info "Opening in Vim..."
            vim "$output_file"
        elif command -v nano >/dev/null; then
            log_info "Opening in Nano..."
            nano "$output_file"
        else
            log_warning "No suitable editor found to open file"
        fi
    fi
    
    # Provide next steps
    cat << EOF

Next steps:
1. Fill in the template placeholders with your content
2. Replace [bracketed items] with specific information
3. Add your actual steps, examples, and screenshots
4. Run quality checks: $SCRIPT_DIR/write-check.sh all "$output_file"
5. Review against audience guidelines in .claude/strategies/
EOF
}

main() {
    # Check for help flag
    if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]] || [[ $# -eq 0 ]]; then
        usage
        exit 0
    fi
    
    # Minimum required arguments
    if [[ $# -lt 2 ]]; then
        log_error "Missing required arguments"
        usage
        exit 1
    fi
    
    local template_type="$1"
    local title="$2"
    shift 2
    
    # Default values
    local output_file=""
    local audience="technical"
    local time_estimate="15"
    local open_after=false
    
    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            --output)
                output_file="$2"
                shift 2
                ;;
            --audience)
                audience="$2"
                shift 2
                ;;
            --time)
                time_estimate="$2"
                shift 2
                ;;
            --open)
                open_after=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Generate output filename if not provided
    if [[ -z "$output_file" ]]; then
        ensure_docs_dir
        local filename
        filename=$(generate_filename "$title" "$template_type")
        output_file="$DOCS_DIR/$filename"
    fi
    
    # Validate audience
    if [[ ! "$audience" =~ ^(beginner|technical|expert)$ ]]; then
        log_error "Invalid audience. Must be: beginner, technical, or expert"
        exit 1
    fi
    
    # Validate time estimate
    if ! [[ "$time_estimate" =~ ^[0-9]+$ ]]; then
        log_error "Time estimate must be a number (minutes)"
        exit 1
    fi
    
    # Create the document
    create_document "$template_type" "$title" "$output_file" "$audience" "$time_estimate" "$open_after"
}

main "$@"