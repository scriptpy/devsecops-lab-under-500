#!/bin/bash
#
# Pre-commit hook to prevent committing secrets
# This script runs automatically before each git commit
#
# Copyright (C) 2026  G A Istrati
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# This project is for educational purposes only. Users are responsible for
# ensuring their use complies with all applicable laws.
#

# Colors for output (makes errors easier to see)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color (reset)

echo "Running pre-commit security check..."

# Patterns that indicate secrets (things we want to block)
PATTERNS=(
    "API_KEY="
    "PASSWORD="
    "SECRET="
    "TOKEN="
    "PRIVATE_KEY="
)

# Get list of files you're trying to commit
STAGED_FILES=$(git diff --cached --name-only)

# Check each file
for FILE in $STAGED_FILES; do
    # Skip checking the hook script itself (it contains the patterns we're looking for)
    if [[ "$FILE" == *"gitleaks-hook.sh"* ]] || [[ "$FILE" == *"pre-commit"* ]]; then
        continue
    fi
    
    # Skip binary files (they can cause null byte warnings)
    if git diff --cached --numstat "$FILE" | grep -q '^-'; then
        continue
    fi
    
    # Get the content of the file (what you're about to commit)
    FILE_CONTENT=$(git show ":$FILE" 2>/dev/null | head -c 100000)
    
    # Skip if file is empty or doesn't exist
    if [ -z "$FILE_CONTENT" ]; then
        continue
    fi
    
    # Check for each secret pattern
    for PATTERN in "${PATTERNS[@]}"; do
        # Look for the pattern in the file (case-insensitive)
        if echo "$FILE_CONTENT" | grep -qiE "$PATTERN"; then
            echo -e "${RED}❌ SECRET DETECTED!${NC}"
            echo -e "${RED}File: $FILE${NC}"
            echo -e "${RED}Pattern found: $PATTERN${NC}"
            echo ""
            echo -e "${YELLOW}Please remove secrets before committing.${NC}"
            echo -e "${YELLOW}Use .env files or GPG encryption for sensitive data.${NC}"
            echo ""
            echo -e "${YELLOW}To bypass this check (NOT recommended):${NC}"
            echo -e "${YELLOW}  git commit --no-verify${NC}"
            exit 1  # Block the commit
        fi
    done
done

# If we get here, no secrets were found
echo -e "${GREEN}✓ Pre-commit check passed - no secrets found${NC}"
exit 0  # Allow the commit

