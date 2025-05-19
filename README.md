<!DOCTYPE html>
<html>
    <h1>🚀 FastAPI Docker Codespaces Boilerplate</h1>
    <p>Instant FastAPI Development in GitHub Codespaces with Docker & Hot-Reload</p>
    
    <div>
        <span class="badge">GitHub</span>
        <span class="badge" style="background-color: #009688">FastAPI</span>
        <span class="badge" style="background-color: #2496ed">Docker</span>
    </div>

    <h2>📖 Overview</h2>
    <p>A boilerplate to kickstart <strong>FastAPI</strong> projects in <strong>GitHub Codespaces</strong> with:</p>
    <ul>
        <li>✅ <strong>Docker</strong> integration</li>
        <li>✅ <strong>Hot-reload</strong> during development</li>
        <li>✅ <strong>Pre-configured</strong> CORS, health checks, and logging</li>
        <li>✅ <strong>Zero-setup</strong> for Codespaces (auto-configured .devcontainer)</li>
    </ul>

    <h2>⚡ Features</h2>
    <div class="feature-list">
        <div class="feature-item">
            <strong>🐍 Python 3.9 + FastAPI</strong>
        </div>
        <div class="feature-item">
            <strong>🐳 Docker & Docker-Compose</strong>
        </div>
        <div class="feature-item">
            <strong>🔄 Auto-reload on code changes</strong>
        </div>
        <div class="feature-item">
            <strong>🌐 CORS pre-configured</strong>
        </div>
        <div class="feature-item">
            <strong>🏥 /health endpoint for monitoring</strong>
        </div>
        <div class="feature-item">
            <strong>📂 Volume mounting for seamless development</strong>
        </div>
        <div class="feature-item">
            <strong>📜 Logging setup (logs/setup.log)</strong>
        </div>
    </div>

    <h2>🚀 Quick Start</h2>
    <h3>1. Open in Codespaces</h3>
    <p><a href="https://codespaces.new/YatoTech/fastapi-codespaces-boilerplate" target="_blank"><img src="https://github.com/codespaces/badge.svg" alt="Open in GitHub Codespaces"></a></p>

    <h3>2. Run the Setup Script</h3>
    <pre><code>chmod +x setup.sh
./setup.sh</code></pre>

    <h3>3. Access the API</h3>
    <ul>
        <li><strong>Local URL</strong>: <a href="http://localhost:8000" target="_blank">http://localhost:8000</a></li>
        <li><strong>Codespaces URL</strong>: https://&lt;your-codespace&gt;-8000.preview.app.github.dev</li>
    </ul>

    <h4>Endpoints</h4>
    <ul>
        <li><code>GET /</code> → <code>{"Hello": "World"}</code></li>
        <li><code>GET /items/42?q=test</code> → <code>{"item_id": 42, "q": "test"}</code></li>
        <li><code>GET /health</code> → <code>{"status": "healthy"}</code></li>
    </ul>

    <h2>🛠️ How It Works</h2>
    <h3>🔧 System Architecture</h3>
    <pre>fastapi-codespaces/
├── .devcontainer/       # Codespaces config
│   ├── devcontainer.json → Docker-in-Docker setup  
│   └── post-create.sh  → Post-install script  
├── Dockerfile          → FastAPI + Uvicorn  
├── docker-compose.yml  → Ports, volumes, healthcheck  
├── main.py             # FastAPI app (with CORS)  
├── requirements.txt    # Dependencies  
└── setup.sh            # Auto-setup script</pre>

    <h3>⚙️ Key Components</h3>
    <h4>Docker Integration</h4>
    <ul>
        <li>Uses <code>docker-in-docker</code> in Codespaces.</li>
        <li>Volume mounts (<code>.:/app</code>) sync local changes instantly.</li>
    </ul>

    <h4>Hot-Reload</h4>
    <ul>
        <li>Uvicorn runs with <code>--reload</code> flag.</li>
        <li>Detects file changes and restarts the server automatically.</li>
    </ul>

    <h4>Health Check</h4>
    <ul>
        <li>Docker healthcheck monitors <code>/health</code> endpoint.</li>
        <li>Ensures container is running properly.</li>
    </ul>

    <h4>Logging</h4>
    <ul>
        <li>All setup steps logged in <code>logs/setup.log</code>.</li>
        <li>Container logs accessible via <code>docker-compose logs</code>.</li>
    </ul>

    <h2>💡 Why Use This?</h2>
    <ul>
        <li>✔ <strong>Zero-config</strong> FastAPI + Docker in Codespaces</li>
        <li>✔ <strong>Instant reload</strong> for faster development</li>
        <li>✔ <strong>Pre-configured</strong> for production-ready practices</li>
        <li>✔ <strong>Easy to extend</strong> (add DB, auth, etc.)</li>
    </ul>

    <h2>📜 License</h2>
    <p>MIT © <a href="https://github.com/YatoTech" target="_blank">Your Name</a></p>

    <h2>🔗 Links</h2>
    <ul>
        <li><a href="https://fastapi.tiangolo.com" target="_blank">FastAPI Documentation</a></li>
        <li><a href="https://docs.github.com/codespaces" target="_blank">GitHub Codespaces Docs</a></li>
    </ul>
</html>
