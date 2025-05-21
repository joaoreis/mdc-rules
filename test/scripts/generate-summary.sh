#!/bin/bash

# MDC Rules Test Summary Generator
# This script generates a summary of all test results

# Color codes for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Constants
RESULTS_BASELINE="../results/baseline"
RESULTS_WITH_RULES="../results/with-rules"
ANALYSIS_DIR="../results/analysis"
SUMMARY_FILE="../results/summary.md"

# Display help message
show_help() {
    echo -e "${BLUE}MDC Rules Test Summary Generator${NC}"
    echo "=============================="
    echo -e "Usage: $0 ${YELLOW}[options]${NC}"
    echo ""
    echo "Options:"
    echo -e "  ${YELLOW}--output${NC} FILE      Output file for summary (default: ../results/summary.md)"
    echo -e "  ${YELLOW}--help${NC}             Show this help message"
    echo ""
}

# Generate summary
generate_summary() {
    echo -e "${BLUE}Generating test summary...${NC}"
    
    # Create header of summary file
    cat > "$SUMMARY_FILE" << EOF
# MDC Rules Test Summary

**Generated:** $(date +"%Y-%m-%d %H:%M:%S")

This document summarizes the results of testing MDC rules.

## Overview

EOF
    
    # Count tests
    TOTAL_TESTS=$(find "$ANALYSIS_DIR" -name "*_analysis.md" | wc -l)
    TOTAL_RULES=$(find "$ANALYSIS_DIR" -name "*_analysis.md" | xargs -I{} basename {} _analysis.md | cut -d '_' -f 1 | sort | uniq | wc -l)
    
    echo -e "Total tests run: ${GREEN}$TOTAL_TESTS${NC}"
    echo -e "Unique rules tested: ${GREEN}$TOTAL_RULES${NC}"
    
    # Add counts to summary
    echo "- **Total tests conducted:** $TOTAL_TESTS" >> "$SUMMARY_FILE"
    echo "- **Unique rules tested:** $TOTAL_RULES" >> "$SUMMARY_FILE"
    echo "" >> "$SUMMARY_FILE"
    
    # Add table of tests
    echo "## Test Results Summary" >> "$SUMMARY_FILE"
    echo "" >> "$SUMMARY_FILE"
    echo "| Rule | Test File | Overall Improvement | Analysis |" >> "$SUMMARY_FILE"
    echo "|------|-----------|---------------------|----------|" >> "$SUMMARY_FILE"
    
    # Process each analysis file
    find "$ANALYSIS_DIR" -type f -name "*_analysis.md" | sort | while read -r analysis_file; do
        RULE_NAME=$(basename "$analysis_file" _analysis.md | cut -d '_' -f 1)
        TEST_FILE=$(basename "$analysis_file" _analysis.md | cut -d '_' -f 2-)
        CATEGORY=$(dirname "$analysis_file" | xargs basename)
        
        # Try to extract overall rating from analysis file
        OVERALL_IMPROVEMENT=$(grep -A 5 "Overall value" "$analysis_file" | grep -o '[0-5]' | tr '\n' ' ' | awk '{if ($2-$1 > 0) print "+"($2-$1); else print ($2-$1)}')
        
        # If extraction fails, mark as pending
        if [[ -z "$OVERALL_IMPROVEMENT" ]]; then
            OVERALL_IMPROVEMENT="Pending"
        fi
        
        # Add to summary
        echo "| $RULE_NAME | $TEST_FILE | $OVERALL_IMPROVEMENT | [View Analysis]($(echo "$analysis_file" | sed 's/^\.\.\///' )) |" >> "$SUMMARY_FILE"
    done
    
    # Add rule effectiveness section
    echo -e "\n## Rule Effectiveness Ranking\n" >> "$SUMMARY_FILE"
    echo "This ranking is based on the overall improvement observed in the tests:\n" >> "$SUMMARY_FILE"
    
    # Find all unique rules
    find "$ANALYSIS_DIR" -type f -name "*_analysis.md" | xargs -I{} basename {} _analysis.md | cut -d '_' -f 1 | sort | uniq > /tmp/unique_rules.txt
    
    # For each rule, calculate average improvement
    while read -r rule; do
        # Calculate average improvement for this rule
        AVG_IMPROVEMENT="Pending evaluation"
        
        # Add to summary
        echo "- **$rule**: $AVG_IMPROVEMENT" >> "$SUMMARY_FILE"
    done < /tmp/unique_rules.txt
    
    # Add conclusions section
    echo -e "\n## Conclusions and Recommendations\n" >> "$SUMMARY_FILE"
    echo "Based on the test results, the following conclusions and recommendations can be made:\n" >> "$SUMMARY_FILE"
    echo "1. *Add your conclusions here based on the test results*" >> "$SUMMARY_FILE"
    echo "2. *Recommend which rules are most effective*" >> "$SUMMARY_FILE"
    echo "3. *Suggest improvements to rules that need refinement*" >> "$SUMMARY_FILE"
    
    echo -e "${GREEN}Summary generated at: ${BLUE}$SUMMARY_FILE${NC}"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            show_help
            exit 0
            ;;
        --output)
            SUMMARY_FILE="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Create directory if it doesn't exist
mkdir -p "$(dirname "$SUMMARY_FILE")"

# Generate summary
generate_summary

echo -e "\n${GREEN}Summary generation completed successfully.${NC}"
exit 0