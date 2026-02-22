#!/usr/bin/env bash
set -euo pipefail

cd /Users/monyoro/Projects/personal/psnl/abiud-portifolio

BK=".backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BK"
cp -R src "$BK/src" 2>/dev/null || true
cp -R public "$BK/public" 2>/dev/null || true
echo "Backup saved to: $BK"

rm -rf src public
mkdir -p src public

# ---- public ----
cat > public/index.html <<'HTML'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="theme-color" content="#070A12" />
    <meta name="description" content="Abiud Monyoro Mongare — Enterprise Systems Analyst & Digital Transformation Lead." />
    <link rel="icon" type="image/svg+xml" href="%PUBLIC_URL%/favicon.svg" />
    <link rel="apple-touch-icon" href="%PUBLIC_URL%/favicon.svg" />
    <title>Monyoro — Portfolio</title>
  </head>
  <body>
    <noscript>You need JavaScript enabled to run this site.</noscript>
    <div id="root"></div>
  </body>
</html>
HTML

cat > public/favicon.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#1F5CFF"/>
      <stop offset="0.6" stop-color="#4B7BFF"/>
      <stop offset="1" stop-color="#FFD100"/>
    </linearGradient>
    <filter id="glow" x="-30%" y="-30%" width="160%" height="160%">
      <feGaussianBlur stdDeviation="10" result="b"/>
      <feMerge>
        <feMergeNode in="b"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  <rect x="18" y="18" width="220" height="220" rx="56" fill="#070A12"/>
  <rect x="18" y="18" width="220" height="220" rx="56" fill="url(#g)" opacity="0.14"/>
  <path filter="url(#glow)" d="M64 186V70h26l38 64 38-64h26v116h-26v-67l-30 49h-16l-30-49v67H64z" fill="url(#g)"/>
  <rect x="18" y="18" width="220" height="220" rx="56" fill="none" stroke="rgba(255,255,255,0.14)" stroke-width="2"/>
</svg>
SVG

# ---- src ----
cat > src/index.js <<'JS'
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./styles.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
JS

cat > src/App.js <<'JS'
import React, { useEffect, useMemo, useState } from "react";

const LINKS = {
  linkedin: "https://www.linkedin.com/",
  github: "https://github.com/",
  email: "mailto:monyoro@proton.me",
};

const SECTIONS = [
  { id: "home", label: "Home" },
  { id: "work", label: "Work" },
  { id: "skills", label: "Competencies" },
  { id: "impact", label: "Impact" },
  { id: "contact", label: "Contact" },
];

const cx = (...a) => a.filter(Boolean).join(" ");

