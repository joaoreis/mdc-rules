#!/bin/bash

# MDC Rules Simple Test Script
# A simplified script for testing individual MDC rules with Firebender

# Constants
FIREBENDER_JSON="../../firebender.json"
FIREBENDER_BACKUP="../../firebender.json.backup"
RESULTS_BASELINE="../results/baseline"
RESULTS_WITH_RULES="../results/with-rules"

# Color codes for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Display help message
show_help() {
    echo -e "${BLUE}MDC Rules Simple Test Script${NC}"
    echo "=============================="
    echo -e "Usage: $0 ${YELLOW}--rule${NC} RULE_PATH ${YELLOW}--case${NC} TEST_CASE_FILE"
    echo ""
    echo "Options:"
    echo -e "  ${YELLOW}--rule${NC} RULE_PATH    The rule to test (e.g., .firebender/mdc/core/code-guidelines.mdc)"
    echo -e "  ${YELLOW}--case${NC} TEST_FILE    The test file to use (e.g., ../cases/core/SampleClass.kt)"
    echo -e "  ${YELLOW}--prompt${NC} PROMPT     The prompt to use (default: varies by rule)"
    echo -e "  ${YELLOW}--help${NC}              Show this help message"
    echo ""
    echo "This script will:"
    echo "  1. Backup your current firebender.json"
    echo "  2. Test without the rule (baseline)"
    echo "  3. Test with the rule enabled"
    echo "  4. Save results for comparison"
    echo ""
}

# Validate parameters
validate_params() {
    if [[ -z "$RULE_PATH" ]]; then
        echo -e "${RED}Error: Rule path is required${NC}"
        show_help
        exit 1
    fi

    if [[ -z "$TEST_CASE" ]]; then
        echo -e "${RED}Error: Test case file is required${NC}"
        show_help
        exit 1
    fi

    # Extract rule name from path
    RULE_NAME=$(basename "$RULE_PATH" .mdc)
    
    # Extract category from path
    if [[ $RULE_PATH == *"/core/"* ]]; then
        CATEGORY="core"
    elif [[ $RULE_PATH == *"/android/"* ]]; then
        CATEGORY="android"
    elif [[ $RULE_PATH == *"/development/"* ]]; then
        CATEGORY="development"
    elif [[ $RULE_PATH == *"/build-tools/"* ]]; then
        CATEGORY="build-tools"
    elif [[ $RULE_PATH == *"/testing/"* ]]; then
        CATEGORY="testing"
    elif [[ $RULE_PATH == *"/documentation/"* ]]; then
        CATEGORY="documentation"
    elif [[ $RULE_PATH == *"/monitoring/"* ]]; then
        CATEGORY="monitoring"
    else
        CATEGORY="other"
    fi
    
    # If prompt is not provided, get default prompt from the prompts file
    if [[ -z "$PROMPT" ]]; then
        if [[ -f "../prompts/${CATEGORY}-prompts.md" ]]; then
            # Try to extract default prompt for this rule from prompts file
            DEFAULT_PROMPT=$(grep -A 2 "## $RULE_NAME" "../prompts/${CATEGORY}-prompts.md" | grep "Default Prompt:" | cut -d '"' -f 2)
            if [[ -n "$DEFAULT_PROMPT" ]]; then
                PROMPT="$DEFAULT_PROMPT"
            else
                PROMPT="Review this code and suggest improvements"
            fi
        else
            PROMPT="Review this code and suggest improvements"
        fi
    fi
}

# Backup firebender.json
backup_config() {
    echo -e "${BLUE}Creating backup of firebender.json...${NC}"
    cp "$FIREBENDER_JSON" "$FIREBENDER_BACKUP"
    echo -e "${GREEN}Backup created as firebender.json.backup${NC}"
}

