#!/usr/bin/env bash
set -euo pipefail

# ---------------- App.js ----------------
cat > src/App.js <<'JS'
import React, { useEffect, useMemo, useRef, useState } from "react";

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
  if (name === "spark") return (
    <svg {...common}><path d="M12 2l1.2 5.2L18 9l-4.8 1.8L12 16l-1.2-5.2L6 9l4.8-1.8L12 2Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/></svg>
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
      <div className="container">
        <div className="sectionHead">
          {eyebrow && <div className="eyebrow">{eyebrow}</div>}
          <h2 className="h2">{title}</h2>
          {subtitle && <div className="subhead">{subtitle}</div>}
        </div>
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

  // subtle cursor glow (no libs)
  const glowRef = useRef(null);
  useEffect(() => {
    const el = glowRef.current;
    if (!el) return;
    const onMove = (e) => {
      const x = e.clientX / window.innerWidth;
      const y = e.clientY / window.innerHeight;
      el.style.setProperty("--mx", `${x * 100}%`);
      el.style.setProperty("--my", `${y * 100}%`);
    };
    window.addEventListener("pointermove", onMove, { passive: true });
    return () => window.removeEventListener("pointermove", onMove);
  }, []);

  return (
    <div className="app" ref={glowRef}>
      <div className="bg" aria-hidden="true">
        <div className="blob b1" />
        <div className="blob b2" />
        <div className="blob b3" />
        <div className="grid" />
        <div className="noise" />
        <div className="cursorGlow" />
      </div>

      <header className="nav">
        <div className="container">
          <div className="navInner">
            <button className="brand" onClick={() => scrollTo("home")} aria-label="Go home">
              <span className="brandMark">M</span>
              <span className="brandText">Monyoro Mongare</span>
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
        </div>
      </header>

      <main className="main">
        {/* FULL BLEED hero */}
        <section id="home" className="heroBleed">
          <div className="heroSheen" aria-hidden="true" />
          <div className="container heroGrid">
            <div className="heroLeft">
              <div className="pill">Integrations • Mobile releases • Governance • Automation • Delivery leadership</div>

              <h1 className="h1">
                <span className="grad">Monyoro</span> <span className="grad2">Mongare</span>
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

              <div className="miniNote">Plan → build → test → deploy → train → support.</div>
            </div>

            <Card className="heroRight">
              <div className="profileTop">
                <div className="avatar">MM</div>
                <div>
                  <div className="name">Monyoro Mongare</div>
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

              <div className="microLine">
                <span className="pulseDot" aria-hidden="true" />
                <span>Availability: open to delivery + platform roles</span>
                <span className="microSpacer" />
                <span className="microBadge"><Icon name="spark" /> Tech-forward</span>
              </div>

              <div className="cardGlow" aria-hidden="true" />
            </Card>
          </div>
        </section>

        <Section
          id="work"
          eyebrow="Selected work"
          title="Projects"
          subtitle="High-level summaries — detailed case studies available on request."
        >
          <div className="container">
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
                <p>Built messaging service + gateway setup for reliable, near-instant communication with monitoring and resiliency.</p>
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
              Public summaries are intentionally general; deeper details available privately where needed.
            </div>
          </div>
        </Section>

        <Section
          id="capabilities"
          eyebrow="What I deliver"
          title="Capabilities"
          subtitle="Full delivery lifecycle: define → build → ship → enable."
        >
          <div className="container">
            <div className="grid3">
              <Card className="feature"><div className="featTop"><span className="featIcon">01</span><h3 className="h3">Delivery leadership</h3></div><p>Scope, planning, stakeholder coordination, UAT, and measurable outcomes.</p></Card>
              <Card className="feature"><div className="featTop"><span className="featIcon">02</span><h3 className="h3">Engineering & integration</h3></div><p>APIs, automations, data workflows, and secure integrations across systems.</p></Card>
              <Card className="feature"><div className="featTop"><span className="featIcon">03</span><h3 className="h3">Release management</h3></div><p>Versioning, app-store releases, rollout strategies, compliance, and rollback readiness.</p></Card>
              <Card className="feature"><div className="featTop"><span className="featIcon">04</span><h3 className="h3">Governance & risk</h3></div><p>Change control, audit-friendly deployments, controls, and data protection.</p></Card>
              <Card className="feature"><div className="featTop"><span className="featIcon">05</span><h3 className="h3">Operations support</h3></div><p>Incident response, root cause fixes, performance tuning, and observability.</p></Card>
              <Card className="feature"><div className="featTop"><span className="featIcon">06</span><h3 className="h3">Training & enablement</h3></div><p>Playbooks, demos, onboarding, and knowledge transfer that builds independence.</p></Card>
            </div>
          </div>
        </Section>

        <Section id="experience" eyebrow="How I work" title="Execution style" subtitle="A clean framework for predictable delivery.">
          <div className="container">
            <div className="grid2">
              <Card>
                <h3 className="h3">Operating model</h3>
                <ul className="miniList">
                  <li><b>Discover:</b> clarify problem, define success, map risks</li>
                  <li><b>Deliver:</b> build + integrate, test, support UAT, ship with control</li>
                  <li><b>Stabilize:</b> monitor, fix fast, document, train, automate repeat work</li>
                </ul>
              </Card>
              <Card>
                <h3 className="h3">What teams get</h3>
                <ul className="miniList">
                  <li>Clear communication + follow-through</li>
                  <li>Fast troubleshooting + structured fixes</li>
                  <li>Safe releases with rollback thinking</li>
                  <li>Training that makes people independent</li>
                </ul>
              </Card>
            </div>
          </div>
        </Section>

        <Section id="skills" eyebrow="Technical competencies" title="Tools & stack">
          <div className="container">
            <div className="grid3">
              <Card><h3 className="h3">Languages</h3><p>Oracle SQL, PL/SQL, Java, JavaScript, Python, Bash</p></Card>
              <Card><h3 className="h3">Backend & APIs</h3><p>REST APIs, Spring Boot, JWT/Auth, secure integrations, validation</p></Card>
              <Card><h3 className="h3">Delivery</h3><p>UAT facilitation, release planning, rollout strategy, stakeholder comms</p></Card>
              <Card><h3 className="h3">Platforms</h3><p>Revenue systems, smart metering platforms, messaging, self-service channels</p></Card>
              <Card><h3 className="h3">Ops</h3><p>Linux, Docker, Git, CI/CD support, monitoring and incident response</p></Card>
              <Card><h3 className="h3">Controls</h3><p>Change control, audit controls, leakage prevention, tamper-proof controls</p></Card>
            </div>
          </div>
        </Section>

        <Section id="impact" eyebrow="Impact lens" title="Why I fit fintech-scale environments">
          <div className="container">
            <div className="grid2">
              <Card><h3 className="h3">High-value operations</h3><p>Comfortable in audit-sensitive, high-throughput environments where reliability matters.</p></Card>
              <Card><h3 className="h3">Speed with control</h3><p>Move fast without breaking things—good governance, testing, and rollout discipline.</p></Card>
              <Card><h3 className="h3">Business-first thinking</h3><p>Translate requirements into outcomes: customer experience, revenue protection, efficiency.</p></Card>
              <Card><h3 className="h3">Team multiplier</h3><p>Training, documentation, and automation that raises the entire team’s output.</p></Card>
            </div>
          </div>
        </Section>

        <Section id="contact" eyebrow="Let’s talk" title="Contact" subtitle="Want the detailed version? I can share case studies privately.">
          <div className="container">
            <Card className="contactCard">
              <div className="contactLeft">
                <h3 className="h3">Open to roles around delivery leadership, integrations, and platform systems.</h3>
                <p>Send a note and tell me what you’re building.</p>
              </div>
              <div className="contactRight">
                <a className="btn primary" href={LINKS.email}><Icon name="mail" /> Email</a>
                <a className="btn ghost" href={LINKS.linkedin} target="_blank" rel="noreferrer">LinkedIn</a>
                <a className="btn ghost" href={LINKS.github} target="_blank" rel="noreferrer">GitHub</a>
              </div>
            </Card>

            <footer className="footer">
              <div className="footerInner">
                <div>© {new Date().getFullYear()} Monyoro Mongare</div>
                <button className="linkBtn" onClick={() => scrollTo("home")}>Back to top</button>
              </div>
            </footer>
          </div>
        </Section>
      </main>
    </div>
  );
}
JS

