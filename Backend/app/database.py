from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

# 从环境变量中获取数据库连接 URL
DATABASE_URL = os.getenv("DATABASE_URL")

# 创建 SQLAlchemy 引擎
engine = create_engine(DATABASE_URL)

# 创建数据库会话类，每个请求都会生成新的数据库会话
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# 创建一个基础类，所有模型类都将继承这个类
Base = declarative_base()