# Restore firebender.json from backup
restore_config() {
    if [[ -f "$FIREBENDER_BACKUP" ]]; then
        echo -e "${BLUE}Restoring firebender.json from backup...${NC}"
        cp "$FIREBENDER_BACKUP" "$FIREBENDER_JSON"
        echo -e "${GREEN}Restore completed.${NC}"
    else
        echo -e "${RED}Error: No backup file found.${NC}"
    fi
}

# Disable all rules in firebender.json
disable_all_rules() {
    echo -e "${BLUE}Disabling all rules in firebender.json...${NC}"
    # Get content and replace rules array with empty array
    jq '.rules = []' "$FIREBENDER_JSON" > "${FIREBENDER_JSON}.tmp" && mv "${FIREBENDER_JSON}.tmp" "$FIREBENDER_JSON"
    echo -e "${GREEN}All rules disabled.${NC}"
}

# Enable specific rule in firebender.json
enable_rule() {
    echo -e "${BLUE}Enabling rule $RULE_PATH...${NC}"
    # Add rule to the rules array
    jq --arg rule "$RULE_PATH" '.rules += [$rule]' "$FIREBENDER_JSON" > "${FIREBENDER_JSON}.tmp" && mv "${FIREBENDER_JSON}.tmp" "$FIREBENDER_JSON"
    echo -e "${GREEN}Rule enabled.${NC}"
}

# Run baseline test (no rules)
run_baseline_test() {
    echo -e "\n${YELLOW}========== BASELINE TEST (NO RULES) ==========${NC}"
    echo -e "${BLUE}Test Case:${NC} $TEST_CASE"
    echo -e "${BLUE}Prompt:${NC} \"$PROMPT\""
    
    # Disable all rules
    disable_all_rules
    
    # Prepare results directory
    mkdir -p "$RESULTS_BASELINE/$CATEGORY"
    BASELINE_RESULT_FILE="$RESULTS_BASELINE/$CATEGORY/${RULE_NAME}_$(basename "$TEST_CASE").md"
    
    echo -e "${YELLOW}INSTRUCTIONS:${NC}"
    echo -e "1. Open Firebender and start a ${GREEN}NEW CONVERSATION${NC}"
    echo -e "2. Verify in the \"Rules Used\" section that ${RED}NO RULES${NC} are listed"
    echo -e "3. Share the test file: ${BLUE}$TEST_CASE${NC}"
    echo -e "4. Ask the following prompt:"
    echo -e "\n    ${GREEN}\"$PROMPT\"${NC}\n"
    echo -e "5. Wait for the response and save it to:"
    echo -e "   ${BLUE}$BASELINE_RESULT_FILE${NC}"
    echo -e "6. Press Enter when done to continue to the next test..."
    
    # Create template for the results file
    cat > "$BASELINE_RESULT_FILE" << EOF
# Baseline Test: $RULE_NAME - $(basename "$TEST_CASE")

**Test Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Rule Tested:** None (baseline)
**Test File:** $(basename "$TEST_CASE")
**Prompt Used:** "$PROMPT"

## Response from AI (without rule)

<!-- Copy the AI response here -->

EOF
    
    # Wait for user to press enter
    read -p ""
}

