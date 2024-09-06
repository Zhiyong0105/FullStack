from sqlalchemy.orm import Session
from app.models.models import User
from app.schemas import schemas
from datetime import datetime, timezone


def creat_user(db: Session, user: schemas.UserCreate):
    new_user = User(
        displayed_name="default",
        email=user.email,
        created_time=datetime.now(timezone.utc),
        updated_time=datetime.now(timezone.utc)

    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

def get_by_email(db:Session,user:schemas.UserCreate):
    return user
