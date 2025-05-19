#!/bin/bash

# MDC Rules Test Workflow Script
# This script guides through the entire testing process for an MDC rule

# Display help message
show_help() {
    echo "MDC Rules Test Workflow Helper"
    echo "=============================="
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --rule RULE_PATH    The rule to test (e.g., .firebender/mdc/core/code-guidelines.mdc)"
    echo "  --test-file FILE    The test file to use (e.g., test-files/kotlin/SampleClass.kt)"
    echo "  --query \"QUERY\"     The query to run (e.g., \"Review this code and suggest improvements\")"
    echo "  --output-dir DIR    Output directory for test results (default: test-results/CATEGORY)"
    echo "  --help              Show this help message"
    echo ""
    echo "This script will:"
    echo "  1. Backup your current firebender.json"
    echo "  2. Guide you through baseline testing (rule disabled)"
    echo "  3. Guide you through rule-enabled testing"
    echo "  4. Create template files for comparison analysis"
    echo ""
    echo "You will need to start new Firebender conversations during the process."
    echo ""
}

# Default values
RULE_PATH=""
TEST_FILE=""
QUERY=""
OUTPUT_DIR=""
RULE_NAME=""
RULE_CATEGORY=""

# Check if no arguments provided
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

# Process command line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --help)
            show_help
            exit 0
            ;;
        --rule)
            if [ -z "$2" ]; then
                echo "Error: Rule path not provided."
                exit 1
            fi
            RULE_PATH="$2"
            # Extract rule name from path
            RULE_NAME=$(basename "$RULE_PATH" .mdc)
            # Extract category from path
            RULE_CATEGORY=$(echo "$RULE_PATH" | grep -o "mdc/[^/]*/[^/]*" | cut -d'/' -f2)
            shift 2
            ;;
        --test-file)
            if [ -z "$2" ]; then
                echo "Error: Test file not provided."
                exit 1
            fi
            TEST_FILE="$2"
            shift 2
            ;;
        --query)
            if [ -z "$2" ]; then
                echo "Error: Query not provided."
                exit 1
            fi
            QUERY="$2"
            shift 2
            ;;
        --output-dir)
            if [ -z "$2" ]; then
                echo "Error: Output directory not provided."
                exit 1
            fi
            OUTPUT_DIR="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate required arguments
if [ -z "$RULE_PATH" ]; then
    echo "Error: Rule path is required."
    exit 1
fi

if [ -z "$TEST_FILE" ]; then
    echo "Error: Test file is required."
    exit 1
fi

if [ -z "$QUERY" ]; then
    echo "Error: Query is required."
    exit 1
fi

if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR="test-results/$RULE_CATEGORY"
    echo "Output directory not specified, using: $OUTPUT_DIR"
fi

# Check if files exist
if [ ! -f "$RULE_PATH" ]; then
    echo "Error: Rule file $RULE_PATH does not exist."
    exit 1
fi

if [ ! -f "$TEST_FILE" ]; then
    echo "Error: Test file $TEST_FILE does not exist."
    exit 1
fi

# Make sure output directory exists
mkdir -p "$OUTPUT_DIR"

# Get the test file type
TEST_FILE_TYPE=$(echo "$TEST_FILE" | rev | cut -d'.' -f1 | rev)

# Create output file names
BASELINE_OUTPUT="$OUTPUT_DIR/${RULE_NAME}-${TEST_FILE_TYPE}-baseline.txt"
RULE_ENABLED_OUTPUT="$OUTPUT_DIR/${RULE_NAME}-${TEST_FILE_TYPE}-with-rule.txt"
COMPARISON_OUTPUT="$OUTPUT_DIR/${RULE_NAME}-${TEST_FILE_TYPE}-comparison.md"
TEST_REPORT_OUTPUT="$OUTPUT_DIR/${RULE_NAME}-test-report.md"

echo "============================================================"
echo "MDC Rule Test Workflow"
echo "============================================================"
echo "Rule: $RULE_PATH"
echo "Test File: $TEST_FILE"
echo "Query: $QUERY"
echo "Category: $RULE_CATEGORY"
echo "Output Directory: $OUTPUT_DIR"
echo "============================================================"

# Step 1: Backup current configuration
echo ""
echo "Step 1: Backing up current configuration..."
./test-setup.sh --backup
echo "Backup completed."

# Step 2: Baseline testing (rule disabled)
echo ""
echo "Step 2: Baseline Testing (without rule)..."
echo "Disabling rule $RULE_PATH..."
./test-setup.sh --disable "$RULE_PATH"

echo ""
echo "IMPORTANT: You need to start a NEW Firebender conversation now."
echo "Rules are loaded at the start of a conversation and cannot be changed during an active conversation."
echo ""
echo "Instructions:"
echo "  1. Start a new Firebender conversation"
echo "  2. Verify in the 'Rules Used' section that $RULE_PATH is NOT listed"
echo "  3. Use this query: \"$QUERY\""
echo "  4. Include this test file: $TEST_FILE"
echo "  5. Copy the complete response"
echo ""
read -p "Press Enter once you've started a new conversation and verified the rule is disabled..."

# Create baseline output placeholder
cat > "$BASELINE_OUTPUT" << EOF
=== Test Configuration ===
Rule: $RULE_PATH
File: $TEST_FILE
Query: $QUERY
Mode: baseline
Date: $(date)

=== File Content ===
$(cat "$TEST_FILE")

=== Test Query ===
$QUERY

=== Response ===
[PASTE THE RESPONSE FROM FIREBENDER HERE]
EOF

