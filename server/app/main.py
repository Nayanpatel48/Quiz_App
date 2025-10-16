from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import auth, history, questions
from app.models import models
from app.database.database import engine

# provides the foundation to run the application.
# creates a fastAPI object.
# title & version are the metadata of the application.
app = FastAPI(title='Gamified Coding App API', version='1.0.0')

# create database tables
models.Base.metadata.create_all(bind=engine)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix='/auth', tags=['authentication'])
app.include_router(history.router, prefix='/history', tags=['history'])
app.include_router(questions.router, prefix='/questions', tags=['questions'])

@app.get('/')
def root():
    return {'message' : 'Excercise Planner API.'}

@app.get('/health')
def health_check():
    return {'message' : 'Application is healthy'}