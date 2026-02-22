#!/usr/bin/env bash
set -euo pipefail

# ---------- App.js (more sections + more all-round copy) ----------
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
  { id: "capabilities", label: "Capabilities" },
  { id: "experience", label: "Experience" },
  { id: "skills", label: "Stack" },
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
  if (name === "bolt") return (
    <svg {...common}><path d="M13 2 4 14h7l-1 8 9-12h-7l1-8Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/></svg>
  );
  if (name === "shield") return (
    <svg {...common}><path d="M12 2 20 6v7c0 5-3.5 9-8 9s-8-4-8-9V6l8-4Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/></svg>
  );
  if (name === "users") return (
    <svg {...common}><path d="M16 11a4 4 0 1 0-8 0" stroke="currentColor" strokeWidth="2"/><path d="M3 22c.8-4.5 4.1-7 9-7s8.2 2.5 9 7" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/></svg>
  );
  if (name === "ship") return (
    <svg {...common}><path d="M4 18h16l-2-7H6l-2 7Z" stroke="currentColor" strokeWidth="2"/><path d="M12 2v9" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/><path d="M9 6h6" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/></svg>
  );
  return null;
}

function ProjectIcon({ kind }) {
  const base = { width: 26, height: 26, viewBox: "0 0 24 24", fill: "none", xmlns: "http://www.w3.org/2000/svg" };
  const s = "currentColor";
  if (kind === "channels") return (
    <svg {...base}>
      <path d="M7 12a3 3 0 1 0 0.01 0Z" stroke={s} strokeWidth="2" />
      <path d="M17 7a3 3 0 1 0 0.01 0Z" stroke={s} strokeWidth="2" />
      <path d="M17 17a3 3 0 1 0 0.01 0Z" stroke={s} strokeWidth="2" />
      <path d="M9.5 10.8 14.5 8.2M9.5 13.2 14.5 15.8" stroke={s} strokeWidth="2" strokeLinecap="round"/>
    </svg>
  );
  if (kind === "payments") return (
    <svg {...base}>
      <path d="M4 7h16v10H4V7Z" stroke={s} strokeWidth="2" />
      <path d="M4 10h16" stroke={s} strokeWidth="2" />
      <path d="M7 14h4" stroke={s} strokeWidth="2" strokeLinecap="round" />
    </svg>
  );
  if (kind === "sms") return (
    <svg {...base}>
      <path d="M4 6h16v10H7l-3 3V6Z" stroke={s} strokeWidth="2" strokeLinejoin="round"/>
      <path d="M7 10h10M7 13h6" stroke={s} strokeWidth="2" strokeLinecap="round"/>
    </svg>
  );
  if (kind === "metering") return (
    <svg {...base}>
      <path d="M12 4a8 8 0 1 0 0 16 8 8 0 0 0 0-16Z" stroke={s} strokeWidth="2"/>
      <path d="M12 12l4-3" stroke={s} strokeWidth="2" strokeLinecap="round"/>
      <path d="M8 14h8" stroke={s} strokeWidth="2" strokeLinecap="round"/>
    </svg>
  );
  return null;
}

function Card({ className, children }) {
  return <div className={cx("card", className)}>{children}</div>;
}

