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

fastapi
uvicorn[standard]
databases[postgresql]
sqlalchemy
asyncpg
python-jose
passlib[bcrypt]
alembic
psycopg2-binary
pydantic-settings
bcrypt==3.2.0


## Environment Variables

You can use a `.env` file to manage your environment variables. Create a `.env` file in the root directory of the project and add the following variables :
```
DATABASE_URL=postgresql://postgres@db:5432/postgres
SECRET_KEY=your_secret_key
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

Then, modify the `Settings` class in `config.py` to load these variables:

```python
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DATABASE_URL: str
    SECRET_KEY: str
    ALGORITHM: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int

    class Config:
        env_file = ".env"

settings = Settings() 
```

## Returning Cookies for Authentication

If you want to return cookies instead of relying solely on the JSON response for storing the tokens, you can modify the authentication endpoint like this:

1. Modify the login_for_access_token function in auth.py to set the cookies:

```python
from fastapi.responses import JSONResponse

@router.post("/token", response_model=schemas.Token)
def login_for_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(), 
    db: Session = Depends(get_db)
):
    user = crud.authenticate_user(db, username=form_data.username, password=form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = security.create_access_token(data={"sub": user.username})
    refresh_token = security.create_refresh_token(data={"sub": user.username})
    response = JSONResponse(content={"access_token": access_token, "token_type": "bearer", "refresh_token": refresh_token})
    response.set_cookie(key="access_token", value=access_token, httponly=True)
    response.set_cookie(key="refresh_token", value=refresh_token, httponly=True)
    return response
```

2. Ensure the cookies are used for subsequent requests by extracting them in your dependency injection or directly in your endpoints.

## Contribution
Contributions are welcome! Feel free to open an issue or a pull request for any improvements or bug fixes.