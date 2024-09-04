from fastapi import FastAPI
from app.api import user_routes  
from app.database import engine
from app.models.models import Base


app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(user_routes.router)