function Section({ id, eyebrow, title, subtitle, children }) {
  return (
    <section id={id} className="section">
      <div className="sectionHead">
        {eyebrow && <div className="eyebrow">{eyebrow}</div>}
        <h2 className="h2">{title}</h2>
        {subtitle && <div className="subhead">{subtitle}</div>}
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
        <div className="blob b3" />
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
        <div className="heroWrap">
          <section id="home" className="hero">
            <div className="sheen" aria-hidden="true" />

            <div className="heroLeft">
              <div className="pill">Fintech-scale delivery • Integrations • Mobile releases • Governance • Automation</div>

              <h1 className="h1">
                Abiud Monyoro <span className="grad">Mongare</span>
              </h1>

              <p className="lead">
                All-round technology professional across product delivery, analysis, engineering, integrations, release management,
                governance, and training—focused on reliability, speed, and real business outcomes.
              </p>

              <ul className="bullets">
                <li>Led end-to-end transformations across web, mobile, USSD and chatbot experiences</li>
                <li>Release management for Google Play & Apple App Store (rollouts, compliance, versioning)</li>
                <li>Secure API integrations and data workflows across sensitive stakeholders</li>
                <li>Automation scripts + SQL/PLSQL remediation for incidents, controls, and data integrity</li>
                <li>Real-time messaging services (gateway setup, high throughput, observability)</li>
                <li>Change governance (CAB): risk, rollout readiness, audit-friendly deployments</li>
                <li>Training & mentoring: onboarding colleagues, UAT support, clear operational playbooks</li>
              </ul>

              <div className="heroCtas">
                <button className="btn primary" onClick={() => scrollTo("work")}>
                  View Work <span className="btnIcon"><Icon name="arrow" /></span>
                </button>
                <button className="btn ghost" onClick={() => scrollTo("capabilities")}>
                  What I Do
                </button>
              </div>

              <div className="miniNote">Confident in delivery: plan → build → test → deploy → train → support.</div>
            </div>

            <Card className="heroRight">
              <div className="profileTop">
                <div className="avatar">AM</div>
                <div>
                  <div className="name">Abiud Monyoro Mongare</div>
                  <div className="role">Product Delivery • Engineering • Integrations • Governance</div>
                </div>
              </div>

              <div className="kpis">
                <div className="kpi"><div className="k">Strength</div><div className="v">End-to-End Ownership</div></div>
                <div className="kpi"><div className="k">Focus</div><div className="v">Reliability + Speed</div></div>
                <div className="kpi"><div className="k">Mode</div><div className="v">PM + Tech Lead</div></div>
                <div className="kpi"><div className="k">Mindset</div><div className="v">Risk-Aware Delivery</div></div>
              </div>

              <div className="chips">
                {["Oracle SQL/PLSQL","Java","REST APIs","Linux","Docker","Release Mgmt","Security","UAT"].map((t) => (
                  <span className="chip" key={t}>{t}</span>
                ))}
              </div>

              <div className="cardGlow" aria-hidden="true" />
            </Card>
          </section>
        </div>

        <Section
          id="work"
          eyebrow="Selected work"
          title="Projects"
          subtitle="High-level summaries — detailed case studies available on request."
        >
          <div className="grid2">
            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="channels" /></div>
                <h3 className="h3">Digital Self-Service Transformation</h3>
              </div>
              <p>Revamped user journeys across web + mobile + USSD + chatbot, supported by secure APIs and clean release rhythm.</p>
              <div className="tags">
                <span className="tag">Product</span><span className="tag">Tech Lead</span><span className="tag">Mobile</span><span className="tag">UX</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="payments" /></div>
                <h3 className="h3">Revenue & Transaction Workflows</h3>
              </div>
              <p>Stability, controls, and automation for revenue-critical operations—governance, UAT, rollout readiness, and support.</p>
              <div className="tags">
                <span className="tag">Governance</span><span className="tag">Controls</span><span className="tag">UAT</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="sms" /></div>
                <h3 className="h3">Real-Time Messaging Service</h3>
              </div>
              <p>Built internal messaging service + gateway setup for reliable, near-instant communication with monitoring and resiliency.</p>
              <div className="tags">
                <span className="tag">Gateway</span><span className="tag">Observability</span><span className="tag">Scale</span>
              </div>
            </Card>

            <Card>
              <div className="cardTop">
                <div className="pIcon"><ProjectIcon kind="metering" /></div>
                <h3 className="h3">Smart Metering Support & Controls</h3>
              </div>
              <p>Analysis + incident resolution via targeted scripts; operational enhancements like OCR support and leakage prevention controls.</p>
              <div className="tags">
                <span className="tag">Automation</span><span className="tag">OCR</span><span className="tag">Security</span>
              </div>
            </Card>
          </div>

          <div className="subtleNote">
            I keep public summaries clean; I can share deeper details privately where required.
          </div>
        </Section>

        <Section
          id="capabilities"
          eyebrow="What I deliver"
          title="Capabilities"
          subtitle="Not just development — I cover the full delivery lifecycle."
        >
          <div className="grid3">
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="ship" /></span><h3 className="h3">Product Delivery</h3></div>
              <p>Scopes, plans, coordinates stakeholders, runs UAT, and ships features with clear outcomes.</p>
            </Card>
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="bolt" /></span><h3 className="h3">Engineering</h3></div>
              <p>APIs, automation, data workflows, reliability improvements, and hands-on fixes under pressure.</p>
            </Card>
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="shield" /></span><h3 className="h3">Governance & Risk</h3></div>
              <p>Change readiness, rollback planning, audit controls, data protection, and safe deployments.</p>
            </Card>
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="users" /></span><h3 className="h3">Training & Enablement</h3></div>
              <p>Documentation, playbooks, demos, onboarding, and knowledge transfer to build ownership.</p>
            </Card>
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="bolt" /></span><h3 className="h3">Ops Support</h3></div>
              <p>Incident response, root-cause analysis, automation of repetitive work, and performance tuning.</p>
            </Card>
            <Card className="feature">
              <div className="featTop"><span className="featIcon"><Icon name="shield" /></span><h3 className="h3">Secure Integrations</h3></div>
              <p>Integrations with sensitive stakeholders using good security patterns and strong validation.</p>
            </Card>
          </div>
        </Section>

        <Section
          id="experience"
          eyebrow="How I work"
          title="Execution style"
          subtitle="A simple framework that keeps delivery clean and predictable."
        >
          <div className="grid2">
            <Card>
              <h3 className="h3">Operating model</h3>
              <ul className="miniList">
                <li><b>Discover:</b> clarify the problem, define success, map risks</li>
                <li><b>Deliver:</b> build + integrate, test, UAT support, ship with control</li>
                <li><b>Stabilize:</b> monitor, fix fast, document, train, automate repeat work</li>
              </ul>
            </Card>
            <Card>
              <h3 className="h3">What teams get from me</h3>
              <ul className="miniList">
                <li>Clear communication + strong follow-through</li>
                <li>Fast troubleshooting and structured root-cause fixes</li>
                <li>Safe releases with change readiness and rollback thinking</li>
                <li>Training that makes people independent (not dependent)</li>
              </ul>
            </Card>
          </div>
        </Section>

        <Section id="skills" eyebrow="Technical competencies" title="Tools & stack">
          <div className="grid3">
            <Card><h3 className="h3">Languages</h3><p>Oracle SQL, PL/SQL, Java, JavaScript, Python, Bash</p></Card>
            <Card><h3 className="h3">Backend & APIs</h3><p>REST APIs, Spring Boot, JWT/Auth, secure integrations, validation</p></Card>
            <Card><h3 className="h3">Delivery</h3><p>UAT facilitation, release planning, rollout strategy, stakeholder communication</p></Card>
            <Card><h3 className="h3">Platforms</h3><p>Revenue systems, smart metering platforms, messaging, self-service channels</p></Card>
            <Card><h3 className="h3">Ops</h3><p>Linux, Docker, Git, CI/CD support, monitoring and incident response</p></Card>
            <Card><h3 className="h3">Controls</h3><p>Change control, audit controls, leakage prevention, tamper-proof controls</p></Card>
          </div>
        </Section>

        <Section id="impact" eyebrow="Impact lens" title="Why I’m valuable in fintech-scale environments">
          <div className="grid2">
            <Card><h3 className="h3">High-value operations</h3><p>Comfortable in audit-sensitive, high-throughput environments where reliability matters.</p></Card>
            <Card><h3 className="h3">Speed with control</h3><p>Move fast without breaking things—good governance, testing, and release discipline.</p></Card>
            <Card><h3 className="h3">Business-first thinking</h3><p>Translate requirements into outcomes: customer experience, revenue protection, efficiency.</p></Card>
            <Card><h3 className="h3">Team multiplier</h3><p>Training, documentation, and automation that raises the entire team’s output.</p></Card>
          </div>
        </Section>

        <Section id="contact" eyebrow="Let’s talk" title="Contact" subtitle="Want the detailed version? I can share case studies privately.">
          <Card className="contactCard">
            <div className="contactLeft">
              <h3 className="h3">Open to roles around delivery leadership, integrations, platform engineering, and fintech-scale systems.</h3>
              <p>Send a note and tell me what you’re building.</p>
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
            <div>© {new Date().getFullYear()} Monyoro • product • delivery • engineering • governance</div>
            <button className="linkBtn" onClick={() => scrollTo("home")}>Back to top</button>
          </div>
        </footer>
      </main>
    </div>
  );
}
JS