function Icon({ name }) {
  const common = { width: 18, height: 18, viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg" };
  if (name === "arrow") return (
    <svg {...common}><path d="M5 12h12" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/><path d="M13 6l6 6-6 6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/></svg>
  );
  if (name === "mail") return (
    <svg {...common}><path d="M4 6h16v12H4V6Z" stroke="currentColor" strokeWidth="2" /><path d="m4 7 8 6 8-6" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/></svg>
  );
  if (name === "in") return (
    <svg {...common}><path d="M6 9v12" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/><path d="M6 5.5h.01" stroke="currentColor" strokeWidth="4" strokeLinecap="round"/><path d="M10 21V9h4v2c.7-1.2 2-2.2 4-2.2 3 0 4 2 4 5V21" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/></svg>
  );
  if (name === "gh") return (
    <svg {...common}><path d="M12 2a10 10 0 0 0-3.2 19.5c.5.1.7-.2.7-.5v-1.7c-3 .7-3.6-1.3-3.6-1.3-.5-1.2-1.1-1.5-1.1-1.5-.9-.6.1-.6.1-.6 1 .1 1.6 1.1 1.6 1.1.9 1.6 2.4 1.1 3 .8.1-.7.4-1.1.7-1.4-2.4-.3-4.9-1.2-4.9-5.3 0-1.2.4-2.2 1.1-3-.1-.3-.5-1.4.1-2.9 0 0 .9-.3 3 .1a10.4 10.4 0 0 1 5.4 0c2.1-.4 3-.1 3-.1.6 1.5.2 2.6.1 2.9.7.8 1.1 1.8 1.1 3 0 4.1-2.5 5-4.9 5.3.4.3.7 1 .7 2v3c0 .3.2.6.7.5A10 10 0 0 0 12 2Z" stroke="currentColor" strokeWidth="1.6" strokeLinejoin="round"/></svg>
  );
  return null;
}

function Card({ className, children }) {
  return <div className={cx("card", className)}>{children}</div>;
}

function Section({ id, eyebrow, title, children }) {
  return (
    <section id={id} className="section">
      <div className="sectionHead">
        {eyebrow && <div className="eyebrow">{eyebrow}</div>}
        <h2 className="h2">{title}</h2>
      </div>
      {children}
    </section>
  );
}

function useActiveSection(ids) {
  const [active, setActive] = useState(ids[0] || "home");
  useEffect(() => {
    const els = ids.map((id) => document.getElementById(id)).filter(Boolean);
    const obs = new IntersectionObserver(
      (entries) => {
        const v = entries.filter((e) => e.isIntersecting).sort((a, b) => b.intersectionRatio - a.intersectionRatio);
        if (v[0]) setActive(v[0].target.id);
      },
      { rootMargin: "-45% 0px -45% 0px", threshold: [0.15, 0.25, 0.35] }
    );
    els.forEach((el) => obs.observe(el));
    return () => obs.disconnect();
  }, [ids]);
  return active;
}

export default function App() {
  const ids = useMemo(() => SECTIONS.map(s => s.id), []);
  const active = useActiveSection(ids);
  const scrollTo = (id) => document.getElementById(id)?.scrollIntoView({ behavior: "smooth", block: "start" });

  return (
    <div className="app">
      <div className="bg" aria-hidden="true">
        <div className="blob b1" />
        <div className="blob b2" />
        <div className="grid" />
      </div>

      <header className="nav">
        <div className="navInner">
          <button className="brand" onClick={() => scrollTo("home")} aria-label="Go home">
            <span className="brandMark">M</span>
            <span className="brandText">Monyoro</span>
          </button>

          <nav className="navLinks" aria-label="Primary navigation">
            {SECTIONS.map((s) => (
              <button key={s.id} className={cx("navLink", active === s.id && "active")} onClick={() => scrollTo(s.id)}>
                {s.label}
              </button>
            ))}
          </nav>

          <div className="navCtas">
            <a className="iconBtn" href={LINKS.linkedin} target="_blank" rel="noreferrer" aria-label="LinkedIn"><Icon name="in" /></a>
            <a className="iconBtn" href={LINKS.github} target="_blank" rel="noreferrer" aria-label="GitHub"><Icon name="gh" /></a>
            <a className="btn primary" href={LINKS.email}><Icon name="mail" /> <span>Email</span></a>
          </div>
        </div>
      </header>

      <main className="main">
        <section id="home" className="hero">
          <div className="heroLeft">
            <div className="pill">Billing & Fintech • Revenue Systems • Smart Metering</div>
            <h1 className="h1">
              Abiud Monyoro <span className="grad">Mongare</span>
            </h1>
            <p className="lead">
              Enterprise Systems Analyst & Digital Transformation Lead working in revenue-critical environments—core billing, customer self-service, smart metering and real-time communication.
            </p>

            <ul className="bullets">
              <li>PM + Acting Tech Lead for Self-Service transformation (Portal, Apps, USSD, Chatbot)</li>
              <li>Release management for Google Play & Apple App Store (rollouts, compliance, versioning)</li>
              <li>Oracle SQL/PLSQL remediation for incidents, data integrity, and automation</li>
              <li>Real-time SMS gateway architecture (Kannel nodes) for transactional messaging</li>
              <li>CAB member: governance, risk assessment, deployment readiness</li>
            </ul>

            <div className="heroCtas">
              <button className="btn primary" onClick={() => scrollTo("work")}>
                View Work <span className="btnIcon"><Icon name="arrow" /></span>
              </button>
              <button className="btn ghost" onClick={() => scrollTo("impact")}>
                Impact
              </button>
            </div>

            <div className="miniNote">Trusted systems. High availability. Strong governance. Built for scale.</div>
          </div>

          <Card className="heroRight">
            <div className="profileTop">
              <div className="avatar">AM</div>
              <div>
                <div className="name">Abiud Monyoro Mongare</div>
                <div className="role">Enterprise Systems Analyst • Digital Transformation Lead</div>
              </div>
            </div>

            <div className="kpis">
              <div className="kpi"><div className="k">Focus</div><div className="v">Revenue Systems</div></div>
              <div className="kpi"><div className="k">Strength</div><div className="v">Production Stability</div></div>
              <div className="kpi"><div className="k">Delivery</div><div className="v">PM + Tech Lead</div></div>
              <div className="kpi"><div className="k">Governance</div><div className="v">CAB</div></div>
            </div>

            <div className="chips">
              {["Oracle SQL/PLSQL","Java","APIs","Linux","Docker","Release Mgmt","Smart Metering"].map((t) => (
                <span className="chip" key={t}>{t}</span>
              ))}
            </div>

            <div className="cardGlow" aria-hidden="true" />
          </Card>
        </section>

        <Section id="work" eyebrow="What I deliver" title="Work highlights">
          <div className="grid2">
            <Card><h3 className="h3">Self-Service Transformation</h3><p>Owned delivery as PM + Acting Tech Lead—revamped digital channels and integrated secure APIs.</p><div className="tags"><span className="tag">Portal</span><span className="tag">Apps</span><span className="tag">USSD</span><span className="tag">Chatbot</span></div></Card>
            <Card><h3 className="h3">Core Billing (InCMS)</h3><p>Vendor coordination, UAT, and controlled SQL remediation for incidents and billing anomalies.</p><div className="tags"><span className="tag">Oracle</span><span className="tag">UAT</span><span className="tag">Prod</span></div></Card>
            <Card><h3 className="h3">Real-Time SMS Infrastructure</h3><p>Built internal SMS service and Kannel gateway architecture for instant transactional messaging.</p><div className="tags"><span className="tag">Kannel</span><span className="tag">Messaging</span><span className="tag">Reliability</span></div></Card>
            <Card><h3 className="h3">Revenue Collection & OCR</h3><p>Enhanced revenue collection workflows and implemented OCR meter reading support for accuracy.</p><div className="tags"><span className="tag">Work Orders</span><span className="tag">OCR</span><span className="tag">Dashboards</span></div></Card>
          </div>
        </Section>

        <Section id="skills" eyebrow="Technical competencies" title="Tools, platforms, strengths">
          <div className="grid3">
            <Card><h3 className="h3">Programming</h3><p>Oracle SQL, PL/SQL, Java, JavaScript, Python, Bash</p></Card>
            <Card><h3 className="h3">Backend & APIs</h3><p>REST APIs, Spring Boot, JWT/Auth, secure integrations, validation</p></Card>
            <Card><h3 className="h3">Platforms</h3><p>Core Billing (InCMS), Smart Meter/AMI, Self-Service, SMS Gateway</p></Card>
            <Card><h3 className="h3">Mobile Releases</h3><p>Google Play Console, Apple App Store, rollout strategy, compliance</p></Card>
            <Card><h3 className="h3">Ops & DevOps</h3><p>Linux (Rocky), Docker, Git, CI/CD support, production readiness</p></Card>
            <Card><h3 className="h3">Governance & Security</h3><p>CAB vetting, audit controls, leakage prevention, tamper-proof seals</p></Card>
          </div>
        </Section>

        <Section id="impact" eyebrow="Selected impact" title="Where my work moves the needle">
          <div className="grid2">
            <Card><h3 className="h3">Billing & Fintech scale</h3><p>Operate within enterprise revenue environments that demand governance, stability, and auditability.</p></Card>
            <Card><h3 className="h3">Production reliability</h3><p>Remediation, automation and release discipline to protect revenue-critical data integrity.</p></Card>
            <Card><h3 className="h3">Customer communication</h3><p>Real-time SMS delivery to improve customer experience and operational responsiveness.</p></Card>
            <Card><h3 className="h3">Revenue assurance</h3><p>Smart metering support, OCR automation and leakage controls to strengthen accountability.</p></Card>
          </div>
        </Section>

        <Section id="contact" eyebrow="Let’s talk" title="Contact">
          <Card className="contactCard">
            <div className="contactLeft">
              <h3 className="h3">Open to leadership roles, enterprise architecture, and high-impact systems work.</h3>
              <p>For sensitive projects, details are shared on request.</p>
            </div>
            <div className="contactRight">
              <a className="btn primary" href={LINKS.email}><Icon name="mail" /> Email me</a>
              <a className="btn ghost" href={LINKS.linkedin} target="_blank" rel="noreferrer">LinkedIn</a>
              <a className="btn ghost" href={LINKS.github} target="_blank" rel="noreferrer">GitHub</a>
            </div>
          </Card>
        </Section>

        <footer className="footer">
          <div className="footerInner">
            <div>© {new Date().getFullYear()} Monyoro • Built for enterprise-grade work</div>
            <button className="linkBtn" onClick={() => scrollTo("home")}>Back to top</button>
          </div>
        </footer>
      </main>
    </div>
  );
}
JS

cat > src/styles.css <<'CSS'
:root{
  --bg0:#070A12;
  --bg1:#0B1020;
  --panelA: rgba(255,255,255,0.10);
  --panelB: rgba(255,255,255,0.06);
  --stroke: rgba(255,255,255,0.14);
  --text: rgba(255,255,255,0.92);
  --muted: rgba(255,255,255,0.70);
  --blue: rgba(31,92,255,0.95);
  --yellow: rgba(255,209,0,0.90);
  --shadow1: 0 22px 80px rgba(0,0,0,0.42);
  --shadow2: 0 14px 45px rgba(0,0,0,0.28);
  --r: 22px;
}

*{ box-sizing: border-box; }
html, body{ height: 100%; }
body{
  margin: 0;
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Helvetica Neue", sans-serif;
  color: var(--text);
  background:
    radial-gradient(1200px 760px at 12% 10%, rgba(31,92,255,0.22), transparent 60%),
    radial-gradient(950px 680px at 88% 12%, rgba(255,209,0,0.16), transparent 60%),
    radial-gradient(900px 650px at 50% 100%, rgba(31,92,255,0.12), transparent 60%),
    linear-gradient(180deg, var(--bg1), var(--bg0));
}

a{ color: inherit; text-decoration: none; }
button{ font: inherit; }
::selection{ background: rgba(255,209,0,0.22); }

.app{ min-height: 100vh; position: relative; }
.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.blob{ position: absolute; filter: blur(44px); opacity: .9; }
.b1{ width: 520px; height: 520px; left: -140px; top: -170px; background: rgba(31,92,255,0.26); border-radius: 50%; }
.b2{ width: 560px; height: 560px; right: -180px; top: -160px; background: rgba(255,209,0,0.18); border-radius: 50%; }
.grid{
  position: absolute; inset: 0;
  background-image: linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 64px 64px;
  mask-image: radial-gradient(ellipse at 50% 15%, black 0%, transparent 62%);
  opacity: 0.12;
}

.nav{ position: sticky; top: 0; z-index: 50; padding: 18px 18px 0; }
.navInner{
  max-width: 1120px;
  margin: 0 auto;
  padding: 14px 16px;
  border-radius: 999px;
  border: 1px solid var(--stroke);
  background: rgba(10,14,26,0.62);
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
  background: linear-gradient(135deg, rgba(31,92,255,0.95), rgba(255,209,0,0.85));
  color: #070A12;
  font-weight: 900;
  box-shadow: 0 18px 40px rgba(31,92,255,0.18), 0 14px 34px rgba(255,209,0,0.10);
}
.brandText{ font-weight: 700; opacity: .92; }

.navLinks{ display: flex; gap: 6px; margin-left: auto; }
.navLink{
  padding: 10px 12px;
  border-radius: 999px;
  border: 1px solid transparent;
  background: transparent;
  color: rgba(255,255,255,0.78);
  cursor: pointer;
}
.navLink:hover{ background: rgba(255,255,255,0.06); border-color: rgba(255,255,255,0.12); color: rgba(255,255,255,0.92); }
.navLink.active{ background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.14); color: rgba(255,255,255,0.92); }

