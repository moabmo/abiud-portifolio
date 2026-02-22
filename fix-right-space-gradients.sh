#!/usr/bin/env bash
set -euo pipefail

CSS="src/styles.css"

perl -0777 -i -pe '
# 1) Give the content more room so it fills the screen better
s/--content: min\(1320px, 100% - 40px\);/--content: min(1440px, 100% - 36px);/g;

# 2) Make the overall BODY background gradients smoother + more premium
s/background:\n([\s\S]*?)background-attachment: fixed;/background:\n    radial-gradient(1400px 860px at 12% 12%, rgba(58,145,255,0.28), transparent 64%),\n    radial-gradient(1100px 820px at 88% 14%, rgba(255,140,40,0.22), transparent 66%),\n    radial-gradient(980px 760px at 58% 100%, rgba(0,220,255,0.11), transparent 64%),\n    radial-gradient(900px 720px at 92% 70%, rgba(58,145,255,0.10), transparent 68%),\n    linear-gradient(180deg, #0b2f73 0%, #061023 52%, #04060f 100%);\n  background-attachment: fixed;/smg;

# 3) Balance hero so it doesnt hug left; also reduce perceived right empty space
s/\.heroGrid\{\n  padding: 30px 0 24px;\n  display: grid;\n  grid-template-columns: 1\.05fr 0\.95fr;\n  gap: 18px;\n  align-items: start;\n\}/.heroGrid{\n  padding: 28px 0 22px;\n  display: grid;\n  grid-template-columns: 1.18fr 0.82fr;\n  gap: 18px;\n  align-items: start;\n}\n/smg;

# 4) Add a gentle right-side glow ON the hero area (makes right look intentional)
s/\.heroBleed\{\n  width: 100%;\n  margin-top: 18px;\n  position: relative;\n  overflow: hidden;\n  border: 0;\n  background: transparent;\n  box-shadow: none;\n\}/.heroBleed{\n  width: 100%;\n  margin-top: 18px;\n  position: relative;\n  overflow: hidden;\n  border: 0;\n  background:\n    radial-gradient(900px 640px at 92% 32%, rgba(255,140,40,0.14), transparent 62%),\n    radial-gradient(980px 720px at 12% 40%, rgba(58,145,255,0.12), transparent 62%);\n  box-shadow: none;\n}\n/smg;

# 5) Improve the big name gradients
s/\.grad\{\n  background: linear-gradient\(135deg, rgba\(255,122,0,0\.98\), rgba\(64,140,255,0\.98\)\);\n/\.grad{\n  background: linear-gradient(120deg, rgba(255,150,70,0.98), rgba(255,122,0,0.92), rgba(58,145,255,0.98));\n/smg;

s/\.grad2\{\n  background: linear-gradient\(135deg, rgba\(0,220,255,0\.80\), rgba\(64,140,255,0\.98\), rgba\(255,196,0,0\.70\)\);\n/\.grad2{\n  background: linear-gradient(120deg, rgba(58,145,255,0.98), rgba(0,220,255,0.72), rgba(255,170,70,0.90));\n/smg;

# 6) Give the lead a slightly larger max width so it feels less cramped on wide screens
s/max-width: 68ch;/max-width: 72ch;/g;

# 7) Make the hero card look more premium (slightly deeper contrast)
s/background: linear-gradient\(180deg, rgba\(255,255,255,0\.10\), rgba\(255,255,255,0\.05\)\);/background: linear-gradient(180deg, rgba(255,255,255,0.11), rgba(255,255,255,0.045));/g;

' "$CSS"

echo "✅ Right space reduced + gradients upgraded."
