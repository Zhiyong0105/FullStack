from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.crud import crud
from app.schemas import schemas
from app.dependencies import get_db

# 创建一个路由实例
router = APIRouter()

# 定义一个获取用户列表的路由


@router.get("/users/", response_model=list[schemas.User])
def read_users(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    users = crud.get_users(db, skip=skip, limit=limit)
    return users
