import React from 'react';
import { LinkedIn, Email, GitHub } from '@material-ui/icons';
import '../styles/Footer.css';

function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer className="footer">
      <div className="footerInner">
        <div className="footerLeft">
          <div className="footerName">Abiud Monyoro Mongare</div>
          <div className="footerTag">Enterprise Systems • Billing & Fintech • Smart Metering</div>
        </div>

        <div className="footerRight">
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
      </div>

      <div className="footerBottom">© {year} Monyoro. Built with React.</div>
    </footer>
  );
}

export default Footer;
