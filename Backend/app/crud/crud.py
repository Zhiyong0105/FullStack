from sqlalchemy.orm import Session
from app.models.models import User
from app.schemas import schemas
from datetime import datetime, timezone
from passlib.context import CryptContext
from fastapi import HTTPException

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


def creat_user(db: Session, user: schemas.UserCreate):
    hashed_password = get_password_hash(user.password)
    existing_user = get_by_email(db,user.email)
    if existing_user:
         raise HTTPException(status_code=400, detail="Email already registered")
    new_user = User(
        displayed_name=user.displayed_name,
        email=user.email,
        hashed_password=hashed_password,
        created_time=datetime.now(timezone.utc),
        updated_time=datetime.now(timezone.utc)

    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user


def get_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()