.navCtas{ display: flex; align-items: center; gap: 10px; }
.iconBtn{
  width: 38px; height: 38px;
  display: grid; place-items: center;
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.86);
}
.iconBtn:hover{ background: rgba(255,255,255,0.09); transform: translateY(-1px); transition: 160ms ease; }

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
  background: linear-gradient(135deg, var(--blue), var(--yellow));
  color: #070A12;
  border: 1px solid rgba(255,255,255,0.18);
  box-shadow: 0 22px 55px rgba(31,92,255,0.18), 0 14px 40px rgba(255,209,0,0.12);
}
.btn.primary:hover{ transform: translateY(-2px) scale(1.01); }
.btn.ghost{ background: rgba(255,255,255,0.08); }
.btnIcon{ display: inline-flex; }

.main{ position: relative; z-index: 1; padding: 26px 18px 60px; }

.hero{
  max-width: 1120px;
  margin: 16px auto 26px;
  display: grid;
  grid-template-columns: 1.25fr 0.85fr;
  gap: 18px;
  padding: 22px;
  border-radius: calc(var(--r) + 10px);
  border: 1px solid var(--stroke);
  background: linear-gradient(180deg, rgba(12,16,30,0.78), rgba(8,10,18,0.62));
  box-shadow: var(--shadow1);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
}

