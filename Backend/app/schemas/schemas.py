from pydantic import BaseModel, EmailStr
from datetime import datetime




class UserBase(BaseModel):
    email: EmailStr
    # displayed_name: str


class UserCreate(UserBase):
    pass  # 创建用户只需要 `displayed_name`


class User(UserBase):
    id: int
    created_time: datetime
    updated_time: datetime

    class Config:
        orm_mode = True  # 允许将 ORM 模型转换为 Pydantic 模型
