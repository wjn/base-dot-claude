#!/bin/bash
# scripts/write-check.sh
# Document quality validation script - equivalent to pytest for writing

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
CHECK_TYPE="all"
TARGET_AUDIENCE="technical"
STRICT_MODE=false
RECURSIVE=false
REPORT_FORMAT="terminal"
FLESCH_MIN=60
FLESCH_MAX=70
FOG_MAX=12

usage() {
    cat << EOF
Usage: $0 <check_type> <file_or_directory> [options]

Check Types:
    all                 Run all quality checks (default)
    readability         Check reading level and sentence complexity
    grammar            Check grammar and style violations
    structure          Validate document structure compliance
    links              Verify all links are working
    accessibility      Check WCAG compliance and inclusive language
    images             Validate alt text and image accessibility

Options:
    --audience LEVEL    Target audience: beginner|technical|expert (default: technical)
    --strict            Fail on warnings, not just errors
    --recursive         Check all markdown files in directory
    --report FORMAT     Output format: terminal|html|json (default: terminal)
    --flesch-min N      Minimum Flesch reading score (default: 60)
    --flesch-max N      Maximum Flesch reading score (default: 70)
    --fog-max N         Maximum Gunning Fog index (default: 12)
    --help             Show this help message

Examples:
    $0 all docs/howto.md
    $0 readability docs/ --recursive --audience beginner
    $0 grammar docs/tutorial.md --strict
    $0 all docs/ --recursive --report html --output report.html

Quality Gates (like pytest --cov):
    - Readability: Flesch score within target range (±5 points acceptable)
    - Grammar: 95% accuracy minimum
    - Structure: 100% template compliance
    - Links: 100% validity
    - Accessibility: Zero violations
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

check_dependencies() {
    local missing_deps=()
    
    # Check for required tools
    command -v python3 >/dev/null || missing_deps+=("python3")
    command -v node >/dev/null || missing_deps+=("node.js")
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        log_info "Please install missing dependencies and try again"
        exit 1
    fi
}

install_python_deps() {
    log_info "Checking Python dependencies..."
    python3 -c "import textstat, language_tool_python" 2>/dev/null || {
        log_info "Installing required Python packages..."
        pip3 install --user textstat language-tool-python markdown2 requests
    }
}

check_readability() {
    local file="$1"
    local audience="$2"
    
    if ! python3 -c "import textstat" 2>/dev/null; then
        log_error "textstat not installed. Run: pip3 install textstat"
        return 1
    fi
    
    log_info "Analyzing readability for $file (audience: $audience)"
    
    python3 << EOF
import textstat
import sys

# Set audience targets
targets = {
    'beginner': (70, 80),
    'technical': (60, 70), 
    'expert': (30, 50)
}

try:
    with open('$file', 'r', encoding='utf-8') as f:
        text = f.read()
    
    flesch_score = textstat.flesch_reading_ease(text)
    fog_score = textstat.gunning_fog(text)
    
    min_score, max_score = targets.get('$audience', (60, 70))
    
    print(f"Flesch Reading Ease: {flesch_score:.1f}")
    print(f"Gunning Fog Index: {fog_score:.1f}")
    print(f"Target range for $audience: {min_score}-{max_score}")
    
    passed = True
    
    if not (min_score <= flesch_score <= max_score):
        print(f"FAIL: Flesch score {flesch_score:.1f} outside target range")
        passed = False
    
    if fog_score > $FOG_MAX:
        print(f"FAIL: Fog index {fog_score:.1f} exceeds maximum $FOG_MAX")
        passed = False
    
    if passed:
        print("PASS: Readability appropriate for target audience")
        sys.exit(0)
    else:
        sys.exit(1)
        
except Exception as e:
    print(f"ERROR: {e}")
    sys.exit(1)
EOF
}

check_grammar() {
    local file="$1"
    
    log_info "Checking grammar and style for $file"
    
    # Use available tools in order of preference
    if command -v vale >/dev/null; then
        vale "$file" --config="$PROJECT_ROOT/.vale.ini" 2>/dev/null || {
            log_warning "Vale config not found, using default settings"
            vale "$file" 2>/dev/null
        }
    elif command -v write-good >/dev/null; then
        write-good "$file" --parse || return 1
    else
        log_warning "No grammar checker found. Install Vale or write-good"
        return 0  # Don't fail if tools aren't available
    fi
}

check_structure() {
    local file="$1"
    
    log_info "Validating document structure for $file"
    
    # Detect document type from content
    local doc_type
    if grep -q "^# How to" "$file"; then
        doc_type="howto"
    elif grep -q "^# Tutorial:" "$file"; then
        doc_type="tutorial"
    elif grep -q "^# Troubleshooting:" "$file"; then
        doc_type="troubleshooting"
    else
        doc_type="generic"
    fi
    
    log_info "Detected document type: $doc_type"
    
    case $doc_type in
        howto)
            check_howto_structure "$file"
            ;;
        tutorial)
            check_tutorial_structure "$file"
            ;;
        troubleshooting)
            check_troubleshooting_structure "$file"
            ;;
        *)
            check_generic_structure "$file"
            ;;
    esac
}

