from datetime import datetime
from typing import Annotated, List
from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.core.security import decode_jwt
from app.database.database import get_db
from app.models.models import HistoryModel
from app.schemas.schemas import HistorySaveSchema, HistorySchema

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
router = APIRouter()

# get all the history of a perticular user
@router.get('/', response_model=HistorySchema)
def get_all_history_of_user(db : Session = Depends(get_db)):
    pass

# add history to the table
@router.post('/save', response_model=HistorySchema)
def save_history(
    history : HistorySaveSchema,
    token: Annotated[str, Depends(oauth2_scheme)],
    # Token is the string from the Authorization header
    db : Session = Depends(get_db),
    ):
    # 1. Decode the token to get the user identifier (e.g., ID).
    user_id = decode_jwt(token)
    
    # 2. create the object/record to store it into history table in the database
    history_object = HistoryModel(
        test_name = history.test_name,
        user_id = user_id,
        score = history.score,
        created_at = datetime.now(),
    ) 

    # 3. add newly created history object/record to the database
    db.add(history_object)

    # 4. commit the changes to the database
    db.commit()

    # 5. Refresh the object to get id assign by the database
    db.refresh(history_object)

    # 6. return newly created user
    return history_object

# get user specific history
@router.get('/history', response_model=List[HistorySchema])
def get_user_history(
    token: Annotated[str, Depends(oauth2_scheme)],
    # Token is the string from the Authorization header
    db : Session = Depends(get_db),
    ):
    # 1. Decode the token to get the user identifier (e.g., ID).
    user_id = decode_jwt(token)

    # 2. first fetch all the history objects/ records from the database
    history_objects = db.query(HistoryModel).filter(HistoryModel.user_id == user_id).all()

    # 3. now from this objects extract all the objects which are not related to 
    # currently logged in user.
    print(type(history_objects))

    return history_objects