from sqlalchemy.orm import Session
from models import User


def create_user(db: Session, id: str, displayed_name: str):
    new_user = User(id=id, displayed_name=displayed_name)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)  
    return new_user
