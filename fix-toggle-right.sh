#!/usr/bin/env bash
set -euo pipefail

CSS="src/styles.css"

node <<'NODE'
const fs = require("fs");
const p = "src/styles.css";
let s = fs.readFileSync(p, "utf8");

// 1) Ensure navInner uses space-between
s = s.replace(/(\.navInner\s*\{[\s\S]*?display:\s*flex;[\s\S]*?align-items:\s*center;)([\s\S]*?\})/m, (m, a, b) => {
  if (/justify-content\s*:\s*space-between\s*;/.test(m)) return m;
  return a + "\n  justify-content: space-between;" + b;
});

// 2) Ensure mobileOnly is pushed to the far right
if (!/\.mobileOnly\s*\{[\s\S]*?margin-left:\s*auto;/.test(s)) {
  s += `

/* === FORCE HAMBURGER TO FAR RIGHT === */
.mobileOnly{
  margin-left: auto;
}
`;
}

fs.writeFileSync(p, s, "utf8");
console.log("✅ Toggle pushed to the far right (navInner + mobileOnly).");
NODE

rm -rf node_modules/.cache
npm start
