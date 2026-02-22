#!/usr/bin/env bash
set -euo pipefail

# 1) Update CSS to be more colorful + elegant + full width layout
cat > src/styles.css <<'CSS'
:root{
  /* Canvas */
  --bg0:#050814;
  --bg1:#071a3a;        /* deep blue */
  --bg2:#0b2a55;        /* deeper blue */

  /* Accents */
  --blue: rgba(64,140,255,0.95);
  --blue2: rgba(42,106,255,0.90);
  --cyan: rgba(0,220,255,0.65);
  --orange: rgba(255,122,0,0.95);
  --amber: rgba(255,196,0,0.70);
  --magenta: rgba(255,64,180,0.45);

  /* Surfaces */
  --panelA: rgba(255,255,255,0.10);
  --panelB: rgba(255,255,255,0.06);
  --stroke: rgba(255,255,255,0.14);

  /* Text */
  --text: rgba(255,255,255,0.92);
  --muted: rgba(255,255,255,0.72);

  /* FX */
  --shadow1: 0 28px 90px rgba(0,0,0,0.50);
  --shadow2: 0 18px 55px rgba(0,0,0,0.32);
  --shadow3: 0 10px 26px rgba(0,0,0,0.25);
  --r: 22px;
}

*{ box-sizing: border-box; }
html, body{ height: 100%; }
body{
  margin: 0;
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Helvetica Neue", sans-serif;
  color: var(--text);
  background:
    radial-gradient(1200px 760px at 10% 10%, rgba(64,140,255,0.24), transparent 60%),
    radial-gradient(900px 650px at 92% 14%, rgba(255,122,0,0.18), transparent 62%),
    radial-gradient(900px 700px at 55% 100%, rgba(0,220,255,0.10), transparent 60%),
    radial-gradient(800px 520px at 65% 35%, rgba(255,64,180,0.08), transparent 55%),
    linear-gradient(180deg, var(--bg2), var(--bg0));
}

a{ color: inherit; text-decoration: none; }
button{ font: inherit; }
::selection{ background: rgba(255,122,0,0.25); }

.app{ min-height: 100vh; position: relative; }

/* Background layers */
.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.blob{ position: absolute; filter: blur(52px); opacity: .95; transform: translate3d(0,0,0); }
.b1{ width: 640px; height: 640px; left: -200px; top: -220px; background: rgba(64,140,255,0.26); border-radius: 50%; }
.b2{ width: 680px; height: 680px; right: -240px; top: -220px; background: rgba(255,122,0,0.22); border-radius: 50%; }

.grid{
  position: absolute; inset: 0;
  background-image:
    linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 72px 72px;
  mask-image: radial-gradient(ellipse at 50% 15%, black 0%, transparent 64%);
  opacity: 0.10;
}

.noise{
  position: absolute; inset: 0;
  background-image:
    radial-gradient(circle at 20% 30%, rgba(255,255,255,0.06), transparent 50%),
    radial-gradient(circle at 70% 40%, rgba(255,255,255,0.05), transparent 55%),
    radial-gradient(circle at 40% 80%, rgba(255,255,255,0.04), transparent 60%);
  opacity: .16;
}

/* Elegant animated light sweep */
.sheen{
  position: absolute;
  inset: -20%;
  background: linear-gradient(
    115deg,
    transparent 35%,
    rgba(255,255,255,0.08) 45%,
    transparent 55%
  );
  transform: translateX(-40%);
  animation: sweep 10s ease-in-out infinite;
  opacity: 0.25;
  filter: blur(2px);
}
@keyframes sweep{
  0%{ transform: translateX(-55%); }
  50%{ transform: translateX(10%); }
  100%{ transform: translateX(-55%); }
}

/* FULL WIDTH main container */
.main{
  position: relative;
  z-index: 1;
  padding: 26px 0 70px;   /* full width, no side padding here */
}

/* Inner readable container (still looks full width) */
.inner{
  width: min(1200px, 92vw);
  margin: 0 auto;
}

.nav{ position: sticky; top: 0; z-index: 50; padding: 18px 0 0; }
.navInner{
  width: min(1200px, 92vw);
  margin: 0 auto;
  padding: 14px 16px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.16);
  background: rgba(8,12,24,0.62);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  box-shadow: var(--shadow2);
  display: flex;
  align-items: center;
  gap: 14px;
}

