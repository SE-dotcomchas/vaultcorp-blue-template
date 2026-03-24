# VaultCorp Container Image — hardened
FROM python:3.13-slim

# fix: skapa non-root user
RUN useradd -r -u 1000 -g root app

WORKDIR /app

# fix: kopiera bara det som behövs (kräver .dockerignore)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# fix: ta bort alla hårdkodade secrets — hanteras av K8s Secrets
# fix: kör som non-root
USER app

EXPOSE 5000
# fix: använd Gunicorn (produktions-WSGI-server) istället för Flask dev-server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
