#!/bin/bash
# 1Password CLI helper functions

# 1Password account
OP_ACCOUNT="my.1password.com"

# Check if 1Password CLI is available and unlocked
check_op_available() {
    # Check if op command exists
    command -v op &>/dev/null || return 1
    
    # Check if 1Password is unlocked (whoami succeeds when logged in)
    op whoami --account "$OP_ACCOUNT" &>/dev/null || return 1
    
    return 0
}

# Fetch password from 1Password item
# Usage: fetch_op_password "item-name" "field-name"
fetch_op_password() {
    local item_name="$1"
    local field_name="${2:-password}"
    
    # Fetch the password field from the item
    op item get "$item_name" --account "$OP_ACCOUNT" --fields "$field_name" --reveal 2>/dev/null || return 1
}

# Store password in 1Password
# Usage: store_op_password "item-name" "password" ["tags"]
store_op_password() {
    local item_name="$1"
    local password="$2"
    local tags="${3:-ssh}"
    
    # Check if item already exists
    if op item get "$item_name" --account "$OP_ACCOUNT" &>/dev/null; then
        # Update existing item - set the password field
        # For password category, the password field is accessed as "password"
        op item edit "$item_name" --account "$OP_ACCOUNT" "password=${password}" || return 1
    else
        # Create new item with password field
        # For password items, we need to set the password field explicitly
        op item create --account "$OP_ACCOUNT" \
            --category=password \
            --title="$item_name" \
            --tags="$tags" \
            "password=${password}" || return 1
    fi
    
    return 0
}

# Export functions
export -f check_op_available
export -f fetch_op_password
export -f store_op_password
