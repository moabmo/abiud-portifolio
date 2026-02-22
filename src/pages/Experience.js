import React from 'react';
import { VerticalTimeline, VerticalTimelineElement } from 'react-vertical-timeline-component';
import 'react-vertical-timeline-component/style.min.css';
import { Work } from '@material-ui/icons';
import '../styles/Experience.css';

function Experience() {
  return (
    <div className="experience">
      <VerticalTimeline lineColor="rgba(234,240,255,0.18)">
        <VerticalTimelineElement
          className="vertical-timeline-element--work"
          date="Nov 2024 — Present"
          iconStyle={{ background: '#1f5cff', color: '#071018' }}
          icon={<Work />}
        >
          <h3>Kenya Power & Lighting Company (KPLC) — Nairobi, Kenya</h3>
          <h4>Systems Developer & Analyst (Billing & Fintech / Metering Systems)</h4>
          <p className="role">
            • Project Manager + Acting Tech Lead for Self‑Service transformation (Portal, Mobile, USSD, Chatbot)
            <br />• Manage Google Play + Apple App Store releases, compliance, rollouts, and operational readiness
            <br />• Build production‑safe SQL/PLSQL remediation for InCMS, Smart Meter/AMI user support, and data integrity
            <br />• Designed real‑time SMS gateway services (Kannel nodes) for transactional customer communication
            <br />• CAB member: vet change requests, assess risk, and support controlled deployments
            <br />• Train users and colleagues on UAT, troubleshooting, and operational runbooks
          </p>
        </VerticalTimelineElement>

        <VerticalTimelineElement
          className="vertical-timeline-element--work"
          date="Jun 2023 — Oct 2024"
          iconStyle={{ background: '#ffd100', color: '#071018' }}
          icon={<Work />}
        >
          <h3>Turnkey Africa — Nairobi, Kenya</h3>
          <h4>Business Applications Analyst</h4>
          <p className="role">
            • Requirements gathering, system analysis, testing/UAT, and stakeholder management
            <br />• Data quality checks, issue triage, and continuous improvement of business systems
          </p>
        </VerticalTimelineElement>

        <VerticalTimelineElement
          className="vertical-timeline-element--work"
          date="Jan 2022 — Dec 2022"
          iconStyle={{ background: '#2dd4bf', color: '#071018' }}
          icon={<Work />}
        >
          <h3>Kenya Revenue Authority (KRA) — Nairobi, Kenya</h3>
          <h4>ICT Assistant</h4>
          <p className="role">• IT support, systems troubleshooting, and service reliability support</p>
        </VerticalTimelineElement>

        <VerticalTimelineElement
          className="vertical-timeline-element--work"
          date="Jul 2022 — Sep 2022"
          iconStyle={{ background: 'rgba(255,255,255,0.12)', color: '#fff' }}
          icon={<Work />}
        >
          <h3>Independent Electoral & Boundaries Commission (IEBC) — Kenya</h3>
          <h4>ICT Clerk</h4>
          <p className="role">• Field ICT support and operational readiness during election period</p>
        </VerticalTimelineElement>

        <VerticalTimelineElement
          className="vertical-timeline-element--work"
          date="Jun 2021 — Dec 2021"
          iconStyle={{ background: 'rgba(31,92,255,0.45)', color: '#071018' }}
          icon={<Work />}
        >
          <h3>Icons Hub — Kisii, Kenya</h3>
          <h4>Software Engineer</h4>
          <p className="role">• Full‑stack web development and client delivery support</p>
        </VerticalTimelineElement>
      </VerticalTimeline>
    </div>
  );
}

export default Experience;
