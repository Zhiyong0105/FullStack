from pydantic import BaseModel


class User(BaseModel):
    id: int
    name: str
    email: str

    class Config:
        orm_mode = True  # 支持从 ORM 模型转换为 Pydantic 模型
