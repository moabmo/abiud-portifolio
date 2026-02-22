#!/usr/bin/env bash
set -euo pipefail

# ---- Update App.js (generic wording, techie projects, svg icons) ----
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

function ProjectIcon({ kind }) {
  // Small inline SVGs (orange/blue) – techy, no images needed.
  const base = { width: 26, height: 26, viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg" };
  const stroke = "currentColor";
  if (kind === "channels") return (
    <svg {...base}>
      <path d="M7 12a3 3 0 1 0 0.01 0Z" stroke={stroke} strokeWidth="2" />
      <path d="M17 7a3 3 0 1 0 0.01 0Z" stroke={stroke} strokeWidth="2" />
      <path d="M17 17a3 3 0 1 0 0.01 0Z" stroke={stroke} strokeWidth="2" />
      <path d="M9.5 10.8 14.5 8.2M9.5 13.2 14.5 15.8" stroke={stroke} strokeWidth="2" strokeLinecap="round"/>
    </svg>
  );
  if (kind === "payments") return (
    <svg {...base}>
      <path d="M4 7h16v10H4V7Z" stroke={stroke} strokeWidth="2" />
      <path d="M4 10h16" stroke={stroke} strokeWidth="2" />
      <path d="M7 14h4" stroke={stroke} strokeWidth="2" strokeLinecap="round" />
    </svg>
  );
  if (kind === "sms") return (
    <svg {...base}>
      <path d="M4 6h16v10H7l-3 3V6Z" stroke={stroke} strokeWidth="2" strokeLinejoin="round"/>
      <path d="M7 10h10M7 13h6" stroke={stroke} strokeWidth="2" strokeLinecap="round"/>
    </svg>
  );
  if (kind === "metering") return (
    <svg {...base}>
      <path d="M12 4a8 8 0 1 0 0 16 8 8 0 0 0 0-16Z" stroke={stroke} strokeWidth="2"/>
      <path d="M12 12l4-3" stroke={stroke} strokeWidth="2" strokeLinecap="round"/>
      <path d="M8 14h8" stroke={stroke} strokeWidth="2" strokeLinecap="round"/>
    </svg>
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
        <div className="noise" />
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
            <div className="pill">Billing & Fintech • Revenue Systems • Integrations • Smart Metering</div>

            <h1 className="h1">
              Abiud Monyoro <span className="grad">Mongare</span>
            </h1>

            <p className="lead">
              Enterprise Systems Analyst & Full-Stack Builder focused on revenue-critical platforms—digital channels, secure integrations,
              production stability, and measurable operational impact.
            </p>

            <ul className="bullets">
              <li>Project leadership + technical delivery across web, mobile, USSD and chatbot channels</li>
              <li>Release management for Google Play & Apple App Store (rollouts, compliance, versioning)</li>
              <li>SQL/PLSQL incident remediation, automation scripts, and data integrity controls</li>
              <li>Real-time messaging services (gateway setup, high throughput, observability)</li>
              <li>Change governance (CAB): risk assessment, rollback readiness, audit-friendly deployments</li>
              <li>Training & mentoring: onboarding colleagues, UAT support, operational playbooks</li>
            </ul>

            <div className="heroCtas">
              <button className="btn primary" onClick={() => scrollTo("work")}>
                View Work <span className="btnIcon"><Icon name="arrow" /></span>
              </button>
              <button className="btn ghost" onClick={() => scrollTo("skills")}>
                Tech Stack
              </button>
            </div>

            <div className="miniNote">Built like production: clean, observable, and deployable.</div>
          </div>

          <Card className="heroRight">
            <div className="profileTop">
              <div className="avatar">AM</div>
              <div>
                <div className="name">Abiud Monyoro Mongare</div>
                <div className="role">Enterprise Systems Analyst • Digital Transformation • Full-Stack</div>
              </div>
            </div>

            <div className="kpis">
              <div className="kpi"><div className="k">Focus</div><div className="v">Revenue Platforms</div></div>
              <div className="kpi"><div className="k">Strength</div><div className="v">Production Stability</div></div>
              <div className="kpi"><div className="k">Delivery</div><div className="v">PM + Tech Lead</div></div>
              <div className="kpi"><div className="k">Governance</div><div className="v">Change Control</div></div>
            </div>

            <div className="chips">
              {["Oracle SQL/PLSQL","Java","REST APIs","Linux","Docker","Release Mgmt","Security"].map((t) => (
                <span className="chip" key={t}>{t}</span>
              ))}
            </div>

            <div className="cardGlow" aria-hidden="true" />
          </Card>
        </section>

        <Section id="work" eyebrow="Selected work" title="Projects (high-level)">
          <div className="grid2">
            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="channels" /></div>
                <h3 className="h3">Digital Self-Service Channels</h3>
              </div>
              <p>End-to-end transformation across web + mobile + USSD + chatbot, with secure APIs and a clean release rhythm.</p>
              <div className="tags">
                <span className="tag">Web</span><span className="tag">Mobile</span><span className="tag">USSD</span><span className="tag">Chatbot</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="payments" /></div>
                <h3 className="h3">Revenue & Transaction Workflows</h3>
              </div>
              <p>Stability, controls, and automation for revenue-critical operations—UAT support, change control, and production readiness.</p>
              <div className="tags">
                <span className="tag">Governance</span><span className="tag">UAT</span><span className="tag">Automation</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="sms" /></div>
                <h3 className="h3">Real-Time Messaging Service</h3>
              </div>
              <p>Built internal messaging service + gateway setup for reliable, near-instant customer communication at scale.</p>
              <div className="tags">
                <span className="tag">Gateway</span><span className="tag">Throughput</span><span className="tag">Monitoring</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="metering" /></div>
                <h3 className="h3">Smart Metering Support & Automation</h3>
              </div>
              <p>Analysis + incident resolution with targeted SQL scripts, plus operational improvements like OCR support and leakage controls.</p>
              <div className="tags">
                <span className="tag">Analytics</span><span className="tag">OCR</span><span className="tag">Controls</span>
              </div>
            </Card>
          </div>

          <div className="subtleNote">
            For sensitive implementations, I share detailed case studies on request.
          </div>
        </Section>

        <Section id="skills" eyebrow="Technical competencies" title="Stack & strengths">
          <div className="grid3">
            <Card><h3 className="h3">Languages</h3><p>Oracle SQL, PL/SQL, Java, JavaScript, Python, Bash</p></Card>
            <Card><h3 className="h3">Backend & APIs</h3><p>REST APIs, Spring Boot, JWT/Auth, secure integrations, validation</p></Card>
            <Card><h3 className="h3">Platforms</h3><p>Revenue systems, smart metering platforms, self-service channels, messaging</p></Card>
            <Card><h3 className="h3">Mobile Releases</h3><p>Google Play Console, Apple App Store, rollout strategy, compliance</p></Card>
            <Card><h3 className="h3">Ops</h3><p>Linux (Rocky), Docker, Git, CI/CD support, production readiness</p></Card>
            <Card><h3 className="h3">Governance & Security</h3><p>Change control, audit controls, leakage prevention, tamper-proof controls</p></Card>
          </div>
        </Section>

        <Section id="impact" eyebrow="Impact lens" title="Why I’m valuable in fintech-scale environments">
          <div className="grid2">
            <Card><h3 className="h3">High-value transactions</h3><p>Operate with the discipline required for large-scale, revenue-critical and audit-sensitive platforms.</p></Card>
            <Card><h3 className="h3">Production stability</h3><p>Fix incidents fast, automate the repetitive, reduce risk, and keep systems stable under pressure.</p></Card>
            <Card><h3 className="h3">Delivery leadership</h3><p>PM + Tech Lead mindset: plan, build, review, release, and train teams for ownership.</p></Card>
            <Card><h3 className="h3">Operational acceleration</h3><p>Improve workflows with automation, OCR support, controls, and clean integration patterns.</p></Card>
          </div>
        </Section>

        <Section id="contact" eyebrow="Let’s talk" title="Contact">
          <Card className="contactCard">
            <div className="contactLeft">
              <h3 className="h3">Open to: enterprise platforms, fintech systems, integrations, and high-impact delivery roles.</h3>
              <p>Want the detailed version? I can share case studies privately.</p>
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
            <div>© {new Date().getFullYear()} Monyoro • engineered with production discipline</div>
            <button className="linkBtn" onClick={() => scrollTo("home")}>Back to top</button>
          </div>
        </footer>
      </main>
    </div>
  );
}
JS

# ---- Update styles.css (orange + blue + deep blue, dev-touch fonts, techy feel) ----
cat > src/styles.css <<'CSS'
:root{
  --bg0:#070A12;
  --bg1:#071028;        /* deep blue */
  --bg2:#0A1636;        /* deeper blue */
  --panelA: rgba(255,255,255,0.10);
  --panelB: rgba(255,255,255,0.06);
  --stroke: rgba(255,255,255,0.14);
  --text: rgba(255,255,255,0.92);
  --muted: rgba(255,255,255,0.70);

  --blue: rgba(47,107,255,0.95);
  --blue2: rgba(31,92,255,0.85);
  --orange: rgba(255,122,0,0.95);
  --orange2: rgba(255,170,64,0.70);

  --shadow1: 0 22px 80px rgba(0,0,0,0.45);
  --shadow2: 0 14px 45px rgba(0,0,0,0.30);
  --r: 22px;
}

*{ box-sizing: border-box; }
html, body{ height: 100%; }
body{
  margin: 0;
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Helvetica Neue", sans-serif;
  color: var(--text);
  background:
    radial-gradient(1100px 720px at 12% 10%, rgba(47,107,255,0.22), transparent 60%),
    radial-gradient(1050px 720px at 90% 14%, rgba(255,122,0,0.16), transparent 62%),
    radial-gradient(900px 650px at 55% 100%, rgba(31,92,255,0.12), transparent 60%),
    linear-gradient(180deg, var(--bg2), var(--bg0));
}

a{ color: inherit; text-decoration: none; }
button{ font: inherit; }
::selection{ background: rgba(255,122,0,0.22); }

.app{ min-height: 100vh; position: relative; }
.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.blob{ position: absolute; filter: blur(44px); opacity: .95; }
.b1{ width: 520px; height: 520px; left: -140px; top: -170px; background: rgba(47,107,255,0.28); border-radius: 50%; }
.b2{ width: 560px; height: 560px; right: -180px; top: -160px; background: rgba(255,122,0,0.20); border-radius: 50%; }
.grid{
  position: absolute; inset: 0;
  background-image: linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 64px 64px;
  mask-image: radial-gradient(ellipse at 50% 15%, black 0%, transparent 62%);
  opacity: 0.12;
}
.noise{
  position: absolute; inset: 0;
  background-image:
    radial-gradient(circle at 20% 30%, rgba(255,255,255,0.06), transparent 50%),
    radial-gradient(circle at 70% 40%, rgba(255,255,255,0.05), transparent 55%),
    radial-gradient(circle at 40% 80%, rgba(255,255,255,0.04), transparent 60%);
  opacity: .18;
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

.brand{
  display: inline-flex; align-items: center; gap: 10px;
  border: 0; background: transparent; color: var(--text);
  cursor: pointer;
}
.brandMark{
  width: 34px; height: 34px;
  border-radius: 12px;
  display: grid; place-items: center;
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #070A12;
  font-weight: 900;
  box-shadow: 0 18px 40px rgba(47,107,255,0.18), 0 14px 34px rgba(255,122,0,0.10);
}
.brandText{
  font-weight: 800;
  letter-spacing: -0.01em;
  opacity: .95;
}

.navLinks{ display: flex; gap: 6px; margin-left: auto; }
.navLink{
  padding: 10px 12px;
  border-radius: 999px;
  border: 1px solid transparent;
  background: transparent;
  color: rgba(255,255,255,0.78);
  cursor: pointer;
}
.navLink:hover{
  background: rgba(255,255,255,0.06);
  border-color: rgba(255,255,255,0.12);
  color: rgba(255,255,255,0.92);
}
.navLink.active{
  background: rgba(255,255,255,0.08);
  border-color: rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.92);
}

.navCtas{ display: flex; align-items: center; gap: 10px; }
.iconBtn{
  width: 38px; height: 38px;
  display: grid; place-items: center;
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.86);
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
  color: #070A12;
  border: 1px solid rgba(255,255,255,0.18);
  box-shadow: 0 22px 55px rgba(47,107,255,0.18), 0 14px 40px rgba(255,122,0,0.12);
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
  background: linear-gradient(180deg, rgba(10,16,40,0.76), rgba(7,10,18,0.62));
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

.h1{
  margin: 14px 0 10px;
  font-size: clamp(44px, 5vw, 68px);
  letter-spacing: -0.04em;
  line-height: 1.03;
}
.grad{
  background: linear-gradient(135deg, rgba(255,122,0,0.95), rgba(47,107,255,0.95));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.lead{
  margin: 0 0 14px;
  max-width: 66ch;
  color: rgba(255,255,255,0.74);
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
.card:hover{ transform: translateY(-2px); transition: 160ms ease; }

.cardTop{
  display:flex;
  align-items:center;
  gap:10px;
  margin-bottom: 8px;
}
.pIcon{
  width: 38px;
  height: 38px;
  border-radius: 14px;
  display:grid;
  place-items:center;
  background: linear-gradient(135deg, rgba(47,107,255,0.18), rgba(255,122,0,0.12));
  border: 1px solid rgba(255,255,255,0.12);
  color: rgba(255,255,255,0.92);
}

.heroRight{ padding: 18px; overflow: hidden; }
.profileTop{ display: flex; gap: 12px; align-items: center; }
.avatar{
  width: 52px; height: 52px;
  display: grid; place-items: center;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(47,107,255,0.30), rgba(255,122,0,0.16));
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.92);
  font-weight: 800;
}
.name{ font-weight: 900; letter-spacing: -0.01em; }
.role{ font-size: 13px; color: rgba(255,255,255,0.66); margin-top: 2px; }

.kpis{ margin-top: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.kpi{ padding: 12px; border-radius: 16px; background: rgba(0,0,0,0.28); border: 1px solid rgba(255,255,255,0.10); }
.k{ font-size: 12px; color: rgba(255,255,255,0.62); }
.v{ font-weight: 800; margin-top: 4px; }

.chips{ margin-top: 12px; display: flex; flex-wrap: wrap; gap: 8px; }
.chip{ padding: 8px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.78); }

.cardGlow{
  position: absolute;
  inset: -80px -120px auto auto;
  width: 320px; height: 320px;
  border-radius: 50%;
  background: radial-gradient(circle at 30% 30%, rgba(47,107,255,0.26), transparent 60%),
              radial-gradient(circle at 70% 60%, rgba(255,122,0,0.18), transparent 60%);
  filter: blur(28px);
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

.subtleNote{
  margin-top: 12px;
  color: rgba(255,255,255,0.58);
  font-size: 13px;
}

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

echo "Techie palette + generic copy + project SVG icons applied."