# ---------------- styles.css ----------------
cat > src/styles.css <<'CSS'
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600&display=swap");

:root{
  --bg0:#04060f;
  --bg1:#061a3a;
  --bg2:#0a2a5f;

  --blue: rgba(64,140,255,0.98);
  --blue2: rgba(42,106,255,0.92);
  --cyan: rgba(0,220,255,0.70);
  --orange: rgba(255,122,0,0.96);
  --amber: rgba(255,196,0,0.72);
  --magenta: rgba(255,64,180,0.42);

  --panelA: rgba(255,255,255,0.10);
  --panelB: rgba(255,255,255,0.06);
  --stroke: rgba(255,255,255,0.16);

  --text: rgba(255,255,255,0.93);
  --muted: rgba(255,255,255,0.73);

  --shadow1: 0 34px 105px rgba(0,0,0,0.56);
  --shadow2: 0 18px 55px rgba(0,0,0,0.34);
  --shadow3: 0 10px 26px rgba(0,0,0,0.24);
  --r: 22px;

  --container: minmax(16px, 1fr);
  --content: min(1240px, 100% - 48px);
  --ease: cubic-bezier(.2,.8,.2,1);
}

*{ box-sizing: border-box; }
html, body{ height: 100%; }
html{ scroll-behavior: smooth; }
body{
  margin: 0;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Arial, "Helvetica Neue", sans-serif;
  color: var(--text);
  background:
    radial-gradient(1200px 760px at 10% 10%, rgba(64,140,255,0.24), transparent 60%),
    radial-gradient(980px 740px at 92% 14%, rgba(255,122,0,0.20), transparent 62%),
    radial-gradient(900px 700px at 55% 100%, rgba(0,220,255,0.12), transparent 60%),
    radial-gradient(800px 520px at 65% 35%, rgba(255,64,180,0.10), transparent 55%),
    linear-gradient(180deg, var(--bg2), var(--bg0));
}