.brand{ display: inline-flex; align-items: center; gap: 10px; border: 0; background: transparent; color: var(--text); cursor: pointer; }
.brandMark{
  width: 34px; height: 34px;
  border-radius: 12px;
  display: grid; place-items: center;
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #050814;
  font-weight: 950;
  box-shadow: 0 18px 40px rgba(64,140,255,0.18), 0 14px 34px rgba(255,122,0,0.12);
}
.brandText{ font-weight: 900; letter-spacing: -0.02em; opacity: .95; }

.navLinks{ display: flex; gap: 6px; margin-left: auto; }
.navLink{
  padding: 10px 12px;
  border-radius: 999px;
  border: 1px solid transparent;
  background: transparent;
  color: rgba(255,255,255,0.80);
  cursor: pointer;
}
.navLink:hover{
  background: rgba(255,255,255,0.07);
  border-color: rgba(255,255,255,0.12);
  color: rgba(255,255,255,0.94);
}
.navLink.active{
  background: rgba(255,255,255,0.10);
  border-color: rgba(255,255,255,0.16);
  color: rgba(255,255,255,0.96);
}

.navCtas{ display: flex; align-items: center; gap: 10px; }
.iconBtn{
  width: 38px; height: 38px;
  display: grid; place-items: center;
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.88);
}
.iconBtn:hover{ background: rgba(255,255,255,0.10); transform: translateY(-1px); transition: 160ms ease; }

.btn{
  display: inline-flex; align-items: center; justify-content: center; gap: 10px;
  padding: 10px 14px;
  border-radius: 14px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.92);
  cursor: pointer;
}
.btn:hover{ background: rgba(255,255,255,0.10); transform: translateY(-1px); transition: 160ms ease; }
.btn.primary{
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #050814;
  border: 1px solid rgba(255,255,255,0.18);
  box-shadow: 0 22px 60px rgba(64,140,255,0.18), 0 16px 44px rgba(255,122,0,0.14);
}
.btn.primary:hover{ transform: translateY(-2px) scale(1.01); }
.btn.ghost{ background: rgba(255,255,255,0.08); }
.btnIcon{ display: inline-flex; }

/* Hero: FULL WIDTH feel via big surface, still aligned with inner container */
.heroWrap{
  width: 100%;
  margin-top: 16px;
  padding: 0;
}
.hero{
  width: min(1200px, 92vw);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1.25fr 0.85fr;
  gap: 18px;
  padding: 26px;
  border-radius: calc(var(--r) + 14px);
  border: 1px solid rgba(255,255,255,0.16);
  background:
    radial-gradient(800px 420px at 15% 20%, rgba(64,140,255,0.16), transparent 60%),
    radial-gradient(760px 420px at 90% 16%, rgba(255,122,0,0.14), transparent 60%),
    linear-gradient(180deg, rgba(10,16,40,0.78), rgba(7,10,18,0.62));
  box-shadow: var(--shadow1);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  position: relative;
  overflow: hidden;
}
.hero::after{
  content:"";
  position:absolute; inset:0;
  background:
    radial-gradient(900px 520px at 60% 60%, rgba(0,220,255,0.08), transparent 60%),
    radial-gradient(700px 520px at 35% 40%, rgba(255,196,0,0.06), transparent 60%);
  pointer-events:none;
  opacity: 0.9;
}

.heroLeft{ padding: 10px 10px 6px; position: relative; z-index: 2; }
.pill{
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255,255,255,0.10);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.84);
  font-size: 13px;
}

.h1{
  margin: 14px 0 10px;
  font-size: clamp(46px, 5vw, 72px);
  letter-spacing: -0.05em;
  line-height: 1.02;
}
.grad{
  background: linear-gradient(135deg, rgba(255,122,0,0.96), rgba(64,140,255,0.98));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.lead{
  margin: 0 0 14px;
  max-width: 68ch;
  color: rgba(255,255,255,0.76);
  line-height: 1.65;
}

.bullets{
  margin: 0;
  padding-left: 18px;
  color: rgba(255,255,255,0.72);
  line-height: 1.7;
}
.bullets li{ margin: 6px 0; }

.heroCtas{ display: flex; gap: 10px; margin-top: 16px; }
.miniNote{ margin-top: 14px; font-size: 13px; color: rgba(255,255,255,0.62); }

.card{
  position: relative;
  background: linear-gradient(180deg, var(--panelA), var(--panelB));
  border: 1px solid rgba(255,255,255,0.16);
  border-radius: var(--r);
  box-shadow: var(--shadow2);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  padding: 18px;
}
.card:hover{ transform: translateY(-2px); transition: 170ms ease; }

.heroRight{ padding: 18px; overflow: hidden; position: relative; z-index: 2; }
.profileTop{ display: flex; gap: 12px; align-items: center; }
.avatar{
  width: 54px; height: 54px;
  display: grid; place-items: center;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(64,140,255,0.28), rgba(255,122,0,0.18));
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.94);
  font-weight: 900;
}
.name{ font-weight: 950; letter-spacing: -0.02em; }
.role{ font-size: 13px; color: rgba(255,255,255,0.70); margin-top: 2px; }

