#!/bin/bash

# Enhanced MDC Rule Test Script
# Usage: ./simple-test.sh [rule_path]

# Get absolute paths
PROJECT_DIR=$(pwd)
FIREBENDER_CONFIG=$(readlink -f firebender.json)
REAL_CONFIG="$FIREBENDER_CONFIG"

# Default values
RULE_PATH=${1:-".firebender/mdc/core/code-guidelines.mdc"}
TEST_FILE="test-files/kotlin/SampleClass.kt"
QUERY="Review this code and suggest improvements"
RULE_NAME=$(basename "$RULE_PATH" .mdc)
FILE_EXT=$(echo "$TEST_FILE" | rev | cut -d'.' -f1 | rev)
OUTPUT_DIR="$PROJECT_DIR/test-results/simplified"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Output filenames
CONFIG_FILE="$PROJECT_DIR/firebender-test.json"
BASELINE_FILE="$OUTPUT_DIR/${RULE_NAME}-${FILE_EXT}-baseline.txt"
RULE_ENABLED_FILE="$OUTPUT_DIR/${RULE_NAME}-${FILE_EXT}-with-rule.txt"
ANALYSIS_FILE="$OUTPUT_DIR/${RULE_NAME}-analysis.md"

# Create template files
cp "$PROJECT_DIR/test-results/simplified/response-template.txt" "$BASELINE_FILE"
cp "$PROJECT_DIR/test-results/simplified/response-template.txt" "$RULE_ENABLED_FILE"
cp "$PROJECT_DIR/test-results/simplified/analysis-template.md" "$ANALYSIS_FILE"

# Update the template files with proper values
sed -i "s|\[RULE_PATH\]|$RULE_PATH|g" "$BASELINE_FILE" "$RULE_ENABLED_FILE" "$ANALYSIS_FILE"
sed -i "s|\[FILE_PATH\]|$TEST_FILE|g" "$BASELINE_FILE" "$RULE_ENABLED_FILE" "$ANALYSIS_FILE"
sed -i "s|\[QUERY\]|$QUERY|g" "$BASELINE_FILE" "$RULE_ENABLED_FILE" "$ANALYSIS_FILE"
sed -i "s|\[RULE_NAME\]|$RULE_NAME|g" "$ANALYSIS_FILE"
sed -i "s|\[DATE\]|$(date)|g" "$BASELINE_FILE" "$RULE_ENABLED_FILE" "$ANALYSIS_FILE"
sed -i "s|\[baseline/with_rule\]|baseline|g" "$BASELINE_FILE"
sed -i "s|\[baseline/with_rule\]|with_rule|g" "$RULE_ENABLED_FILE"

# Backup original firebender.json
echo "Backing up original firebender.json..."
cp "$REAL_CONFIG" "$REAL_CONFIG.backup"
echo "Backup created at: $REAL_CONFIG.backup"

echo "==== MDC Rule Testing: ${RULE_NAME} ===="
echo "Rule: $RULE_PATH"
echo "Test File: $PROJECT_DIR/$TEST_FILE"
echo "Query: $QUERY"
echo "Output files will be created in: $OUTPUT_DIR"
echo ""
echo "Press Enter to start testing..."
read

# STEP 1: BASELINE TEST - WITHOUT RULE
clear
echo "STEP 1: Baseline Test (without rule)"

# Update the firebender.json file without the rule
cat "$CONFIG_FILE" > "$REAL_CONFIG"
echo "Configuration updated to not include the rule."
echo ""
echo "Please follow these steps:"
echo "1. Start a NEW conversation"
echo "2. Use this query (copy-paste ready):"
echo "$QUERY"
echo ""
echo "3. Include this file (full path for clickable link):"
echo "$PROJECT_DIR/$TEST_FILE"
echo ""
echo "4. After receiving the response, copy it to this file (clickable):"
echo "$BASELINE_FILE"
echo ""
echo "Press Enter when you have completed these steps..."
read

# STEP 2: TEST WITH RULE ENABLED
clear
echo "STEP 2: Test with Rule Enabled"

# Directly modify the firebender.json file to include the rule
if command -v jq &> /dev/null; then
    # Use jq to add the rule
    jq --arg rule "$RULE_PATH" '.rules += [$rule]' "$CONFIG_FILE" > "$REAL_CONFIG"
    echo "Configuration updated to include the rule."
else
    # Manually add the rule to the configuration
    # This is a simplified approach - in a real scenario we would want to use proper JSON parsing
    sed -i 's/"rules": \[/"rules": \[\n    "'"$RULE_PATH"'",/' "$REAL_CONFIG" 
    echo "Configuration manually updated to include the rule."
fi

echo ""
echo "Please follow these steps:"
echo "1. Start a NEW conversation"
echo "2. Use the SAME query (copy-paste ready):"
echo "$QUERY"
echo ""
echo "3. Include the SAME file (full path for clickable link):"
echo "$PROJECT_DIR/$TEST_FILE"
echo ""
echo "4. After receiving the response, copy it to this file (clickable):"
echo "$RULE_ENABLED_FILE"
echo ""
echo "Press Enter when you have completed these steps..."
read

# STEP 3: ANALYSIS
clear
echo "STEP 3: Analysis"
echo "1. Compare the responses in (clickable links):"
echo "   - $BASELINE_FILE"
echo "   - $RULE_ENABLED_FILE"
echo "2. Complete your analysis in: $ANALYSIS_FILE"
echo ""
echo "3. Restore original configuration? [Y/n]"
read restore_choice
if [[ $restore_choice == "n" || $restore_choice == "N" ]]; then
    echo "Keeping the modified configuration."
else
    echo "Restoring original firebender.json configuration..."
    cp "$REAL_CONFIG.backup" "$REAL_CONFIG"
    echo "Original configuration restored."
fi

echo ""
echo "Testing complete!"