a{ color: inherit; text-decoration: none; }
button{ font: inherit; }
::selection{ background: rgba(255,122,0,0.25); }

.container{
  display: grid;
  grid-template-columns: var(--container) var(--content) var(--container);
}
.container > *{ grid-column: 2; }

.app{ min-height: 100vh; position: relative; }

/* Background */
.bg{ position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.blob{ position: absolute; filter: blur(60px); opacity: .95; transform: translate3d(0,0,0); }
.b1{ width: 700px; height: 700px; left: -260px; top: -280px; background: rgba(64,140,255,0.26); border-radius: 50%; }
.b2{ width: 760px; height: 760px; right: -300px; top: -280px; background: rgba(255,122,0,0.22); border-radius: 50%; }
.b3{ width: 520px; height: 520px; left: 38%; top: 58%; background: rgba(0,220,255,0.09); border-radius: 50%; }

.grid{
  position: absolute; inset: 0;
  background-image:
    linear-gradient(rgba(255,255,255,0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.06) 1px, transparent 1px);
  background-size: 76px 76px;
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

/* Cursor glow (very subtle) */
.cursorGlow{
  position: absolute; inset: 0;
  background: radial-gradient(700px 450px at var(--mx, 50%) var(--my, 30%),
    rgba(255,122,0,0.12),
    rgba(64,140,255,0.08),
    transparent 60%);
  opacity: .9;
  filter: blur(2px);
}

/* Sticky nav */
.main{ position: relative; z-index: 1; padding: 20px 0 70px; }
.nav{ position: sticky; top: 0; z-index: 50; padding: 14px 0 0; }
.navInner{
  padding: 14px 16px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(8,12,24,0.58);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  box-shadow: var(--shadow2);
  display: flex;
  align-items: center;
  gap: 14px;
  transform: translateZ(0);
}

.brand{ display: inline-flex; align-items: center; gap: 10px; border: 0; background: transparent; color: var(--text); cursor: pointer; }
.brandMark{
  width: 34px; height: 34px;
  border-radius: 12px;
  display: grid; place-items: center;
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #04060f;
  font-weight: 950;
  box-shadow: 0 22px 52px rgba(64,140,255,0.18), 0 18px 46px rgba(255,122,0,0.12);
}
.brandText{ font-weight: 800; letter-spacing: -0.02em; opacity: .98; }

.navLinks{ display: flex; gap: 6px; margin-left: auto; }
.navLink{
  padding: 10px 12px;
  border-radius: 999px;
  border: 1px solid transparent;
  background: transparent;
  color: rgba(255,255,255,0.82);
  cursor: pointer;
  transition: background 170ms var(--ease), transform 170ms var(--ease), border-color 170ms var(--ease);
}
.navLink:hover{ background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.14); transform: translateY(-1px); }
.navLink.active{ background: rgba(255,255,255,0.11); border-color: rgba(255,255,255,0.18); }

.navCtas{ display: flex; align-items: center; gap: 10px; }
.iconBtn{
  width: 38px; height: 38px;
  display: grid; place-items: center;
  border-radius: 12px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.92);
  transition: transform 170ms var(--ease), background 170ms var(--ease);
}
.iconBtn:hover{ background: rgba(255,255,255,0.11); transform: translateY(-1px); }

