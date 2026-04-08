FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt.
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY agent.py.

# Cloud Run expects PORT env var
ENV PORT=8080

EXPOSE 8080

# Run the agent.py file
CMD ["uvicorn", "agent:app", "--host", "0.0.0.0", "--port", "8080"]