# ---------- styles.css (more color + more elegance + premium hover) ----------
cat > src/styles.css <<'CSS'
:root{
  --bg0:#050814;
  --bg1:#071a3a;
  --bg2:#0b2a55;

  --blue: rgba(64,140,255,0.95);
  --blue2: rgba(42,106,255,0.90);
  --cyan: rgba(0,220,255,0.65);
  --orange: rgba(255,122,0,0.95);
  --amber: rgba(255,196,0,0.70);
  --magenta: rgba(255,64,180,0.45);
  --lime: rgba(120,255,170,0.22);

  --panelA: rgba(255,255,255,0.11);
  --panelB: rgba(255,255,255,0.06);
  --stroke: rgba(255,255,255,0.16);

  --text: rgba(255,255,255,0.92);
  --muted: rgba(255,255,255,0.72);

  --shadow1: 0 30px 95px rgba(0,0,0,0.52);
  --shadow2: 0 18px 55px rgba(0,0,0,0.34);
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
    radial-gradient(950px 700px at 92% 14%, rgba(255,122,0,0.20), transparent 62%),
    radial-gradient(900px 700px at 55% 100%, rgba(0,220,255,0.12), transparent 60%),
    radial-gradient(800px 520px at 65% 35%, rgba(255,64,180,0.10), transparent 55%),
    radial-gradient(700px 520px at 30% 70%, rgba(120,255,170,0.07), transparent 60%),
    linear-gradient(180deg, var(--bg2), var(--bg0));
}

