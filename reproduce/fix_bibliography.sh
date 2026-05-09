#!/bin/bash
# Fix script for missing deFerra2020.bib bibliography file
# Downloads from GitHub raw URL (avoids git fetch which bloats .git/objects/)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$SCRIPT_DIR"

echo "========================================"
echo "de-Ferra2020-kz Bibliography Fix"
echo "========================================"
echo ""

# Check if deFerra2020.bib exists
if [[ -f "deFerra2020.bib" ]]; then
    echo "✅ deFerra2020.bib already exists"
    exit 0
fi

echo "❌ deFerra2020.bib not found"
echo ""

# Download from GitHub raw URL
GITHUB_REPO="${GITHUB_REPO:-Siying99/de-Ferra2020-kz}"
PRECOMPUTED_BRANCH="${PRECOMPUTED_BRANCH:-main}"
RAW_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${PRECOMPUTED_BRANCH}/deFerra2020.bib"

echo "Attempting to download from GitHub..."
echo "URL: $RAW_URL"
echo ""

if curl -L --fail --progress-bar -o deFerra2020.bib "$RAW_URL" 2>&1; then
    if [[ -f "deFerra2020.bib" && -s "deFerra2020.bib" ]]; then
        FILE_SIZE=$(du -h "deFerra2020.bib" 2>/dev/null | cut -f1)
        echo ""
        echo "✅ Successfully downloaded deFerra2020.bib ($FILE_SIZE)"
        exit 0
    fi
fi

# Download failed
rm -f deFerra2020.bib 2>/dev/null || true

echo ""
echo "⚠️  Could not download deFerra2020.bib from GitHub"
echo ""
echo "This may indicate:"
echo "  • Network connectivity issues"
echo "  • GitHub is temporarily unavailable"
echo "  • The file doesn't exist on the '${PRECOMPUTED_BRANCH}' branch"
echo ""
echo "Manual fix:"
echo "  git checkout main -- deFerra2020.bib"
echo ""
exit 1
