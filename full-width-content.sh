#!/usr/bin/env bash
set -euo pipefail

CSS="src/styles.css"

perl -0777 -i -pe '
# 1) Make container truly wide (almost full width)
s/--content: min\(1440px, 100% - 36px\);/--content: min(92vw, 1800px);/g;

# 2) Remove extra container padding shrink
s/--container: minmax\(16px, 1fr\);/--container: minmax(24px, 1fr);/g;

# 3) Make hero grid more dominant and balanced
s/grid-template-columns: 1\.18fr 0\.82fr;/grid-template-columns: 1.35fr 0.65fr;/g;

# 4) Slightly increase hero text width for better balance
s/max-width: 72ch;/max-width: 78ch;/g;

' "$CSS"

echo "✅ Content now uses ~92% of screen width."