.btn{
  display: inline-flex; align-items: center; justify-content: center; gap: 10px;
  padding: 10px 14px;
  border-radius: 14px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.06);
  color: rgba(255,255,255,0.93);
  cursor: pointer;
  transition: transform 220ms var(--ease), background 220ms var(--ease), box-shadow 220ms var(--ease);
}
.btn:hover{ background: rgba(255,255,255,0.11); transform: translateY(-1px); }
.btn.primary{
  background: linear-gradient(135deg, var(--blue), var(--orange));
  color: #04060f;
  border: 1px solid rgba(255,255,255,0.18);
  box-shadow: 0 26px 70px rgba(64,140,255,0.18), 0 18px 48px rgba(255,122,0,0.14);
}
.btn.primary:hover{ transform: translateY(-2px) scale(1.01); }
.btn.ghost{ background: rgba(255,255,255,0.08); }
.btnIcon{ display: inline-flex; }

/* FULL-BLEED hero */
.heroBleed{
  width: 100%;
  margin-top: 14px;
  border-top: 1px solid rgba(255,255,255,0.08);
  border-bottom: 1px solid rgba(255,255,255,0.08);
  background:
    radial-gradient(1100px 640px at 12% 18%, rgba(64,140,255,0.18), transparent 60%),
    radial-gradient(1000px 640px at 90% 12%, rgba(255,122,0,0.16), transparent 62%),
    radial-gradient(900px 620px at 50% 92%, rgba(0,220,255,0.10), transparent 62%),
    linear-gradient(180deg, rgba(10,16,40,0.70), rgba(5,8,18,0.48));
  box-shadow: var(--shadow1);
  position: relative;
  overflow: hidden;
  animation: fadeUp 600ms var(--ease) both;
}
.heroSheen{
  position: absolute;
  inset: -20%;
  background: linear-gradient(115deg, transparent 35%, rgba(255,255,255,0.10) 45%, transparent 55%);
  transform: translateX(-40%);
  animation: sweep 10.5s var(--ease) infinite;
  opacity: 0.22;
  filter: blur(2px);
  pointer-events: none;
}
@keyframes sweep{
  0%{ transform: translateX(-55%); }
  50%{ transform: translateX(10%); }
  100%{ transform: translateX(-55%); }
}
@keyframes fadeUp{
  from{ opacity: 0; transform: translateY(10px); }
  to{ opacity: 1; transform: translateY(0); }
}

