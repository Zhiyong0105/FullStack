from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import os

# Connect with Postgresql
SQLALCHEMY_DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Create a session factory
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

