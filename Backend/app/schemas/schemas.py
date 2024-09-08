from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional


class UserBase(BaseModel):
    email: EmailStr
    displayed_name: str
    # password: str


class UserCreate(UserBase):
    password:str
    
    # pass  # 创建用户只需要 `displayed_name`


class User(UserBase):
    id: int
    created_time: datetime
    # updated_time: datetime

    class Config:
        orm_mode = True  # 允许将 ORM 模型转换为 Pydantic 模型


class Token(BaseModel):
    access_token: str
    token_type: str

# Optional[]为可选


class TokenData(BaseModel):
    email: Optional[str] = None
