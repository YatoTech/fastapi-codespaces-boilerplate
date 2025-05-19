<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>FastAPI Docker Codespaces Boilerplate</title>
  <style>
    body {
      font-family: sans-serif;
      max-width: 800px;
      margin: auto;
      padding: 2rem;
      line-height: 1.6;
    }
    code {
      background: #f4f4f4;
      padding: 2px 4px;
      border-radius: 4px;
      font-family: monospace;
    }
    pre {
      background: #f4f4f4;
      padding: 1rem;
      overflow: auto;
      border-radius: 6px;
    }
    .badge {
      display: inline-block;
      padding: 0.4em 0.7em;
      margin: 0.2em;
      font-size: 0.9em;
      border-radius: 0.3em;
      color: #fff;
    }
    .github { background-color: #333; }
    .fastapi { background-color: #009688; }
    .docker { background-color: #2496ed; }
    h1, h2, h3, h4 {
      margin-top: 2rem;
    }
  </style>
</head>
<body>

<h1>🚀 FastAPI Docker Codespaces Boilerplate</h1>
<p><strong>Instant FastAPI development in GitHub Codespaces with Docker & Hot Reload</strong></p>

<span class="badge github">GitHub</span>
<span class="badge fastapi">FastAPI</span>
<span class="badge docker">Docker</span>

<h2>📖 Overview</h2>
<p>A boilerplate to kickstart <strong>FastAPI</strong> projects in <strong>GitHub Codespaces</strong>, featuring:</p>
<ul>
  <li>✅ <strong>Docker</strong> integration</li>
  <li>✅ <strong>Hot-reload</strong> during development</li>
  <li>✅ <strong>Pre-configured</strong> CORS, health checks, and logging</li>
  <li>✅ <strong>Zero-setup</strong> Codespaces environment (<code>.devcontainer</code> included)</li>
</ul>

<h2>⚡ Features</h2>
<ul>
  <li>🐍 Python 3.9 + FastAPI</li>
  <li>🐳 Docker & Docker Compose</li>
  <li>🔄 Auto-reload on code changes</li>
  <li>🌐 CORS pre-configured</li>
  <li>🏥 <code>/health</code> endpoint for monitoring</li>
  <li>📂 Volume mounting for seamless development</li>
  <li>📜 Logging setup (<code>logs/setup.log</code>)</li>
</ul>

<h2>🚀 Quick Start</h2>

<h3>1. Open in Codespaces</h3>
<p>
  <a href="https://codespaces.new/YatoTech/fastapi-codespaces-boilerplate" target="_blank">
    <img src="https://github.com/codespaces/badge.svg" alt="Open in GitHub Codespaces">
  </a>
</p>

<h3>2. Run the Setup Script</h3>
<pre><code>chmod +x setup.sh
./setup.sh</code></pre>

<h3>3. Access the API</h3>
<ul>
  <li><strong>Local URL</strong>: <a href="http://localhost:8000" target="_blank">http://localhost:8000</a></li>
  <li><strong>Codespaces URL</strong>: <code>https://&lt;your-codespace&gt;-8000.preview.app.github.dev</code></li>
</ul>

<h4>Example Endpoints</h4>
<pre><code>GET /            → {"Hello": "World"}
GET /items/42?q= → {"item_id": 42, "q": "test"}
GET /health      → {"status": "healthy"}</code></pre>

<h2>🛠️ How It Works</h2>

<h3>🔧 Project Structure</h3>
<pre><code>fastapi-codespaces/
├── .devcontainer/          # Codespaces config
│   ├── devcontainer.json   # Docker-in-Docker setup
│   └── post-create.sh      # Post-install script
├── Dockerfile              # FastAPI + Uvicorn
├── docker-compose.yml      # Service config with healthcheck
├── main.py                 # FastAPI app (with CORS & endpoints)
├── requirements.txt        # Python dependencies
└── setup.sh                # Automated setup script</code></pre>

<h3>⚙️ Key Components</h3>

<h4>🔹 Docker Integration</h4>
<ul>
  <li>Uses <code>Docker-in-Docker</code> inside Codespaces</li>
  <li>Volume mounting (<code>.:/app</code>) allows instant file syncing</li>
</ul>

<h4>🔹 Hot Reload</h4>
<ul>
  <li>Runs Uvicorn with <code>--reload</code> flag</li>
  <li>Automatically restarts server on code changes</li>
</ul>

<h4>🔹 Health Check</h4>
<ul>
  <li>Docker <code>healthcheck</code> probes the <code>/health</code> endpoint</li>
  <li>Ensures the container is live and responsive</li>
</ul>

<h4>🔹 Logging</h4>
<ul>
  <li>Setup logs stored in <code>logs/setup.log</code></li>
  <li>View logs via <code>docker-compose logs</code></li>
</ul>

<h2>💡 Why Use This?</h2>
<ul>
  <li>✔ <strong>Zero-config</strong> FastAPI + Docker in Codespaces</li>
  <li>✔ <strong>Instant reload</strong> for rapid development</li>
  <li>✔ <strong>Production-ready</strong> structure</li>
  <li>✔ <strong>Easily extendable</strong> (add database, auth, etc.)</li>
</ul>

<h2>📜 License</h2>
<p>MIT © <a href="https://github.com/YatoTech" target="_blank">Your Name</a></p>

<h2>🔗 Useful Links</h2>
<ul>
  <li><a href="https://fastapi.tiangolo.com" target="_blank">FastAPI Documentation</a></li>
  <li><a href="https://docs.github.com/codespaces" target="_blank">GitHub Codespaces Docs</a></li>
</ul>

</body>
</html>