# Run test with rule enabled
run_rule_test() {
    echo -e "\n${YELLOW}========== TEST WITH RULE ENABLED ==========${NC}"
    echo -e "${BLUE}Rule:${NC} $RULE_PATH"
    echo -e "${BLUE}Test Case:${NC} $TEST_CASE"
    echo -e "${BLUE}Prompt:${NC} \"$PROMPT\""
    
    # Enable the rule
    disable_all_rules
    enable_rule
    
    # Prepare results directory
    mkdir -p "$RESULTS_WITH_RULES/$CATEGORY"
    RULE_RESULT_FILE="$RESULTS_WITH_RULES/$CATEGORY/${RULE_NAME}_$(basename "$TEST_CASE").md"
    
    echo -e "${YELLOW}INSTRUCTIONS:${NC}"
    echo -e "1. Open Firebender and start a ${GREEN}NEW CONVERSATION${NC}"
    echo -e "2. Verify in the \"Rules Used\" section that ${GREEN}$RULE_PATH${NC} is listed"
    echo -e "3. Share the test file: ${BLUE}$TEST_CASE${NC}"
    echo -e "4. Ask the following prompt:"
    echo -e "\n    ${GREEN}\"$PROMPT\"${NC}\n"
    echo -e "5. Wait for the response and save it to:"
    echo -e "   ${BLUE}$RULE_RESULT_FILE${NC}"
    echo -e "6. Press Enter when done to complete testing..."
    
    # Create template for the results file
    cat > "$RULE_RESULT_FILE" << EOF
# Rule Test: $RULE_NAME - $(basename "$TEST_CASE")

**Test Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Rule Tested:** $RULE_PATH
**Test File:** $(basename "$TEST_CASE")
**Prompt Used:** "$PROMPT"

## Response from AI (with rule)

<!-- Copy the AI response here -->

EOF
    
    # Wait for user to press enter
    read -p ""
}

# Show next steps
show_next_steps() {
    echo -e "\n${YELLOW}========== TEST COMPLETED ==========${NC}"
    echo -e "Baseline result saved to: ${BLUE}$BASELINE_RESULT_FILE${NC}"
    echo -e "Rule-enabled result saved to: ${BLUE}$RULE_RESULT_FILE${NC}"
    echo -e "\n${YELLOW}Next steps:${NC}"
    echo -e "1. Open both files and paste the AI responses"
    echo -e "2. Compare the results to see the impact of the rule"
    echo -e "3. Create an analysis file in ../results/analysis/$CATEGORY/${RULE_NAME}_$(basename "$TEST_CASE")_analysis.md"
    
    # Create analysis directory and template file
    mkdir -p "../results/analysis/$CATEGORY"
    ANALYSIS_FILE="../results/analysis/$CATEGORY/${RULE_NAME}_$(basename "$TEST_CASE")_analysis.md"
    
    cat > "$ANALYSIS_FILE" << EOF
# Analysis: $RULE_NAME - $(basename "$TEST_CASE")

**Rule:** $RULE_PATH
**Test File:** $(basename "$TEST_CASE")
**Prompt:** "$PROMPT"
**Analysis Date:** $(date +"%Y-%m-%d %H:%M:%S")

## Summary of Differences

<!-- Summarize key differences between baseline and rule-enabled responses -->

## Quality Assessment

| Aspect | Baseline Rating (1-5) | Rule-Enabled Rating (1-5) | Improvement |
|--------|----------------------|---------------------------|------------|
| Code correctness |  |  |  |
| Best practices |  |  |  |
| Clarity of explanations |  |  |  |
| Completeness |  |  |  |
| Overall value |  |  |  |

## Key Observations

<!-- Note any significant improvements or issues with the rule -->

## Recommendations

<!-- Suggest any improvements to the rule -->

EOF
    
    echo -e "\nAnalysis template created at: ${BLUE}$ANALYSIS_FILE${NC}"
}

# Set defaults
RULE_PATH=""
TEST_CASE=""
PROMPT=""

# Process command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            show_help
            exit 0
            ;;
        --rule)
            RULE_PATH="$2"
            shift 2
            ;;
        --case)
            TEST_CASE="$2"
            shift 2
            ;;
        --prompt)
            PROMPT="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Main execution
if [[ "$RULE_PATH" == "" || "$TEST_CASE" == "" ]]; then
    show_help
    exit 1
fi

# Validate parameters
validate_params

# Create results directory structure
mkdir -p "../results/analysis/$CATEGORY"

# Backup configuration
backup_config

# Run tests
run_baseline_test
run_rule_test

# Show next steps
show_next_steps

# Restore original configuration
restore_config

echo -e "\n${GREEN}Testing completed successfully.${NC}"
exit 0