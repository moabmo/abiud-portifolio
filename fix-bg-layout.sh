#!/usr/bin/env bash
set -euo pipefail

CSS="src/styles.css"

# 1) Make BODY carry the full continuous background.
# 2) Turn .bg overlays into subtle additions (not the primary bg).
# 3) Remove hero "box" borders/background so it doesn't look like a separate panel.
# 4) Make hero grid centered and use full width without awkward empty left side.

perl -0777 -i -pe '
s/body\{\n([\s\S]*?)\n\}/body{\n  margin: 0;\n  font-family: Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Helvetica Neue", sans-serif;\n  color: var(--text);\n  min-height: 100vh;\n  background:\n    radial-gradient(1200px 760px at 10% 10%, rgba(64,140,255,0.26), transparent 62%),\n    radial-gradient(980px 740px at 92% 14%, rgba(255,122,0,0.22), transparent 64%),\n    radial-gradient(900px 700px at 55% 100%, rgba(0,220,255,0.12), transparent 62%),\n    linear-gradient(180deg, #0b2a62 0%, #050713 70%, #04060f 100%);\n  background-attachment: fixed;\n}\n/smg;

s/\.bg\{[\s\S]*?\}\n/\.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }\n/smg;

s/\.grid\{[\s\S]*?\}\n/\.grid{\n  position: absolute; inset: 0;\n  background-image:\n    linear-gradient(rgba(255,255,255,0.05) 1px, transparent 1px),\n    linear-gradient(90deg, rgba(255,255,255,0.05) 1px, transparent 1px);\n  background-size: 88px 88px;\n  mask-image: radial-gradient(ellipse at 50% 15%, black 0%, transparent 66%);\n  opacity: 0.08;\n}\n/smg;

s/\.heroBleed\{[\s\S]*?\}\n/\.heroBleed{\n  width: 100%;\n  margin-top: 18px;\n  position: relative;\n  overflow: hidden;\n  border: 0;\n  background: transparent;\n  box-shadow: none;\n}\n/smg;

s/\.heroSheen\{[\s\S]*?\}\n/\.heroSheen{\n  position: absolute;\n  inset: -20%;\n  background: linear-gradient(115deg, transparent 35%, rgba(255,255,255,0.10) 45%, transparent 55%);\n  transform: translateX(-40%);\n  animation: sweep 10.5s var(--ease) infinite;\n  opacity: 0.18;\n  filter: blur(2px);\n  pointer-events: none;\n}\n/smg;

s/\.heroGrid\{[\s\S]*?\}\n/\.heroGrid{\n  padding: 30px 0 24px;\n  display: grid;\n  grid-template-columns: 1.05fr 0.95fr;\n  gap: 18px;\n  align-items: start;\n}\n/smg;

# Make container actually feel centered and full-width usable
s/--content: min\(1240px, 100% - 48px\);/--content: min(1320px, 100% - 40px);/g;

# Reduce the feeling of left waste by allowing hero text block to stretch and not hug the right
s/\.lead\{[^}]*max-width: 75ch;[^}]*\}/\.lead{ margin: 0 0 14px; max-width: 68ch; color: rgba(255,255,255,0.82); line-height: 1.72; }\n/smg;

# On large screens, keep hero content balanced (not pushed right)
s/\.h1\{\n  margin: 14px 0 10px;\n  font-size: clamp\(44px, 5\.3vw, 78px\);\n  letter-spacing: -0\.055em;\n  line-height: 1\.02;\n\}/\.h1{\n  margin: 14px 0 10px;\n  font-size: clamp(44px, 5.2vw, 76px);\n  letter-spacing: -0.055em;\n  line-height: 1.02;\n}\n/smg;

# Make cards slightly more “floating” and reduce heavy blocks
s/\.card\{\n  position: relative;\n  background: linear-gradient\(180deg, rgba\(255,255,255,0\.10\), rgba\(255,255,255,0\.06\)\);\n  border: 1px solid rgba\(255,255,255,0\.16\);\n  border-radius: 22px;\n  box-shadow: var\(--shadow2\);\n  backdrop-filter: blur\(20px\);\n  -webkit-backdrop-filter: blur\(20px\);\n  padding: 18px;\n  transition: transform 240ms var\(--ease\), box-shadow 240ms var\(--ease\), border-color 240ms var\(--ease\);\n\}/\.card{\n  position: relative;\n  background: linear-gradient(180deg, rgba(255,255,255,0.10), rgba(255,255,255,0.05));\n  border: 1px solid rgba(255,255,255,0.14);\n  border-radius: 22px;\n  box-shadow: 0 18px 60px rgba(0,0,0,0.32);\n  backdrop-filter: blur(20px);\n  -webkit-backdrop-filter: blur(20px);\n  padding: 18px;\n  transition: transform 240ms var(--ease), box-shadow 240ms var(--ease), border-color 240ms var(--ease);\n}\n/smg;

' "$CSS"

echo "✅ Fixed: continuous page background + hero no longer looks like a separate block + layout uses space better."