.heroLeft{ padding: 10px 10px 6px; }
.pill{
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255,255,255,0.10);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.82);
  font-size: 13px;
}

.h1{ margin: 14px 0 10px; font-size: clamp(44px, 5vw, 68px); letter-spacing: -0.03em; line-height: 1.04; }
.grad{
  background: linear-gradient(135deg, rgba(31,92,255,0.95), rgba(255,209,0,0.90));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.lead{ margin: 0 0 14px; max-width: 62ch; color: rgba(255,255,255,0.74); line-height: 1.65; }

.bullets{ margin: 0; padding-left: 18px; color: rgba(255,255,255,0.72); line-height: 1.7; }
.bullets li{ margin: 6px 0; }

.heroCtas{ display: flex; gap: 10px; margin-top: 16px; }
.miniNote{ margin-top: 14px; font-size: 13px; color: rgba(255,255,255,0.60); }

.card{
  position: relative;
  background: linear-gradient(180deg, var(--panelA), var(--panelB));
  border: 1px solid var(--stroke);
  border-radius: var(--r);
  box-shadow: var(--shadow2);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  padding: 18px;
}

.heroRight{ padding: 18px; overflow: hidden; }
.profileTop{ display: flex; gap: 12px; align-items: center; }
.avatar{
  width: 52px; height: 52px;
  display: grid; place-items: center;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(31,92,255,0.35), rgba(255,209,0,0.18));
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.92);
  font-weight: 800;
}
.name{ font-weight: 800; }
.role{ font-size: 13px; color: rgba(255,255,255,0.66); margin-top: 2px; }