a{ color: inherit; text-decoration: none; }
button{ font: inherit; }
::selection{ background: rgba(255,122,0,0.25); }

.app{ min-height: 100vh; position: relative; }

/* Background */
.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.blob{ position: absolute; filter: blur(56px); opacity: .95; transform: translate3d(0,0,0); }
.b1{ width: 660px; height: 660px; left: -220px; top: -240px; background: rgba(64,140,255,0.26); border-radius: 50%; }
.b2{ width: 720px; height: 720px; right: -260px; top: -240px; background: rgba(255,122,0,0.24); border-radius: 50%; }
.b3{ width: 520px; height: 520px; left: 35%; top: 55%; background: rgba(0,220,255,0.10); border-radius: 50%; }

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

/* Elegant sheen */
.sheen{
  position: absolute;
  inset: -20%;
  background: linear-gradient(115deg, transparent 35%, rgba(255,255,255,0.10) 45%, transparent 55%);
  transform: translateX(-40%);
  animation: sweep 10s ease-in-out infinite;
  opacity: 0.25;
  filter: blur(2px);
  pointer-events: none;
}
@keyframes sweep{
  0%{ transform: translateX(-55%); }
  50%{ transform: translateX(10%); }
  100%{ transform: translateX(-55%); }
}

/* Full width */
.main{ position: relative; z-index: 1; padding: 26px 0 70px; }

.nav{ position: sticky; top: 0; z-index: 50; padding: 18px 0 0; }
.navInner{
  width: min(1240px, 92vw);
  margin: 0 auto;
  padding: 14px 16px;
  border-radius: 999px;
  border: 1px solid var(--stroke);
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
  box-shadow: 0 20px 46px rgba(64,140,255,0.18), 0 16px 40px rgba(255,122,0,0.12);
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
.navLink:hover{ background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.14); color: rgba(255,255,255,0.96); }
.navLink.active{ background: rgba(255,255,255,0.11); border-color: rgba(255,255,255,0.16); color: rgba(255,255,255,0.98); }

