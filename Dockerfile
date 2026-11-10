FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-venv python3-pip git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY setup.sh requirements.txt .

RUN chmod +x setup.sh

CMD ["./setup.sh"]