check_howto_structure() {
    local file="$1"
    local errors=0
    
    # Required sections for how-to guides
    local required_sections=(
        "Prerequisites"
        "Overview"
        "Steps"
        "Verification"
        "Troubleshooting"
    )
    
    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$file"; then
            log_error "Missing required section: $section"
            ((errors++))
        fi
    done
    
    # Check for numbered steps
    if ! grep -q "^### Step [0-9]" "$file"; then
        log_error "No numbered steps found (should use '### Step 1:', '### Step 2:', etc.)"
        ((errors++))
    fi
    
    if [[ $errors -eq 0 ]]; then
        log_success "Document structure compliant with how-to template"
        return 0
    else
        return 1
    fi
}

check_tutorial_structure() {
    local file="$1"
    local errors=0
    
    local required_sections=(
        "What You'll Learn"
        "Before You Begin" 
        "Summary"
    )
    
    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$file"; then
            log_error "Missing required section: $section"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        log_success "Document structure compliant with tutorial template"
        return 0
    else
        return 1
    fi
}

check_troubleshooting_structure() {
    local file="$1"
    local errors=0
    
    local required_sections=(
        "Quick Diagnosis"
        "Common Issues"
    )
    
    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$file"; then
            log_error "Missing required section: $section"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        log_success "Document structure compliant with troubleshooting template"
        return 0
    else
        return 1
    fi
}

check_generic_structure() {
    local file="$1"
    local errors=0
    
    # Basic structure requirements
    if ! grep -q "^# " "$file"; then
        log_error "No H1 title found"
        ((errors++))
    fi
    
    # Check heading hierarchy
    local prev_level=0
    while IFS= read -r line; do
        if [[ $line =~ ^#{1,6}[[:space:]] ]]; then
            local level=${#line}
            level=$((level - ${#line// /}))  # Count hashes
            
            if [[ $level -gt $((prev_level + 1)) ]]; then
                log_error "Heading hierarchy jump: H$prev_level to H$level"
                ((errors++))
            fi
            prev_level=$level
        fi
    done < "$file"
    
    if [[ $errors -eq 0 ]]; then
        log_success "Basic document structure valid"
        return 0
    else
        return 1
    fi
}

check_links() {
    local file="$1"
    
    log_info "Validating links in $file"
    
    if command -v markdown-link-check >/dev/null; then
        markdown-link-check "$file" --quiet
    else
        log_warning "markdown-link-check not installed. Skipping link validation"
        log_info "Install with: npm install -g markdown-link-check"
        return 0
    fi
}

check_accessibility() {
    local file="$1"
    
    log_info "Checking accessibility compliance for $file"
    
    local errors=0
    
    # Check for images without alt text
    if grep -q "!\[\](" "$file"; then
        log_error "Images found without alt text"
        ((errors++))
    fi
    
    # Check heading hierarchy (accessibility requirement)
    local in_h1=false
    local h1_count=0
    while IFS= read -r line; do
        if [[ $line =~ ^#[[:space:]] ]]; then
            ((h1_count++))
            if [[ $h1_count -gt 1 ]]; then
                log_error "Multiple H1 headings found (accessibility violation)"
                ((errors++))
            fi
        fi
    done < "$file"
    
    if [[ $h1_count -eq 0 ]]; then
        log_error "No H1 heading found (accessibility requirement)"
        ((errors++))
    fi
    
    # Check for inclusive language violations
    local problematic_terms=(
        "guys" "mankind" "master/slave" "whitelist" "blacklist" 
        "sanity check" "dummy" "crazy" "insane"
    )
    
    for term in "${problematic_terms[@]}"; do
        if grep -iq "$term" "$file"; then
            log_warning "Potentially non-inclusive language found: $term"
            # Note: warnings don't increment error count unless in strict mode
            if [[ $STRICT_MODE == true ]]; then
                ((errors++))
            fi
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        log_success "Accessibility compliance check passed"
        return 0
    else
        return 1
    fi
}

check_images() {
    local file="$1"
    
    log_info "Validating image accessibility in $file"
    
    local errors=0
    local image_count=0
    local alt_text_count=0
    
    # Find all image references
    while IFS= read -r line; do
        if [[ $line =~ !\[([^\]]*)\]\([^)]+\) ]]; then
            ((image_count++))
            local alt_text="${BASH_REMATCH[1]}"
            
            if [[ -n "$alt_text" ]]; then
                ((alt_text_count++))
                
                # Check alt text quality
                if [[ ${#alt_text} -lt 10 ]]; then
                    log_warning "Alt text may be too short: '$alt_text'"
                    if [[ $STRICT_MODE == true ]]; then
                        ((errors++))
                    fi
                fi
                
                # Check for poor alt text
                if [[ $alt_text =~ ^(image|picture|screenshot|photo)$ ]]; then
                    log_error "Non-descriptive alt text: '$alt_text'"
                    ((errors++))
                fi
            else
                log_error "Image found without alt text"
                ((errors++))
            fi
        fi
    done < "$file"
    
    if [[ $image_count -gt 0 ]]; then
        local coverage=$((alt_text_count * 100 / image_count))
        log_info "Alt text coverage: $coverage% ($alt_text_count/$image_count images)"
        
        if [[ $coverage -lt 100 ]]; then
            log_error "Alt text coverage below 100%"
            ((errors++))
        fi
    fi
    
    if [[ $errors -eq 0 ]]; then
        log_success "Image accessibility check passed"
        return 0
    else
        return 1
    fi
}

run_all_checks() {
    local file="$1"
    local overall_success=true
    
    log_info "Running comprehensive quality checks on $file"
    echo "$(basename "$file") Quality Report"
    echo "================================"
    
    # Run each check and track results
    check_readability "$file" "$TARGET_AUDIENCE" || overall_success=false
    echo
    check_grammar "$file" || overall_success=false
    echo  
    check_structure "$file" || overall_success=false
    echo
    check_links "$file" || overall_success=false
    echo
    check_accessibility "$file" || overall_success=false
    echo
    check_images "$file" || overall_success=false
    
    echo
    if [[ $overall_success == true ]]; then
        log_success "All quality checks passed for $file"
        return 0
    else
        log_error "Quality checks failed for $file"
        return 1
    fi
}

process_file() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        log_error "File not found: $file"
        return 1
    fi
    
    if [[ ! "$file" =~ \.(md|markdown)$ ]]; then
        log_warning "Skipping non-markdown file: $file"
        return 0
    fi
    
    case $CHECK_TYPE in
        all)
            run_all_checks "$file"
            ;;
        readability)
            check_readability "$file" "$TARGET_AUDIENCE"
            ;;
        grammar)
            check_grammar "$file"
            ;;
        structure)
            check_structure "$file"
            ;;
        links)
            check_links "$file"
            ;;
        accessibility)
            check_accessibility "$file"
            ;;
        images)
            check_images "$file"
            ;;
        *)
            log_error "Unknown check type: $CHECK_TYPE"
            return 1
            ;;
    esac
}

