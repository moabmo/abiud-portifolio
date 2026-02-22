import React, { useEffect, useMemo, useState } from 'react';
import '../styles/TypewriterText.css';

function TypewriterText() {
  const phrases = useMemo(
    () => [
      'Abiud Monyoro Mongare',
      'Enterprise Systems Analyst',
      'Digital Transformation Lead',
      'Billing & Fintech • Revenue Systems',
      'Smart Metering • AMI • Field Workflows',
    ],
    []
  );

  const [text, setText] = useState('');
  const [phraseIndex, setPhraseIndex] = useState(0);
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    const current = phrases[phraseIndex % phrases.length];

    const speed = isDeleting ? 30 : 55;
    const pause = 900;

    const tick = () => {
      const next = isDeleting
        ? current.substring(0, text.length - 1)
        : current.substring(0, text.length + 1);

      setText(next);

      // when full word typed
      if (!isDeleting && next === current) {
        setTimeout(() => setIsDeleting(true), pause);
        return;
      }

      // when deleted
      if (isDeleting && next === '') {
        setIsDeleting(false);
        setPhraseIndex((p) => (p + 1) % phrases.length);
        return;
      }

      setTimeout(tick, speed);
    };

    const t = setTimeout(tick, speed);
    return () => clearTimeout(t);
  }, [phrases, phraseIndex, isDeleting, text]);

  return (
    <div className="typewriter">
      <h1 className="typewriter-text">
        {text}
        <span className="cursor" aria-hidden="true" />
      </h1>
    </div>
  );
}

export default TypewriterText;
