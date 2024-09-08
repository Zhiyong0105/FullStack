from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.crud.crud import creat_user, get_by_email
from app.schemas import schemas
from app.dependencies import get_db
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from app.auth import authenticate_user, create_access_token, get_current_user
from typing import Annotated


router = APIRouter()

# oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/login/")


@router.post("/register/", response_model=schemas.User)
def creat_user_route(user: schemas.UserCreate, db: Session = Depends(get_db)):
    users = creat_user(db=db, user=user)
    return users


@router.post("/login/", response_model=schemas.Token)
async def login_for_access_token(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    db: Annotated[Session, Depends(get_db)]
) -> schemas.Token:
    user = authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = create_access_token(data={"sub": user.email})
    return schemas.Token(access_token=access_token, token_type="bearer")


@router.get("/users/me/", response_model=schemas.User)
async def read_users_me(current_user: schemas.User = Depends(get_current_user)):
    return current_user
