#!/bin/bash

# MDC Rules Test Query Runner
# This script helps run test queries and record results

# Display help message
show_help() {
    echo "MDC Rules Test Query Runner"
    echo "==========================="
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --rule RULE_PATH   Specify the rule to test"
    echo "  --file FILE_PATH   Specify the test file to use"
    echo "  --query \"QUERY\"    Specify the query to run"
    echo "  --mode MODE        Specify mode (baseline or with_rule)"
    echo "  --output FILE      Specify output file for results"
    echo "  --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --rule .firebender/mdc/core/code-guidelines.mdc --file test-files/kotlin/SampleClass.kt --query \"Review this code\" --mode baseline --output test-results/core/code-guidelines-baseline-1.txt"
    echo ""
}

# Default values
RULE_PATH=""
FILE_PATH=""
QUERY=""
MODE="baseline"
OUTPUT_FILE="test-output.txt"

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
            shift 2
            ;;
        --file)
            if [ -z "$2" ]; then
                echo "Error: File path not provided."
                exit 1
            fi
            FILE_PATH="$2"
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
        --mode)
            if [ -z "$2" ]; then
                echo "Error: Mode not provided."
                exit 1
            fi
            MODE="$2"
            shift 2
            ;;
        --output)
            if [ -z "$2" ]; then
                echo "Error: Output file not provided."
                exit 1
            fi
            OUTPUT_FILE="$2"
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

if [ -z "$FILE_PATH" ]; then
    echo "Error: File path is required."
    exit 1
fi

if [ -z "$QUERY" ]; then
    echo "Error: Query is required."
    exit 1
fi

# Prepare the test environment based on mode
if [ "$MODE" == "baseline" ]; then
    echo "Running in baseline mode (rule disabled)..."
    ./test-setup.sh --disable "$RULE_PATH"
elif [ "$MODE" == "with_rule" ]; then
    echo "Running with rule enabled..."
    ./test-setup.sh --enable "$RULE_PATH"
else
    echo "Error: Invalid mode. Use 'baseline' or 'with_rule'."
    exit 1
fi

# Record test configuration
echo "=== Test Configuration ===" > "$OUTPUT_FILE"
echo "Rule: $RULE_PATH" >> "$OUTPUT_FILE"
echo "File: $FILE_PATH" >> "$OUTPUT_FILE"
echo "Query: $QUERY" >> "$OUTPUT_FILE"
echo "Mode: $MODE" >> "$OUTPUT_FILE"
echo "Date: $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "=== File Content ===" >> "$OUTPUT_FILE"
cat "$FILE_PATH" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "=== Test Query ===" >> "$OUTPUT_FILE"
echo "$QUERY" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Placeholder for actual AI query execution
# In a real environment, this would send the query to the AI assistant
# and record the response
echo "=== Response ===" >> "$OUTPUT_FILE"
echo "NOTE: This is a simulation script. In a real test environment," >> "$OUTPUT_FILE"
echo "this would run the actual query and record the AI's response." >> "$OUTPUT_FILE"
echo "For now, you would need to manually run the query using the AI tool" >> "$OUTPUT_FILE"
echo "and copy the response to this file." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "Test query has been prepared."
echo "Output file: $OUTPUT_FILE"
echo ""
echo "Next steps:"
echo "1. Manually run your query through the AI tool"
echo "2. Copy the response to the output file"
echo "3. Analyze the results"

exit 0