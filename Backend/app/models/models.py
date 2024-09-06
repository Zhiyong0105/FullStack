# Define database
from sqlalchemy import Column, Integer, String, Sequence, DateTime
from sqlalchemy.orm import declarative_base
import datetime


Base = declarative_base()


class User(Base):
    __tablename__ = "Users"
    id = Column(Integer, Sequence('user_id_seq'), primary_key=True)
    displayed_name = Column(String(50), nullable=False)
    email = Column(String(50),nullable=False)
    password = Column(String(50), nullable=False)
    created_time = Column(
        DateTime, default=datetime.datetime.now(datetime.timezone.utc))
    updated_time = Column(DateTime, default=datetime.datetime.now(
        datetime.timezone.utc), onupdate=datetime.datetime.now(datetime.timezone.utc))
