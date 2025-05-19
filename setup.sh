#!/bin/bash

# Buat folder logs jika belum ada
mkdir -p logs

# Fungsi untuk mencatat log
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> logs/setup.log
    echo "$1"
}

# Fungsi untuk cek command tersedia
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Mulai proses setup
log "Memulai proses setup FastAPI dengan Docker di Codespaces"

# 1. Cek dan setup Docker
if ! command_exists docker; then
    log "Docker tidak terdeteksi, mencoba mengaktifkan Docker di Codespaces..."
    
    # Buat konfigurasi devcontainer untuk mengaktifkan Docker
    mkdir -p .devcontainer
    cat > .devcontainer/devcontainer.json << 'EOL'
{
  "name": "FastAPI with Docker",
  "image": "mcr.microsoft.com/devcontainers/python:0-3.9",
  "features": {
    "docker-in-docker": "latest"
  },
  "forwardPorts": [8000],
  "postCreateCommand": "bash ./.devcontainer/post-create.sh",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-azuretools.vscode-docker"
      ]
    }
  }
}
EOL

    cat > .devcontainer/post-create.sh << 'EOL'
#!/bin/bash
# Script ini akan dijalankan setelah container dibuat
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker masih belum tersedia setelah rebuild container"
    exit 1
fi
EOL

    chmod +x .devcontainer/post-create.sh
    
    log "Docker diaktifkan melalui devcontainer. Silakan:"
    log "1. Klik kanan pada file devcontainer.json"
    log "2. Pilih 'Rebuild Container'"
    log "3. Tunggu proses selesai"
    log "4. Jalankan script ini kembali setelah rebuild"
    exit 0
fi

# 2. Cek dan setup Docker Compose command
DOCKER_COMPOSE_CMD="docker compose"
if ! command_exists docker-compose; then
    if ! docker compose version &> /dev/null; then
        log "Menginstall Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
            -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        
        if ! command_exists docker-compose; then
            log "ERROR: Gagal menginstall docker-compose"
            exit 1
        fi
    else
        log "Menggunakan 'docker compose' (modern compose plugin)"
    fi
else
    DOCKER_COMPOSE_CMD="docker-compose"
    log "Menggunakan 'docker-compose' (legacy)"
fi

# 3. Buat Dockerfile
log "Membuat Dockerfile..."
cat > Dockerfile << 'EOL'
# Gunakan image Python resmi sebagai base image
FROM python:3.9-slim

# Set working directory di container
WORKDIR /app

# Install dependensi sistem yang diperlukan
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy file requirements terlebih dahulu untuk memanfaatkan layer caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh kode aplikasi
COPY . .

# Expose port yang digunakan FastAPI (biasanya 8000)
EXPOSE 8000

# Command untuk menjalankan aplikasi dengan reload
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOL

[ -f "Dockerfile" ] || { log "ERROR: Gagal membuat Dockerfile"; exit 1; }
log "Dockerfile berhasil dibuat"

# 4. Buat requirements.txt
log "Membuat requirements.txt..."
cat > requirements.txt << 'EOL'
fastapi>=0.68.0
uvicorn>=0.15.0
python-dotenv>=0.19.0
EOL

[ -f "requirements.txt" ] || { log "ERROR: Gagal membuat requirements.txt"; exit 1; }
log "requirements.txt berhasil dibuat"

# 5. Buat main.py
log "Membuat main.py..."
cat > main.py << 'EOL'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Setup CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def read_root():
    return {"Hello": "World from FastAPI in Codespaces!"}

@app.get("/items/{item_id}")
async def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}
EOL

[ -f "main.py" ] || { log "ERROR: Gagal membuat main.py"; exit 1; }
log "main.py berhasil dibuat"

# 6. Buat docker-compose.yml
log "Membuat docker-compose.yml..."
cat > docker-compose.yml << 'EOL'
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    environment:
      - PYTHONPATH=/app
      - PYTHONUNBUFFERED=1
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
EOL

[ -f "docker-compose.yml" ] || { log "ERROR: Gagal membuat docker-compose.yml"; exit 1; }
log "docker-compose.yml berhasil dibuat"

# 7. Build dan jalankan container
log "Membangun container Docker..."
if $DOCKER_COMPOSE_CMD build >> logs/build.log 2>&1; then
    log "Build container berhasil"
    
    log "Menjalankan container..."
    if $DOCKER_COMPOSE_CMD up -d >> logs/run.log 2>&1; then
        log "Container berhasil dijalankan"
        
        # Cek kesehatan container
        log "Memeriksa kesehatan container..."
        for i in {1..5}; do
            CONTAINER_STATUS=$($DOCKER_COMPOSE_CMD ps -q web)
            HEALTH_STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_STATUS 2>/dev/null || echo "starting")
            
            if [ "$HEALTH_STATUS" = "healthy" ]; then
                break
            fi
            sleep 5
        done
        
        # Cek endpoint kesehatan
        if curl -s http://localhost:8000/health | grep -q healthy; then
            log "Aplikasi FastAPI berjalan dengan baik"
            echo ""
            echo "============================================"
            echo " SETUP BERHASIL!"
            echo "============================================"
            echo "Aplikasi FastAPI berjalan di:"
            echo "http://localhost:8000"
            echo ""
            echo "Endpoint yang tersedia:"
            echo "- http://localhost:8000/"
            echo "- http://localhost:8000/items/42?q=test"
            echo "- http://localhost:8000/health"
            echo ""
            echo "Perintah berguna:"
            echo "1. Lihat logs: $DOCKER_COMPOSE_CMD logs -f"
            echo "2. Stop aplikasi: $DOCKER_COMPOSE_CMD down"
            echo "3. Restart aplikasi: $DOCKER_COMPOSE_CMD restart"
            echo "============================================"
        else
            log "WARNING: Aplikasi mungkin tidak berjalan dengan baik"
            echo "WARNING: Aplikasi mungkin tidak berjalan dengan baik"
            echo "Cek logs dengan: $DOCKER_COMPOSE_CMD logs -f"
        fi
    else
        log "ERROR: Gagal menjalankan container"
        echo "ERROR: Gagal menjalankan container. Lihat logs/run.log untuk detail"
        exit 1
    fi
else
    log "ERROR: Gagal membangun container"
    echo "ERROR: Gagal membangun container. Lihat logs/build.log untuk detail"
    exit 1
fi