.kpis{ margin-top: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.kpi{
  padding: 12px;
  border-radius: 16px;
  background: rgba(0,0,0,0.26);
  border: 1px solid rgba(255,255,255,0.10);
  box-shadow: var(--shadow3);
}
.k{ font-size: 12px; color: rgba(255,255,255,0.62); }
.v{ font-weight: 850; margin-top: 4px; }

.chips{ margin-top: 12px; display: flex; flex-wrap: wrap; gap: 8px; }
.chip{
  padding: 8px 10px;
  border-radius: 999px;
  font-size: 12px;
  background: rgba(255,255,255,0.08);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.80);
}

.cardGlow{
  position: absolute;
  inset: -120px -140px auto auto;
  width: 380px; height: 380px;
  border-radius: 50%;
  background:
    radial-gradient(circle at 30% 30%, rgba(64,140,255,0.24), transparent 60%),
    radial-gradient(circle at 70% 60%, rgba(255,122,0,0.18), transparent 60%),
    radial-gradient(circle at 55% 35%, rgba(0,220,255,0.12), transparent 60%);
  filter: blur(30px);
  opacity: 0.95;
  pointer-events: none;
}

/* Sections now full width, inner controls readability */
.section{ width: 100%; padding: 26px 0; }
.sectionHead{ width: min(1200px, 92vw); margin: 0 auto 14px; }
.eyebrow{ font-size: 13px; color: rgba(255,255,255,0.62); }
.h2{ margin: 6px 0 0; font-size: 26px; letter-spacing: -0.02em; }

.h3{ margin: 0 0 8px; font-size: 16px; letter-spacing: -0.01em; }

.grid2, .grid3{
  width: min(1200px, 92vw);
  margin: 0 auto;
  display: grid;
  gap: 14px;
}
.grid2{ grid-template-columns: 1fr 1fr; }
.grid3{ grid-template-columns: repeat(3, 1fr); }

.tags{ display: flex; flex-wrap: wrap; gap: 8px; margin-top: 12px; }
.tag{
  padding: 7px 10px;
  border-radius: 999px;
  font-size: 12px;
  background: rgba(255,255,255,0.08);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.80);
}

.subtleNote{
  width: min(1200px, 92vw);
  margin: 12px auto 0;
  color: rgba(255,255,255,0.60);
  font-size: 13px;
}

.contactCard{
  width: min(1200px, 92vw);
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 14px;
}
.contactRight{ display: flex; gap: 10px; flex-wrap: wrap; }

.footer{
  width: min(1200px, 92vw);
  margin: 10px auto 0;
  padding: 18px 0 0;
  color: rgba(255,255,255,0.64);
}
.footerInner{
  border-top: 1px solid rgba(255,255,255,0.10);
  padding-top: 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.linkBtn{ border: 0; background: transparent; color: rgba(255,255,255,0.74); cursor: pointer; }
.linkBtn:hover{ color: rgba(255,255,255,0.92); }

@media (max-width: 980px){
  .hero{ grid-template-columns: 1fr; }
  .navLinks{ display: none; }
  .grid3{ grid-template-columns: 1fr; }
  .grid2{ grid-template-columns: 1fr; }
}
CSS

# 2) Patch App.js to wrap hero in a full-width wrapper and add sheen layer
# (Safe text replace: if already exists, it won't break.)
perl -0777 -i -pe 's/<section id="home" className="hero">/<div className="heroWrap"><section id="home" className="hero"><div className="sheen" aria-hidden="true" \\/>/s' src/App.js
perl -0777 -i -pe 's/<\\/section>\\s*\\n\\s*\\n\\s*<Section id="work"/<\/section><\/div>\n\n        <Section id="work"/s' src/App.js

echo "Elegance + color + 100% width feel applied."
