#!/bin/bash

# Simplified MDC Rule Test Script
# Usage: ./simple-test.sh [rule_path]

# Default values
RULE_PATH=${1:-".firebender/mdc/core/code-guidelines.mdc"}
TEST_FILE="test-files/kotlin/SampleClass.kt"
QUERY="Review this code and suggest improvements"
RULE_NAME=$(basename "$RULE_PATH" .mdc)
FILE_EXT=$(echo "$TEST_FILE" | rev | cut -d'.' -f1 | rev)
OUTPUT_DIR="test-results/simplified"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Output filenames
CONFIG_FILE="firebender-test.json"
BASELINE_FILE="$OUTPUT_DIR/${RULE_NAME}-${FILE_EXT}-baseline.txt"
RULE_ENABLED_FILE="$OUTPUT_DIR/${RULE_NAME}-${FILE_EXT}-with-rule.txt"

echo "==== MDC Rule Testing: ${RULE_NAME} ===="
echo "Rule: $RULE_PATH"
echo "Test File: $TEST_FILE"
echo "Query: $QUERY"
echo ""

# STEP 1: BASELINE TEST - WITHOUT RULE
echo "STEP 1: Baseline Test (without rule)"
echo "1. Copy this configuration to your local firebender.json:"
cat "$CONFIG_FILE"
echo ""
echo "2. Start a NEW conversation"
echo "3. Use this query: \"$QUERY\""
echo "4. Include this file: $TEST_FILE"
echo ""
echo "After receiving the response, copy it to: $BASELINE_FILE"
echo "Press Enter when ready to proceed to the next step..."
read

# STEP 2: TEST WITH RULE ENABLED
echo ""
echo "STEP 2: Test with Rule Enabled"
echo "1. Copy this updated configuration to your firebender.json:"

# Check if jq is installed
if command -v jq &> /dev/null; then
    # Use jq to add the rule
    jq --arg rule "$RULE_PATH" '.rules += [$rule]' "$CONFIG_FILE"
else
    # Provide manual instructions if jq is not installed
    echo "Could not find 'jq' tool. Please manually add this rule to your firebender.json:"
    echo ""
    echo "  \"$RULE_PATH\""
    echo ""
    echo "Add it to the 'rules' array in $CONFIG_FILE"
fi

echo ""
echo "2. Start a NEW conversation"
echo "3. Use the SAME query: \"$QUERY\""
echo "4. Include the SAME file: $TEST_FILE"
echo ""
echo "After receiving the response, copy it to: $RULE_ENABLED_FILE"
echo "Press Enter when ready to proceed to analysis..."
read

# STEP 3: ANALYSIS TEMPLATES
echo ""
echo "STEP 3: Analysis"
echo "1. Compare the responses in:"
echo "   - $BASELINE_FILE"
echo "   - $RULE_ENABLED_FILE"
echo "2. Create your analysis in: $OUTPUT_DIR/${RULE_NAME}-analysis.md"
echo ""
echo "Testing complete!"