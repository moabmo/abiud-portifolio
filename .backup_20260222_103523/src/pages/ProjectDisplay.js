import React from 'react';
import { useParams, Link } from 'react-router-dom';
import { ProjectList } from '../helpers/ProjectList';
import { GitHub } from '@material-ui/icons';
import '../styles/ProjectDisplay.css';

function ProjectDisplay() {
  const { id } = useParams();
  const project = ProjectList[id];

  if (!project) {
    return (
      <div className="project">
        <h1>Project not found</h1>
        <p>Return to <Link to="/projects">Projects</Link>.</p>
      </div>
    );
  }

  return (
    <div className="project">
      <div className="projectHeader">
        <h1>{project.name}</h1>
        <p className="projectMeta">{project.skills}</p>
      </div>

      <div className="projectCard">
        <img src={project.image} alt={project.name} />
        <div className="projectBody">
          <p className="projectSummary">{project.summary}</p>

          <div className="projectActions">
            {project.link && project.link !== '#' ? (
              <a className="btnPrimary" href={project.link} target="_blank" rel="noreferrer">
                {project.linkLabel || 'View'}
              </a>
            ) : (
              <span className="pill">{project.linkLabel || 'Details on request'}</span>
            )}

            <span className="pillIcon" title="Private repository / available on request">
              <GitHub />
              <span>Repo</span>
            </span>

            <Link className="btnGhost" to="/projects">
              Back
            </Link>
          </div>
        </div>
      </div>

      <p className="projectNote">
        Note: Some content is intentionally summarized to protect internal/customer data.
      </p>
    </div>
  );
}

export default ProjectDisplay;
