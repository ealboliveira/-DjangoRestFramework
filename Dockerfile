# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /code

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libpq-dev \
        gcc \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python -
ENV PATH="/root/.local/bin:${PATH}"

# Install project dependencies
COPY pyproject.toml poetry.lock /code/
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev --no-root

# Copy the current directory contents into the container at /code/
COPY . /code/

# Run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
