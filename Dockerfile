FROM python:3.10-slim

# Define working directory
WORKDIR /app

# Copy requirements.txt files and install dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the port on which FastAPI is running
EXPOSE 8000

# Command to start the application
CMD ["sh", "-c", "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"]
