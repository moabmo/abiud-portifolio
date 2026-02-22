import React from 'react';
import { LinkedIn, Email, GitHub, ArrowForward } from '@material-ui/icons';
import { Link } from 'react-router-dom';
import '../styles/Home.css';
import TypewriterText from './TypewriterText';

function Home() {
  return (
    <div className="home">
      <section className="hero">
        <div className="heroGlow" aria-hidden="true" />

        <div className="heroInner">
          <div className="heroLeft">
            <div className="kicker">Billing & Fintech • Revenue Systems • Smart Metering</div>
            <TypewriterText />

            <p className="heroLead">
              I build and run <b>revenue‑critical systems</b>—from core billing and smart metering to
              customer self‑service channels and real‑time communication—within high‑availability
              enterprise environments.
            </p>

            <ul className="heroBullets">
              <li>Project Manager + Acting Tech Lead for Self‑Service transformation</li>
              <li>Release management for Google Play & Apple App Store</li>
              <li>Oracle SQL/PL/SQL remediation for production incidents & data integrity</li>
              <li>Real‑time SMS gateway architecture (Kannel nodes) for transactional messaging</li>
              <li>CAB member: change governance, risk assessment, and deployment readiness</li>
            </ul>

            <div className="heroCtas">
              <Link className="btnPrimary" to="/projects">
                View Work <ArrowForward />
              </Link>
              <Link className="btnGhost" to="/experience">
                Experience
              </Link>
            </div>

            <div className="socialRow">
              <a
                className="iconBtn"
                href="https://www.linkedin.com/in/abiud-m-59430b17a/"
                target="_blank"
                rel="noreferrer"
                aria-label="LinkedIn"
              >
                <LinkedIn />
              </a>
              <a className="iconBtn" href="mailto:monyoro@proton.me" aria-label="Email">
                <Email />
              </a>
              <a
                className="iconBtn"
                href="https://github.com/"
                target="_blank"
                rel="noreferrer"
                aria-label="GitHub"
              >
                <GitHub />
              </a>
            </div>

            <div className="microNote">
              Working across <b>core billing</b>, <b>fintech channels</b>, <b>smart metering</b>, and
              <b> revenue assurance</b>—systems that handle <b>large‑scale transactions</b> and demand
              strong governance.
            </div>
          </div>

          <div className="heroRight">
            <div className="profileCard">
              <div className="avatar" aria-hidden="true">
                <span>AM</span>
              </div>
              <div className="profileText">
                <div className="name">Abiud Monyoro Mongare</div>
                <div className="title">Enterprise Systems Analyst • Digital Transformation Lead</div>
              </div>

              <div className="statGrid">
                <div className="stat">
                  <div className="statTop">Focus</div>
                  <div className="statVal">Revenue Systems</div>
                </div>
                <div className="stat">
                  <div className="statTop">Strength</div>
                  <div className="statVal">Production Stability</div>
                </div>
                <div className="stat">
                  <div className="statTop">Delivery</div>
                  <div className="statVal">PM + Tech Lead</div>
                </div>
                <div className="stat">
                  <div className="statTop">Governance</div>
                  <div className="statVal">CAB</div>
                </div>
              </div>

              <div className="pillRow">
                <span className="pill">Oracle SQL/PL/SQL</span>
                <span className="pill">Java</span>
                <span className="pill">APIs</span>
                <span className="pill">Linux</span>
                <span className="pill">Docker</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="sectionHeader">
          <h2>Technical Competencies</h2>
          <p>What I use to deliver and stabilize enterprise platforms.</p>
        </div>

        <div className="grid3">
          <div className="glassCard">
            <h3>Programming</h3>
            <p>Oracle SQL, PL/SQL, Java, JavaScript, Python, Bash</p>
          </div>
          <div className="glassCard">
            <h3>Backend & APIs</h3>
            <p>REST APIs, Spring Boot, JWT/Auth, secure integrations, data validation</p>
          </div>
          <div className="glassCard">
            <h3>Platforms</h3>
            <p>Core Billing (InCMS), Smart Meter/AMI, Self‑Service, SMS Gateway</p>
          </div>
          <div className="glassCard">
            <h3>Mobile Releases</h3>
            <p>Google Play Console, Apple App Store, rollout strategy, compliance</p>
          </div>
          <div className="glassCard">
            <h3>Ops & DevOps</h3>
            <p>Linux (Rocky), Docker, Git, CI/CD support, production rollout readiness</p>
          </div>
          <div className="glassCard">
            <h3>Governance</h3>
            <p>CAB change vetting, risk analysis, audit controls, data protection</p>
          </div>
        </div>
      </section>

      <section className="section">
        <div className="sectionHeader">
          <h2>What I’m Known For</h2>
          <p>Short, honest, and high-impact.</p>
        </div>

        <div className="grid2">
          <div className="glassCard">
            <h3>Enterprise delivery</h3>
            <ul className="cleanList">
              <li>Translate business needs → working solutions with measurable outcomes</li>
              <li>Manage UAT with users, fix gaps fast, and ship safely</li>
              <li>Own releases and stabilization, not just development</li>
            </ul>
          </div>
          <div className="glassCard">
            <h3>Training & leadership</h3>
            <ul className="cleanList">
              <li>Train users and colleagues on workflows, testing, and troubleshooting</li>
              <li>Standardize runbooks and repeatable fixes for recurring incidents</li>
              <li>Mentor teams on production-safe scripts and change discipline</li>
            </ul>
          </div>
        </div>

        <div className="ctaBar">
          <div>
            <div className="ctaTitle">Want a clean walkthrough of my work?</div>
            <div className="ctaSub">Open Projects for case-study summaries and focus areas.</div>
          </div>
          <Link className="btnPrimary" to="/projects">
            Open Projects <ArrowForward />
          </Link>
        </div>
      </section>
    </div>
  );
}

export default Home;