.navCtas{ display: flex; align-items: center; gap: 10px; }
.iconBtn{
  width: 38px; height: 38px;
  display: grid; place-items: center;
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.90);
}
.iconBtn:hover{ background: rgba(255,255,255,0.11); transform: translateY(-1px); transition: 160ms ease; }

.btn{
  display: inline-flex; align-items: center; justify-content: center; gap: 10px;
  padding: 10px 14px;
  border-radius: 14px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.92);
  cursor: pointer;
  transition: transform 170ms ease, background 170ms ease, box-shadow 170ms ease;
}
.btn:hover{ background: rgba(255,255,255,0.11); transform: translateY(-1px); }
.btn.primary{
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #050814;
  border: 1px solid rgba(255,255,255,0.18);
  box-shadow: 0 24px 66px rgba(64,140,255,0.18), 0 18px 46px rgba(255,122,0,0.14);
}
.btn.primary:hover{ transform: translateY(-2px) scale(1.01); }
.btn.ghost{ background: rgba(255,255,255,0.08); }
.btnIcon{ display: inline-flex; }

/* Hero */
.heroWrap{ width: 100%; margin-top: 16px; }
.hero{
  width: min(1240px, 92vw);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1.25fr 0.85fr;
  gap: 18px;
  padding: 26px;
  border-radius: calc(var(--r) + 14px);
  border: 1px solid var(--stroke);
  background:
    radial-gradient(900px 520px at 14% 18%, rgba(64,140,255,0.18), transparent 60%),
    radial-gradient(900px 520px at 90% 14%, rgba(255,122,0,0.16), transparent 60%),
    radial-gradient(800px 520px at 50% 90%, rgba(0,220,255,0.10), transparent 62%),
    linear-gradient(180deg, rgba(10,16,40,0.78), rgba(7,10,18,0.62));
  box-shadow: var(--shadow1);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  position: relative;
  overflow: hidden;
}

.heroLeft{ padding: 10px 10px 6px; position: relative; z-index: 2; }
.pill{
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255,255,255,0.10);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.86);
  font-size: 13px;
}
.h1{ margin: 14px 0 10px; font-size: clamp(46px, 5vw, 72px); letter-spacing: -0.05em; line-height: 1.02; }
.grad{
  background: linear-gradient(135deg, rgba(255,122,0,0.96), rgba(64,140,255,0.98), rgba(0,220,255,0.75));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.lead{ margin: 0 0 14px; max-width: 70ch; color: rgba(255,255,255,0.78); line-height: 1.65; }
.bullets{ margin: 0; padding-left: 18px; color: rgba(255,255,255,0.74); line-height: 1.7; }
.bullets li{ margin: 6px 0; }
.heroCtas{ display: flex; gap: 10px; margin-top: 16px; }
.miniNote{ margin-top: 14px; font-size: 13px; color: rgba(255,255,255,0.64); }

/* Cards */
.card{
  position: relative;
  background: linear-gradient(180deg, var(--panelA), var(--panelB));
  border: 1px solid var(--stroke);
  border-radius: var(--r);
  box-shadow: var(--shadow2);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  padding: 18px;
  transition: transform 170ms ease, box-shadow 170ms ease, border-color 170ms ease;
}
.card:hover{
  transform: translateY(-3px);
  box-shadow: 0 26px 70px rgba(0,0,0,0.36);
  border-color: rgba(255,255,255,0.22);
}
.card::after{
  content:"";
  position:absolute; inset:0;
  border-radius: inherit;
  pointer-events:none;
  opacity: 0;
  transition: opacity 170ms ease;
  background:
    radial-gradient(800px 320px at 10% 10%, rgba(64,140,255,0.12), transparent 60%),
    radial-gradient(800px 320px at 90% 10%, rgba(255,122,0,0.10), transparent 60%);
}
.card:hover::after{ opacity: 1; }

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
.role{ font-size: 13px; color: rgba(255,255,255,0.72); margin-top: 2px; }

.kpis{ margin-top: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.kpi{ padding: 12px; border-radius: 16px; background: rgba(0,0,0,0.26); border: 1px solid rgba(255,255,255,0.10); box-shadow: var(--shadow3); }
.k{ font-size: 12px; color: rgba(255,255,255,0.62); }
.v{ font-weight: 850; margin-top: 4px; }

.chips{ margin-top: 12px; display: flex; flex-wrap: wrap; gap: 8px; }
.chip{ padding: 8px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.82); }

.cardGlow{
  position: absolute;
  inset: -120px -140px auto auto;
  width: 380px; height: 380px;
  border-radius: 50%;
  background:
    radial-gradient(circle at 30% 30%, rgba(64,140,255,0.22), transparent 60%),
    radial-gradient(circle at 70% 60%, rgba(255,122,0,0.18), transparent 60%),
    radial-gradient(circle at 55% 35%, rgba(0,220,255,0.12), transparent 60%);
  filter: blur(30px);
  opacity: 0.95;
  pointer-events: none;
}

/* Sections full width but readable */
.section{ width: 100%; padding: 28px 0; }
.sectionHead{ width: min(1240px, 92vw); margin: 0 auto 14px; }
.eyebrow{ font-size: 13px; color: rgba(255,255,255,0.62); }
.h2{ margin: 6px 0 0; font-size: 26px; letter-spacing: -0.02em; }
.subhead{ margin-top: 6px; color: rgba(255,255,255,0.68); font-size: 14px; line-height: 1.55; }

.h3{ margin: 0 0 8px; font-size: 16px; letter-spacing: -0.01em; }
p{ color: rgba(255,255,255,0.78); line-height: 1.65; margin: 0; }

.grid2, .grid3{ width: min(1240px, 92vw); margin: 0 auto; display: grid; gap: 14px; }
.grid2{ grid-template-columns: 1fr 1fr; }
.grid3{ grid-template-columns: repeat(3, 1fr); }

.cardTop{ display:flex; align-items:center; gap:10px; margin-bottom: 8px; }
.pIcon{
  width: 38px; height: 38px;
  border-radius: 14px;
  display:grid; place-items:center;
  background: linear-gradient(135deg, rgba(64,140,255,0.18), rgba(255,122,0,0.12));
  border: 1px solid rgba(255,255,255,0.12);
  color: rgba(255,255,255,0.92);
}

.tags{ display: flex; flex-wrap: wrap; gap: 8px; margin-top: 12px; }
.tag{ padding: 7px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.82); }

