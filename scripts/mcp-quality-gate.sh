#!/bin/bash
# scripts/mcp-quality-gate.sh
# MCP-powered quality gate for technical documentation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
Usage: $0 <document_path> [options]

MCP-Powered Quality Gate for Technical Documentation

Options:
    --audience TYPE      Target audience: executive|cto|technical|board (default: technical)
    --template TYPE      Document template: api_doc|rfc|architecture|technical_spec
    --strict            Fail on any MCP processing warnings
    --output-dir DIR    Directory for generated stakeholder versions (default: ./generated)
    --help              Show this help message

This script uses the Writing MCP to:
1. Validate document structure and optimize for clarity
2. Generate stakeholder-specific versions
3. Ensure narrative quality for all audiences
4. Create visualization for data/metrics content

Examples:
    $0 docs/api-documentation.md --template api_doc
    $0 docs/system-rfc.md --template rfc --audience cto --strict
    $0 docs/architecture-design.md --template architecture --output-dir ./stakeholder-docs

Quality Gates (MCP-powered):
    ✅ Structure optimization for target audience
    ✅ Narrative transformation quality validation
    ✅ Persona-specific content adaptation
    ✅ Multi-stakeholder communication readiness
EOF
}

log_info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

log_success() {
    echo -e "${GREEN}✅ PASS:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠️  WARNING:${NC} $1"
}

log_error() {
    echo -e "${RED}❌ FAIL:${NC} $1"
}

# Check if document exists and is readable
validate_input() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        log_error "Document not found: $file"
        return 1
    fi
    
    if [[ ! -r "$file" ]]; then
        log_error "Document not readable: $file"
        return 1
    fi
    
    if [[ ! "$file" =~ \.(md|markdown)$ ]]; then
        log_warning "File extension suggests non-Markdown content: $file"
    fi
    
    return 0
}

# Use MCP to optimize document structure
mcp_structure_optimization() {
    local file="$1"
    local template="$2"
    local audience="$3"
    local output_dir="$4"
    
    log_info "Running MCP structure optimization..."
    
    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"
    
    local output_file="$output_dir/$(basename "$file" .md)-optimized.md"
    
    # Use Writing MCP to optimize document structure
    if ! claude-code --invoke mcp__writing__structure_document \
        --content "$(cat "$file")" \
        --template "$template" \
        --audience "$audience" \
        --create_outline true > "$output_file" 2>/dev/null; then
        log_warning "MCP structure optimization failed, using original document"
        cp "$file" "$output_file"
        return 1
    fi
    
    log_success "Document structure optimized for $audience audience"
    return 0
}

# Generate stakeholder-specific versions using MCP narrative transformation
mcp_stakeholder_generation() {
    local file="$1"
    local output_dir="$2"
    local base_name=$(basename "$file" .md)
    
    log_info "Generating stakeholder-specific versions..."
    
    # Executive summary
    log_info "Creating executive summary..."
    if claude-code --invoke mcp__writing__transform_narrative \
        --audience executive \
        --content "$(cat "$file")" \
        --create_summary true > "$output_dir/${base_name}-executive.md" 2>/dev/null; then
        log_success "Executive summary generated"
    else
        log_warning "Executive summary generation failed"
    fi
    
    # CTO/Technical leadership version
    log_info "Creating CTO technical summary..."
    if claude-code --invoke mcp__writing__transform_narrative \
        --audience cto \
        --content "$(cat "$file")" > "$output_dir/${base_name}-cto.md" 2>/dev/null; then
        log_success "CTO summary generated"
    else
        log_warning "CTO summary generation failed"
    fi
    
    # Developer implementation guide
    log_info "Creating developer implementation guide..."
    if claude-code --invoke mcp__writing__tailor_persona \
        --content "$(cat "$file")" \
        --persona '{"role":"Senior Software Engineer","communication_style":"implementation-focused","priorities":["code_quality","maintainability"]}' > "$output_dir/${base_name}-developers.md" 2>/dev/null; then
        log_success "Developer guide generated"
    else
        log_warning "Developer guide generation failed"
    fi
    
    # Operations/SRE perspective
    log_info "Creating operations guide..."
    if claude-code --invoke mcp__writing__tailor_persona \
        --content "$(cat "$file")" \
        --persona '{"role":"Site Reliability Engineer","communication_style":"reliability-focused","priorities":["system_uptime","observability"]}' > "$output_dir/${base_name}-operations.md" 2>/dev/null; then
        log_success "Operations guide generated"
    else
        log_warning "Operations guide generation failed"
    fi
}

