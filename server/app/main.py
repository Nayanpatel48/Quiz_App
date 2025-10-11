from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import auth, history
from app.models import models
from app.database.database import engine

# provides the foundation to run the application.
# creates a fastAPI object.
# title & version are the metadata of the application.
app = FastAPI(title='Gamified Coding App API', version='1.0.0')

# create database tables
models.Base.metadata.create_all(bind=engine)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure this properly for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#  this code is organizing your API into different departments.

# Analogy: A Department Store 🏬

# Think of your main application app as a large department store. Instead of putting everything in 
# one big messy room, you create separate departments for different things.
#     auth.router : This is the Security Department (handles logins).
#     history.router : This is history department (handles history fetching from postgresql database)

# Each line of code does two main things:
#     app.include_router(...) : This tells your main store, "Set up and include this new department."
#     prefix="/api/..." : This gives each department its own unique address or aisle number. For example, 
#                           all routes inside the users.router will now start with /api/users/. This 
#                           prevents confusion between 
# departments.
app.include_router(auth.router, prefix='/auth', tags=['authentication'])
app.include_router(history.router, prefix='/history', tags=['history'])

@app.get('/')
def root():
    return {'message' : 'Excercise Planner API.'}

@app.get('/health')
def health_check():
    return {'message' : 'Application is healthy'}