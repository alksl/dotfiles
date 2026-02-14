#!/bin/bash
# Logging functions for terminal output

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log functions
log() {
    echo -e "${GREEN}$*${NC}"
}

warn() {
    echo -e "${YELLOW}$*${NC}"
}

error() {
    echo -e "${RED}$*${NC}" >&2
}

export -f log
export -f warn
export -f error