.heroGrid{
  padding: 34px 0 30px;
  display: grid;
  grid-template-columns: 1.22fr 0.78fr;
  gap: 18px;
}

.pill{
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255,255,255,0.10);
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.88);
  font-size: 13px;
}

.h1{
  margin: 14px 0 10px;
  font-size: clamp(50px, 5.3vw, 78px);
  letter-spacing: -0.055em;
  line-height: 1.02;
}
.grad{
  background: linear-gradient(135deg, rgba(255,122,0,0.98), rgba(64,140,255,0.98));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.grad2{
  background: linear-gradient(135deg, rgba(0,220,255,0.80), rgba(64,140,255,0.98), rgba(255,196,0,0.70));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.lead{
  margin: 0 0 14px;
  max-width: 75ch;
  color: rgba(255,255,255,0.80);
  line-height: 1.72;
}
.bullets{
  margin: 0;
  padding-left: 18px;
  color: rgba(255,255,255,0.76);
  line-height: 1.75;
}
.bullets li{ margin: 7px 0; }
.heroCtas{ display: flex; gap: 10px; margin-top: 16px; }
.miniNote{
  margin-top: 14px;
  font-size: 13px;
  color: rgba(255,255,255,0.66);
  font-family: "JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", monospace;
}

/* Cards */
.card{
  position: relative;
  background: linear-gradient(180deg, rgba(255,255,255,0.10), rgba(255,255,255,0.06));
  border: 1px solid rgba(255,255,255,0.16);
  border-radius: 22px;
  box-shadow: var(--shadow2);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  padding: 18px;
  transition: transform 240ms var(--ease), box-shadow 240ms var(--ease), border-color 240ms var(--ease);
  transform: translateZ(0);
}
.card:hover{
  transform: translateY(-4px);
  box-shadow: 0 30px 78px rgba(0,0,0,0.38);
  border-color: rgba(255,255,255,0.22);
}
.card::after{
  content:"";
  position:absolute; inset:0;
  border-radius: inherit;
  pointer-events:none;
  opacity: 0;
  transition: opacity 240ms var(--ease);
  background:
    radial-gradient(900px 360px at 12% 10%, rgba(64,140,255,0.14), transparent 60%),
    radial-gradient(900px 360px at 92% 10%, rgba(255,122,0,0.12), transparent 60%);
}
.card:hover::after{ opacity: 1; }

.profileTop{ display: flex; gap: 12px; align-items: center; }
.avatar{
  width: 54px; height: 54px;
  display: grid; place-items: center;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(64,140,255,0.26), rgba(255,122,0,0.16));
  border: 1px solid rgba(255,255,255,0.14);
  color: rgba(255,255,255,0.94);
  font-weight: 900;
}
.name{ font-weight: 850; letter-spacing: -0.02em; }
.role{ font-size: 13px; color: rgba(255,255,255,0.72); margin-top: 2px; }

.kpis{ margin-top: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.kpi{ padding: 12px; border-radius: 16px; background: rgba(0,0,0,0.24); border: 1px solid rgba(255,255,255,0.10); box-shadow: var(--shadow3); }
.k{ font-size: 12px; color: rgba(255,255,255,0.62); }
.v{ font-weight: 850; margin-top: 4px; }

.chips{ margin-top: 12px; display: flex; flex-wrap: wrap; gap: 8px; }
.chip{ padding: 8px 10px; border-radius: 999px; font-size: 12px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.14); color: rgba(255,255,255,0.82); }

.microLine{
  margin-top: 14px;
  display: flex;
  align-items: center;
  gap: 10px;
  padding-top: 12px;
  border-top: 1px solid rgba(255,255,255,0.10);
  color: rgba(255,255,255,0.70);
  font-size: 13px;
  font-family: "JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", monospace;
}
.pulseDot{
  width: 8px; height: 8px;
  border-radius: 999px;
  background: rgba(0,220,255,0.80);
  box-shadow: 0 0 0 6px rgba(0,220,255,0.12);
  animation: pulse 1.6s var(--ease) infinite;
}
@keyframes pulse{
  0%{ transform: scale(1); opacity: .9; }
  55%{ transform: scale(1.35); opacity: .65; }
  100%{ transform: scale(1); opacity: .9; }
}
.microSpacer{ flex: 1; }
.microBadge{
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 10px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.14);
  background: rgba(255,255,255,0.08);
  color: rgba(255,255,255,0.86);
}

