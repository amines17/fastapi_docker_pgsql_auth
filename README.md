# FastAPI Docker PostgreSQL Auth

## Description

This project is a starter template for a web application built with FastAPI, integrating a PostgreSQL database and deployed via Docker. The project also includes a pre-configured authentication system using JWT to secure the endpoints.

## Features

- **FastAPI**: A modern, fast web framework for Python 3.6+ based on standard Python type hints.
- **PostgreSQL**: A powerful, open-source object-relational database system.
- **Docker**: Containerization of the application for ease of deployment and scalability.
- **JWT Authentication**: A robust authentication system using JSON Web Tokens to secure the application's endpoints.
- **SQLAlchemy**: An ORM to interact with the database in an easy and efficient manner.
- **Alembic**: A database migration tool to manage database schema changes over time.
- **Password Management**: Secure password hashing with Passlib and bcrypt.

## Prerequisites

- Docker
- Docker Compose

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/fastapi_docker_pgsql_auth.git
    cd fastapi_docker_pgsql_auth
    ```

2. Build and start the Docker containers:
    ```sh
    docker-compose up --build
    ```

3. Access the application:
    The application will be accessible at `http://localhost:8000`.

## Usage

- **Interactive API Documentation**:
  Once the server is up and running, you can access the automatically generated interactive API documentation at `http://localhost:8000/docs`.

- **Test Authentication**:
  You can test the authentication system by using the endpoints dedicated to user creation and obtaining JWT tokens.

## Requirements

Here are the Python dependencies used in this project:

