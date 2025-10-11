from datetime import datetime, timedelta
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.security import ACCESS_TOKEN_EXPIRE_MINUTES, get_password_hash, verify_password, create_access_token
from app.database.database import get_db
from app.models.models import UserModel
from app.schemas.schemas import Token, User, UserCreate, UserLogin

# purpose of this code : This code defines the API endpoints related to the currently logged-in 
#                        user's profile. It uses the conventional /me path to allow a user to manage 
#                        their own information without needing to know their own user ID.

# 1 : this let you group related endpoints together 

router = APIRouter()

# 2. create a new user
# This is the endpoint for creating a user.
# It responds to POST requests at the root of this router.
# reponse model is the shape/format of the data that you send back to the front end that is why
# we user this argument
@router.post('/create', response_model=User)
def create_user(user: UserCreate, db : Session = Depends(get_db)):
    # 1. check if the user with same username & password exists in database
    db_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered!")

    # 2. creating a new user object using UserModel class from models.py file
    new_user = UserModel(
        username=user.username,
        email=user.email,
        hashed_password= get_password_hash(user.password),
        created_at=datetime.now(),
    )

    # 3. add newly created user to the database
    db.add(new_user)

    # 4. commit the changes to the database
    db.commit()

    # 5. Refresh the object to get id assign by the database
    db.refresh(new_user)

    # 6. return newly created user
    return new_user

# 3. login user
# It tells FastAPI: "No matter what data this function produces, the final JSON response sent to the 
# client must match the structure and data types defined in the User Pydantic model."
# reponse model is the shape/format of the data that you send back to the front end that is why
# we user this argument
@router.post('/login', response_model=Token)
def login_user(user: UserLogin, db : Session = Depends(get_db)):
    # 1. checking if the user with same email address already exists in the database or not
    db_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    # 2. if user does not exists with given access token then raise HTTPException or
    # simply user does not exists then raise HTTPException
    if not db_user or not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=401, detail='Incorrect email or password!')

    # 3. create new access token
    new_access_token = create_access_token(data={"sub": str(db_user.id)}, expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))

    # 4. reponse model is the shape/format of the data that you send back to the front end
    return {
        'access_token':new_access_token,
        'token_type': 'bearer',
        'id':db_user.id,
        }