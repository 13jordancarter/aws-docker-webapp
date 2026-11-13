# Use and offical Python image
FROM python:3.12-slim

# Set working directory inside container
WORKDIR /app

# Copy requirements file
COPY app/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Expose application port
EXPOSE 5000

# Start python application
CMD ["python", "app.py"]