.cardGlow{
  position: absolute;
  inset: -140px -160px auto auto;
  width: 420px; height: 420px;
  border-radius: 50%;
  background:
    radial-gradient(circle at 30% 30%, rgba(64,140,255,0.22), transparent 60%),
    radial-gradient(circle at 70% 60%, rgba(255,122,0,0.18), transparent 60%),
    radial-gradient(circle at 55% 35%, rgba(0,220,255,0.12), transparent 60%);
  filter: blur(34px);
  opacity: 0.95;
  pointer-events: none;
}

/* Sections */
.section{ width: 100%; padding: 34px 0; }
.sectionHead{ margin-bottom: 14px; }
.eyebrow{ font-size: 13px; color: rgba(255,255,255,0.62); }
.h2{ margin: 6px 0 0; font-size: 26px; letter-spacing: -0.02em; }
.subhead{ margin-top: 6px; color: rgba(255,255,255,0.68); font-size: 14px; line-height: 1.55; }

.h3{ margin: 0 0 8px; font-size: 16px; letter-spacing: -0.01em; }
p{ color: rgba(255,255,255,0.78); line-height: 1.65; margin: 0; }

.grid2, .grid3{ display: grid; gap: 14px; }
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

.subtleNote{ margin: 12px 0 0; color: rgba(255,255,255,0.62); font-size: 13px; }

.feature .featTop{ display:flex; align-items:center; gap:10px; margin-bottom: 6px; }
.featIcon{
  width: 40px; height: 40px;
  border-radius: 16px;
  display:grid; place-items:center;
  border: 1px solid rgba(255,255,255,0.14);
  background: radial-gradient(120% 120% at 20% 20%, rgba(64,140,255,0.18), rgba(255,122,0,0.10));
  box-shadow: 0 18px 45px rgba(0,0,0,0.18);
  font-family: "JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", monospace;
  color: rgba(255,255,255,0.86);
}

.miniList{ margin: 0; padding-left: 18px; color: rgba(255,255,255,0.74); line-height: 1.7; }
.miniList li{ margin: 6px 0; }
.miniList b{ color: rgba(255,255,255,0.92); }

.contactCard{ display: flex; align-items: center; justify-content: space-between; gap: 14px; }
.contactRight{ display: flex; gap: 10px; flex-wrap: wrap; }

.footer{ margin: 12px 0 0; padding: 18px 0 0; color: rgba(255,255,255,0.64); }
.footerInner{ border-top: 1px solid rgba(255,255,255,0.10); padding-top: 16px; display: flex; align-items: center; justify-content: space-between; }
.linkBtn{ border: 0; background: transparent; color: rgba(255,255,255,0.74); cursor: pointer; }
.linkBtn:hover{ color: rgba(255,255,255,0.92); }

@media (max-width: 980px){
  .heroGrid{ grid-template-columns: 1fr; }
  .navLinks{ display: none; }
  .grid3{ grid-template-columns: 1fr; }
  .grid2{ grid-template-columns: 1fr; }
}
CSS

echo "✅ Classy + full width + tech font + smoother animations applied."
