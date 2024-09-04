from .database import SessionLocal
from sqlalchemy.orm import Session
from fastapi import Depends

# 创建并关闭数据库会话的依赖项


def get_db():
    db = SessionLocal()
    try:
        yield db  # 返回数据库会话对象
    finally:
        db.close()  # 请求结束后关闭会话