echo "Created template file: $BASELINE_OUTPUT"
echo "Please paste the response from Firebender into this file."
echo ""
read -p "Press Enter after you've copied the response and are ready to continue..."

# Step 3: Rule-enabled testing
echo ""
echo "Step 3: Rule-Enabled Testing..."
echo "Enabling rule $RULE_PATH..."
./test-setup.sh --enable "$RULE_PATH"

echo ""
echo "IMPORTANT: You need to start ANOTHER NEW Firebender conversation."
echo ""
echo "Instructions:"
echo "  1. Start a new Firebender conversation"
echo "  2. Verify in the 'Rules Used' section that $RULE_PATH IS listed"
echo "  3. Use the exact same query: \"$QUERY\""
echo "  4. Include the same test file: $TEST_FILE"
echo "  5. Copy the complete response"
echo ""
read -p "Press Enter once you've started a new conversation and verified the rule is enabled..."

# Create rule-enabled output placeholder
cat > "$RULE_ENABLED_OUTPUT" << EOF
=== Test Configuration ===
Rule: $RULE_PATH
File: $TEST_FILE
Query: $QUERY
Mode: with_rule
Date: $(date)

=== File Content ===
$(cat "$TEST_FILE")

=== Test Query ===
$QUERY

=== Response ===
[PASTE THE RESPONSE FROM FIREBENDER HERE]
EOF

echo "Created template file: $RULE_ENABLED_OUTPUT"
echo "Please paste the response from Firebender into this file."
echo ""
read -p "Press Enter after you've copied the response and are ready to continue..."

# Step 4: Create comparison analysis template
echo ""
echo "Step 4: Creating comparison analysis template..."

cat > "$COMPARISON_OUTPUT" << EOF
# $RULE_NAME Rule: Comparison Analysis

## Overview
This document analyzes the differences between AI responses with and without the $RULE_NAME rule enabled.

## Test Details
- **Rule:** $RULE_PATH
- **Test File:** $TEST_FILE
- **Query:** "$QUERY"
- **Test Date:** $(date)

## Communication Style Differences

| Aspect | Without Rule | With Rule |
|--------|-------------|-----------|
| Introduction/Verbosity | | |
| Closing | | |
| Justification Pattern | | |
| Tone | | |
| Personalization | | |

## Content Quality Differences

| Issue Type | Without Rule | With Rule |
|------------|-------------|-----------|
| Issue 1 | | |
| Issue 2 | | |
| Issue 3 | | |
| Overall | | |

## Summary of Rule Impact

### Positive Impacts
1. 
2. 
3. 

### Neutral/Mixed Impacts
1. 
2. 
3. 

### Performance Impact

| Metric | Without Rule | With Rule | Difference |
|--------|-------------|-----------|------------|
| Response Length | | | |
| Estimated Token Usage | | | |

## Conclusion
[Brief conclusion about the rule's effectiveness]
EOF

echo "Created comparison analysis template: $COMPARISON_OUTPUT"
echo "Please fill in this file with your analysis of the differences between responses."

# Step 5: Create test report template
echo ""
echo "Step 5: Creating test report template..."

cat > "$TEST_REPORT_OUTPUT" << EOF
# MDC Rule Test Report: $RULE_NAME

## Rule Information
- **File:** $RULE_PATH
- **Category:** $RULE_CATEGORY
- **File Patterns:** [Check the rule file]
- **Configuration Requirements:** [Check if any]
- **Description:** [Extract from rule file]

## Test Summary
- **Test Date:** $(date)
- **Status:** [PASS/FAIL/PARTIAL]
- **Overall Rating:** [1-5]
- **Value/Cost Ratio:** [LOW/MEDIUM/HIGH]

## Test Cases Results

### Basic Functionality Test
\`\`\`
Test ID: BASIC-$RULE_NAME-${TEST_FILE_TYPE^^}
Purpose: Verify that the rule provides appropriate guidance when triggered
Test File: $TEST_FILE
Test Query: "$QUERY"
Expected Behavior: [What you expected]
Actual Behavior (no rule): [Summarize]
Actual Behavior (with rule): [Summarize]
Pass/Fail: [PASS/FAIL]
Notes: [Observations]
\`\`\`

## Effectiveness Evaluation

| Criterion | Rating (1-5) | Notes |
|-----------|--------------|-------|
| Accuracy | | |
| Precision | | |
| Usefulness | | |
| Consistency | | |
| Performance | | |
| Integration | | |
| Configuration Complexity | | |
| Resource Efficiency | | |

## Issues and Observations
- [LIST_ANY_ISSUES_OR_OBSERVATIONS]

## Recommendations
- [KEEP_AS_IS/MODIFY/REMOVE]
- [SPECIFIC_IMPROVEMENT_SUGGESTIONS]

## Conclusion
[Brief conclusion about the rule]
EOF

echo "Created test report template: $TEST_REPORT_OUTPUT"
echo "Please fill in this file with your evaluation of the rule."

# Step 6: Restore original configuration
echo ""
echo "Step 6: Restoring original configuration..."
./test-setup.sh --restore
echo "Configuration restored."

echo ""
echo "============================================================"
echo "Test workflow completed!"
echo "============================================================"
echo "Generated files:"
echo "- Baseline results: $BASELINE_OUTPUT"
echo "- Rule-enabled results: $RULE_ENABLED_OUTPUT"
echo "- Comparison analysis template: $COMPARISON_OUTPUT"
echo "- Test report template: $TEST_REPORT_OUTPUT"
echo ""
echo "Next steps:"
echo "1. Fill in the comparison analysis and test report templates"
echo "2. Update your project status documentation"
echo "3. Update the rules inventory with results"
echo "============================================================"

exit 0