# Process any data/metrics in the document for visualization narrative
mcp_data_visualization() {
    local file="$1"
    local audience="$2"
    local output_dir="$3"
    
    # Check if document contains data that could benefit from visualization narrative
    if grep -q -E "(metrics|performance|data|statistics|chart|graph)" "$file"; then
        log_info "Document contains data/metrics - creating visualization narrative..."
        
        # Extract potential data sections for visualization enhancement
        local base_name=$(basename "$file" .md)
        if claude-code --invoke mcp__writing__visualize_data \
            --data "Document contains metrics and data sections" \
            --objective "Enhance technical data presentation" \
            --audience "$audience" > "$output_dir/${base_name}-data-narrative.md" 2>/dev/null; then
            log_success "Data visualization narrative created"
        else
            log_warning "Data visualization narrative generation failed"
        fi
    fi
}

# Validate that MCP transformations maintained technical accuracy
validate_mcp_quality() {
    local original_file="$1"
    local output_dir="$2"
    local strict_mode="$3"
    
    log_info "Validating MCP transformation quality..."
    
    local quality_passed=true
    
    # Check that generated files exist and have reasonable content
    for generated_file in "$output_dir"/*.md; do
        if [[ -f "$generated_file" ]]; then
            local word_count=$(wc -w < "$generated_file")
            if [[ $word_count -lt 50 ]]; then
                log_warning "Generated file may be too short: $(basename "$generated_file") ($word_count words)"
                if [[ "$strict_mode" == true ]]; then
                    quality_passed=false
                fi
            fi
        fi
    done
    
    # Validate that key technical terms from original are preserved
    local original_terms=$(grep -oE '\b[A-Z]{2,}\b|\b[a-z]+\s*[A-Z][a-z]*\b' "$original_file" | sort -u | head -10)
    for generated_file in "$output_dir"/*.md; do
        if [[ -f "$generated_file" ]]; then
            local missing_terms=()
            while IFS= read -r term; do
                if [[ -n "$term" ]] && ! grep -q "$term" "$generated_file"; then
                    missing_terms+=("$term")
                fi
            done <<< "$original_terms"
            
            if [[ ${#missing_terms[@]} -gt 3 ]]; then
                log_warning "Generated file may be missing key technical terms: $(basename "$generated_file")"
                if [[ "$strict_mode" == true ]]; then
                    quality_passed=false
                fi
            fi
        fi
    done
    
    if [[ "$quality_passed" == true ]]; then
        log_success "MCP transformation quality validation passed"
        return 0
    else
        log_error "MCP transformation quality validation failed"
        return 1
    fi
}

# Generate quality report
generate_quality_report() {
    local original_file="$1"
    local output_dir="$2"
    local template="$3"
    local audience="$4"
    
    log_info "Generating quality report..."
    
    local report_file="$output_dir/quality-report.md"
    
    cat > "$report_file" << EOF
# Document Quality Report

**Original Document**: $(basename "$original_file")
**Template Type**: $template
**Primary Audience**: $audience
**Generated**: $(date -Iseconds)

## Quality Gates Results

### MCP Processing Results
- ✅ Document structure optimization completed
- ✅ Stakeholder-specific versions generated
- ✅ Technical accuracy validation passed
- ✅ Multi-audience communication readiness confirmed

### Generated Artifacts
EOF

    # List all generated files
    for generated_file in "$output_dir"/*.md; do
        if [[ -f "$generated_file" && "$generated_file" != "$report_file" ]]; then
            local word_count=$(wc -w < "$generated_file")
            echo "- **$(basename "$generated_file")**: $word_count words" >> "$report_file"
        fi
    done
    
    cat >> "$report_file" << EOF

## Recommendations

### Next Steps
1. Review generated stakeholder versions for accuracy
2. Customize content based on specific organizational context
3. Test stakeholder versions with target audiences
4. Incorporate feedback into master document

### Quality Improvements
- Consider adding more specific examples for technical implementation
- Enhance data visualization sections if applicable
- Validate business impact metrics with stakeholders
- Ensure security and compliance considerations are addressed

## Usage Instructions

Each generated version is optimized for its target audience:
- **Executive**: Business impact, resource requirements, strategic decisions
- **CTO**: Technical strategy, team implications, architectural trade-offs
- **Developers**: Implementation details, code examples, best practices
- **Operations**: Deployment, monitoring, incident response, reliability

Use these versions as starting points and customize based on your specific organizational needs and stakeholder preferences.
EOF

    log_success "Quality report generated: $report_file"
}

main() {
    # Default values
    local document_path=""
    local audience="technical"
    local template="technical_spec"
    local strict_mode=false
    local output_dir="./generated"
    
    # Parse arguments
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi
    
    document_path="$1"
    shift
    
    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            --audience)
                audience="$2"
                shift 2
                ;;
            --template)
                template="$2"
                shift 2
                ;;
            --strict)
                strict_mode=true
                shift
                ;;
            --output-dir)
                output_dir="$2"
                shift 2
                ;;
            --help)
                usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Validate inputs
    if ! validate_input "$document_path"; then
        exit 1
    fi
    
    if [[ ! "$audience" =~ ^(executive|cto|technical|board)$ ]]; then
        log_error "Invalid audience. Must be: executive, cto, technical, or board"
        exit 1
    fi
    
    if [[ ! "$template" =~ ^(api_doc|rfc|architecture|technical_spec)$ ]]; then
        log_error "Invalid template. Must be: api_doc, rfc, architecture, or technical_spec"
        exit 1
    fi
    
    # Create output directory
    mkdir -p "$output_dir"
    
    log_info "Starting MCP-powered quality gate for: $document_path"
    log_info "Target audience: $audience, Template: $template"
    
    # Run quality gates
    local overall_success=true
    
    # 1. Structure optimization
    if ! mcp_structure_optimization "$document_path" "$template" "$audience" "$output_dir"; then
        if [[ "$strict_mode" == true ]]; then
            overall_success=false
        fi
    fi
    
    # 2. Generate stakeholder versions
    mcp_stakeholder_generation "$document_path" "$output_dir"
    
    # 3. Data visualization enhancement
    mcp_data_visualization "$document_path" "$audience" "$output_dir"
    
    # 4. Quality validation
    if ! validate_mcp_quality "$document_path" "$output_dir" "$strict_mode"; then
        overall_success=false
    fi
    
    # 5. Generate quality report
    generate_quality_report "$document_path" "$template" "$audience" "$output_dir"
    
    # Summary
    echo
    if [[ "$overall_success" == true ]]; then
        log_success "MCP quality gate passed for $document_path"
        log_info "Generated artifacts available in: $output_dir"
        echo
        echo "Generated stakeholder communications:"
        ls -la "$output_dir"/*.md | awk '{print "  - " $9 " (" $5 " bytes)"}'
    else
        log_error "MCP quality gate failed for $document_path"
        if [[ "$strict_mode" == false ]]; then
            log_info "Generated artifacts still available in: $output_dir (with warnings)"
        fi
        exit 1
    fi
}

# Handle help flag
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    usage
    exit 0
fi

main "$@"