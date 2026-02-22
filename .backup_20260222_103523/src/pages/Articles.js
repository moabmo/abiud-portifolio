import React from 'react';
import '../styles/Articles.css';

function Articles() {
  const items = [
    {
      title: 'Release Management: Shipping Safely to Google Play & Apple',
      desc: 'A practical checklist for store compliance, rollout discipline, and production readiness.',
      link: '#',
      label: 'Draft (coming soon)',
    },
    {
      title: 'Production‑Safe SQL Remediation in Revenue‑Critical Systems',
      desc: 'How to fix data issues without breaking audit trails, integrity, or uptime.',
      link: '#',
      label: 'Draft (coming soon)',
    },
    {
      title: 'Real‑Time SMS Gateways: Architecture Notes (Kannel)',
      desc: 'Patterns for throughput, failover, and monitoring in transactional messaging.',
      link: '#',
      label: 'Draft (coming soon)',
    },
  ];

  return (
    <div className="articles">
      <div className="articlesHeader">
        <h1>Articles & Notes</h1>
        <p>
          Short write‑ups on enterprise delivery, revenue systems, and production operations. (More coming
          soon.)
        </p>
      </div>

      <div className="articleGrid">
        {items.map((a) => (
          <div className="articleCard" key={a.title}>
            <div className="badge">{a.label}</div>
            <h2>{a.title}</h2>
            <p>{a.desc}</p>
            <div className="articleFooter">
              <span className="pill">Publishing soon</span>
            </div>
          </div>
        ))}
      </div>

      <div className="articlesNote">
        If you want a detailed case study (architecture, numbers, or impact), reach out via email or LinkedIn.
      </div>
    </div>
  );
}

export default Articles;
