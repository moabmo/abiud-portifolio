import React, { useEffect, useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import '../styles/Navbar.css';
import ReorderIcon from '@material-ui/icons/Reorder';

function Navbar() {
  const [open, setOpen] = useState(false);
  const location = useLocation();

  useEffect(() => {
    setOpen(false);
  }, [location]);

  return (
    <header className="navWrap">
      <div className="navGlow" aria-hidden="true" />
      <nav className="navbar" aria-label="Primary">
        <Link className="brand" to="/">
          <span className="brandMark" aria-hidden="true" />
          <span className="brandText">Monyoro</span>
        </Link>

        <button
          className="navToggle"
          onClick={() => setOpen((p) => !p)}
          aria-label="Toggle navigation"
          aria-expanded={open}
        >
          <ReorderIcon />
        </button>

        <div className={`links ${open ? 'open' : ''}`}>
          <Link to="/">Home</Link>
          <Link to="/projects">Projects</Link>
          <Link to="/experience">Experience</Link>
          <Link to="/articles">Articles</Link>
        </div>
      </nav>
    </header>
  );
}

export default Navbar;
