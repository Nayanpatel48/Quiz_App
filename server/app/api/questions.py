from typing import List
from fastapi import APIRouter, Depends
from app.database.database import get_db
from sqlalchemy.orm import Session
from app.models.models import DartQuestionsModel, JsQuestionsModel, PythonQuestionsModel
from app.schemas.schemas import DartQuestionsSchema, JsQuestionsSchema, PythonQuestionsSchema

# purpose of this code : This code defines the API endpoints related to the Questions.

router = APIRouter()

# get all the questions of Python model
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

# get all the questions of JavaScript
@router.get('/js', response_model=List[JsQuestionsSchema])
def get_js_questions(db: Session = Depends(get_db)):
    # fetch all the javaScript questions from javaScrpt questions table
    # we'll return it as a list of JSON objects

    # 1. query the database using session
    all_questions = db.query(JsQuestionsModel).all()

    # 2. FastAPI handles the serialization
    # FastAPI takes the list of SQLAlchemy objects (all_questions) 
    # and automatically converts it into a List[QuestionSchema] (JSON list)
    # based on the response_model.
    return all_questions

# get all the questions of JavaScript
@router.get('/dart', response_model=List[DartQuestionsSchema])
def get_js_questions(db: Session = Depends(get_db)):
    # fetch all the javaScript questions from javaScrpt questions table
    # we'll return it as a list of JSON objects

    # 1. query the database using session
    all_questions = db.query(DartQuestionsModel).all()

    # 2. FastAPI handles the serialization
    # FastAPI takes the list of SQLAlchemy objects (all_questions) 
    # and automatically converts it into a List[QuestionSchema] (JSON list)
    # based on the response_model.
    return all_questions