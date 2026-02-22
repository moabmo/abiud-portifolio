#!/usr/bin/env bash
set -euo pipefail

CSS="src/styles.css"

node <<'NODE'
const fs = require("fs");
const p = "src/styles.css";
let s = fs.readFileSync(p, "utf8");

// 1) Make the content cap much wider (but still sane)
s = s.replace(
  /--container:\s*minmax\([^)]+\);\s*\n\s*--content:\s*min\([^)]+\);\s*/m,
  `--container: 1fr;
  --content: min(92vw, 1800px);
`
);

// 2) Replace the container grid with a true centered wrapper
s = s.replace(
  /\.container\{\s*display:\s*grid;[\s\S]*?\}\s*\n\.container\s*>\s*\*\{[\s\S]*?\}\s*/m,
`.container{
  width: min(92vw, 1800px);
  max-width: min(92vw, 1800px);
  margin-left: auto;
  margin-right: auto;
}
.container > *{
  width: 100%;
}
`
);

// 3) Ensure hero + sections also stretch fully
s += `

/* === WIDE LAYOUT ENFORCER === */
.heroBleed, .section, main{
  width: 100%;
}
`;

fs.writeFileSync(p, s, "utf8");
console.log("✅ Applied REAL wide fix: container is now a centered wide wrapper.");
NODE

rm -rf node_modules/.cache
npm start
