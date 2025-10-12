from typing import List
from fastapi import APIRouter, Depends
from app.database.database import get_db
from sqlalchemy.orm import Session
from app.models.models import PythonQuestionsModel
from app.schemas.schemas import PythonQuestionsSchema

# purpose of this code : This code defines the API endpoints related to the Questions.

# 1 : this let you group related endpoints together 

router = APIRouter()

# 2. get all the questions of Python model
@router.get('/py', response_model=List[PythonQuestionsSchema])
def get_python_questions(db : Session = Depends(get_db)):
    # fetch all the python questions from python questions table
    # we'll return it as a list of JSON objects

    # 1. query the database using session
    all_questions = db.query(PythonQuestionsModel).all()

    # 2. FastAPI handles the serialization:
    # FastAPI takes the list of SQLAlchemy objects (all_questions) 
    # and automatically converts it into a List[QuestionSchema] (JSON list)
    # based on the response_model.

    return all_questions