.kpis{ margin-top: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.kpi{ padding: 12px; border-radius: 16px; background: rgba(0,0,0,0.28); border: 1px solid rgba(255,255,255,0.10); }
.k{ font-size: 12px; color: rgba(255,255,255,0.62); }
.v{ font-weight: 750; margin-top: 4px; }

.chips{ margin-top: 12px; display: flex; flex-wrap: wrap; gap: 8px; }
.chip{ padding: 8px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.78); }

.cardGlow{
  position: absolute;
  inset: -80px -120px auto auto;
  width: 320px; height: 320px;
  border-radius: 50%;
  background: radial-gradient(circle at 30% 30%, rgba(31,92,255,0.25), transparent 60%),
              radial-gradient(circle at 70% 60%, rgba(255,209,0,0.18), transparent 60%);
  filter: blur(26px);
  opacity: 0.9;
  pointer-events: none;
}

.section{ max-width: 1120px; margin: 0 auto; padding: 26px 0; }
.sectionHead{ margin: 0 0 14px; }
.eyebrow{ font-size: 13px; color: rgba(255,255,255,0.60); }
.h2{ margin: 6px 0 0; font-size: 26px; letter-spacing: -0.02em; }
.h3{ margin: 0 0 8px; font-size: 16px; letter-spacing: -0.01em; }
.tags{ display: flex; flex-wrap: wrap; gap: 8px; margin-top: 12px; }
.tag{ padding: 7px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.78); }

.grid2{ display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
.grid3{ display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; }

.contactCard{ display: flex; align-items: center; justify-content: space-between; gap: 14px; }
.contactRight{ display: flex; gap: 10px; flex-wrap: wrap; }

.footer{ max-width: 1120px; margin: 10px auto 0; padding: 18px 0 0; color: rgba(255,255,255,0.62); }
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

echo "Overhaul complete."