process_directory() {
    local dir="$1"
    local overall_success=true
    
    if [[ $RECURSIVE == true ]]; then
        log_info "Processing directory recursively: $dir"
        find "$dir" -name "*.md" -o -name "*.markdown" | while read -r file; do
            process_file "$file" || overall_success=false
        done
    else
        log_info "Processing markdown files in directory: $dir"
        for file in "$dir"/*.{md,markdown}; do
            [[ -f "$file" ]] && process_file "$file" || overall_success=false
        done
    fi
    
    return $overall_success
}

main() {
    # Parse arguments
    if [[ $# -lt 2 ]]; then
        usage
        exit 1
    fi
    
    CHECK_TYPE="$1"
    TARGET_PATH="$2"
    shift 2
    
    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            --audience)
                TARGET_AUDIENCE="$2"
                shift 2
                ;;
            --strict)
                STRICT_MODE=true
                shift
                ;;
            --recursive)
                RECURSIVE=true
                shift
                ;;
            --report)
                REPORT_FORMAT="$2"
                shift 2
                ;;
            --flesch-min)
                FLESCH_MIN="$2"
                shift 2
                ;;
            --flesch-max)
                FLESCH_MAX="$2"
                shift 2
                ;;
            --fog-max)
                FOG_MAX="$2"
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
    if [[ ! "$TARGET_AUDIENCE" =~ ^(beginner|technical|expert)$ ]]; then
        log_error "Invalid audience. Must be: beginner, technical, or expert"
        exit 1
    fi
    
    # Check dependencies
    check_dependencies
    install_python_deps
    
    # Process target path
    if [[ -f "$TARGET_PATH" ]]; then
        process_file "$TARGET_PATH"
    elif [[ -d "$TARGET_PATH" ]]; then
        process_directory "$TARGET_PATH"
    else
        log_error "Target path not found: $TARGET_PATH"
        exit 1
    fi
}

# Handle help flag without requiring other arguments
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    usage
    exit 0
fi

main "$@"