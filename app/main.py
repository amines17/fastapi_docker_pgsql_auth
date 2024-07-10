from fastapi import FastAPI
from app.database import engine, Base
from app.auth import models, auth

Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.on_event("startup")
async def startup():
    Base.metadata.create_all(bind=engine)

@app.on_event("shutdown")
async def shutdown():
    pass

app.include_router(auth.router, prefix="/auth", tags=["auth"])
