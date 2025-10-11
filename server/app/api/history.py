from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.database import get_db
from app.models.models import HistoryModel

# 1. this lets you group related end points together
router = APIRouter()

# 2. get all the history of a perticular user

@router.get('/', response_model=List[HistoryModel])
def get_all_history(db : Session = Depends(get_db)):
    pass