.subtleNote{ width: min(1240px, 92vw); margin: 12px auto 0; color: rgba(255,255,255,0.62); font-size: 13px; }

.feature .featTop{ display:flex; align-items:center; gap:10px; margin-bottom: 6px; }
.featIcon{
  width: 40px; height: 40px;
  border-radius: 16px;
  display:grid; place-items:center;
  border: 1px solid rgba(255,255,255,0.14);
  background: radial-gradient(120% 120% at 20% 20%, rgba(64,140,255,0.18), rgba(255,122,0,0.10));
  box-shadow: 0 18px 45px rgba(0,0,0,0.18);
}

.miniList{ margin: 0; padding-left: 18px; color: rgba(255,255,255,0.74); line-height: 1.7; }
.miniList li{ margin: 6px 0; }
.miniList b{ color: rgba(255,255,255,0.92); }

.contactCard{ width: min(1240px, 92vw); margin: 0 auto; display: flex; align-items: center; justify-content: space-between; gap: 14px; }
.contactRight{ display: flex; gap: 10px; flex-wrap: wrap; }

.footer{ width: min(1240px, 92vw); margin: 10px auto 0; padding: 18px 0 0; color: rgba(255,255,255,0.64); }
.footerInner{ border-top: 1px solid rgba(255,255,255,0.10); padding-top: 16px; display: flex; align-items: center; justify-content: space-between; }
.linkBtn{ border: 0; background: transparent; color: rgba(255,255,255,0.74); cursor: pointer; }
.linkBtn:hover{ color: rgba(255,255,255,0.92); }

@media (max-width: 980px){
  .hero{ grid-template-columns: 1fr; }
  .navLinks{ display: none; }
  .grid3{ grid-template-columns: 1fr; }
  .grid2{ grid-template-columns: 1fr; }
}
CSS

echo "✅ Upgraded: more content + more elegant + more colorful + full width."
