#!/bin/bash

# MDC Rules Test Environment Setup Script
# This script helps with enabling/disabling specific rules for testing

# Display help message
show_help() {
    echo "MDC Rules Testing Helper"
    echo "========================"
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --enable RULE    Enable a specific rule for testing"
    echo "  --disable RULE   Disable a specific rule for testing"
    echo "  --enable-all     Enable all rules"
    echo "  --disable-all    Disable all rules temporarily"
    echo "  --reset          Reset firebender.json to original state"
    echo "  --status         Show currently enabled rules"
    echo "  --backup         Create backup of current firebender.json"
    echo "  --restore        Restore firebender.json from backup"
    echo "  --help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --enable .firebender/mdc/core/code-guidelines.mdc"
    echo "  $0 --disable .firebender/mdc/android/android-sdk.mdc"
    echo "  $0 --status"
    echo "  $0 --reset"
    echo ""
    echo "IMPORTANT: After making rule changes, you MUST start a new Firebender conversation"
    echo "for the changes to take effect. Rules are loaded at the start of a conversation and"
    echo "cannot be changed during an active conversation."
}

# Backup function
backup_config() {
    echo "Creating backup of firebender.json..."
    cp firebender.json firebender.json.backup
    echo "Backup created as firebender.json.backup"
}

# Restore function
restore_config() {
    if [ -f firebender.json.backup ]; then
        echo "Restoring firebender.json from backup..."
        cp firebender.json.backup firebender.json
        echo "Restore completed."
        echo ""
        echo "IMPORTANT: You must start a new conversation for these changes to take effect."
    else
        echo "Error: No backup file found."
    fi
}

# Show current status
show_status() {
    echo "Currently enabled rules in firebender.json:"
    grep -A 2 "rules\": \[" firebender.json | grep -v "rules\": \["
    grep "\.mdc\"" firebender.json | sort
}

# Enable a specific rule
enable_rule() {
    rule_path=$1
    
    if grep -q "$rule_path" firebender.json; then
        echo "Rule $rule_path is already enabled."
    else
        # Find the first "rules": [ section and add the rule after it
        # Escape forward slashes in the rule path for sed
        escaped_path=$(echo "$rule_path" | sed 's/\//\\\//g')
        sed -i "/\"rules\": \[/a \    \"$escaped_path\"," firebender.json
        echo "Rule $rule_path has been enabled."
        echo ""
        echo "IMPORTANT: You must start a new conversation for this change to take effect."
        echo "Rules are loaded when a conversation begins and cannot be changed mid-conversation."
    fi
}

# Disable a specific rule
disable_rule() {
    rule_path=$1
    
    if grep -q "$rule_path" firebender.json; then
        # Remove the rule from the file
        # Escape forward slashes and other special characters in the rule path for sed
        escaped_path=$(echo "$rule_path" | sed 's/\//\\\//g')
        sed -i "/\"$escaped_path\"/d" firebender.json
        echo "Rule $rule_path has been disabled."
        echo ""
        echo "IMPORTANT: You must start a new conversation for this change to take effect."
        echo "Rules are loaded when a conversation begins and cannot be changed mid-conversation."
    else
        echo "Rule $rule_path is not currently enabled."
    fi
}

# Enable all rules
enable_all_rules() {
    echo "Enabling all rules..."
    # Find all .mdc files
    find .firebender/mdc -name "*.mdc" | while read -r rule; do
        enable_rule "$rule"
    done
    echo "All rules have been enabled."
    echo ""
    echo "IMPORTANT: You must start a new conversation for these changes to take effect."
}

# Disable all rules
disable_all_rules() {
    echo "Disabling all rules temporarily..."
    # Make a backup before making changes
    backup_config
    # Remove all .mdc file references
    grep -vF ".mdc\"" firebender.json > firebender.json.tmp && mv firebender.json.tmp firebender.json
    echo "All rules have been disabled. Use --restore to revert this change."
    echo ""
    echo "IMPORTANT: You must start a new conversation for this change to take effect."
    echo "Rules are loaded when a conversation begins and cannot be changed mid-conversation."
}

# Reset to original state
reset_config() {
    echo "Resetting firebender.json to original state..."
    if [ -f firebender.json.original ]; then
        cp firebender.json.original firebender.json
        echo "Reset completed."
        echo ""
        echo "IMPORTANT: You must start a new conversation for these changes to take effect."
    else
        echo "Creating original backup before reset..."
        cp firebender.json firebender.json.original
        echo "Original backup created as firebender.json.original"
    fi
}

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
        --enable)
            if [ -z "$2" ]; then
                echo "Error: Rule path not provided."
                exit 1
            fi
            enable_rule "$2"
            shift 2
            ;;
        --disable)
            if [ -z "$2" ]; then
                echo "Error: Rule path not provided."
                exit 1
            fi
            disable_rule "$2"
            shift 2
            ;;
        --enable-all)
            enable_all_rules
            shift
            ;;
        --disable-all)
            disable_all_rules
            shift
            ;;
        --reset)
            reset_config
            shift
            ;;
        --status)
            show_status
            shift
            ;;
        --backup)
            backup_config
            shift
            ;;
        --restore)
            restore_config
            shift
            ;;
        *)
            echo "Error: Unknown option $1"
            show_help
            exit 1
            ;;
    esac
done

echo ""
echo "============================================================="
echo "REMINDER: Rules only take effect in NEW conversations."
echo "You must close this conversation and start a new one"
echo "for any rule changes to take effect."
echo "============================================================="

exit 0