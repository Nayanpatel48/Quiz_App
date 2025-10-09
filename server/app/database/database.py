from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from app.core.config import settings

# step 1 : created central point of communication with database.
engine = create_engine(settings.DATABASE_URL)

# step 2 : we've created session maker instance, meaning we can create
#           multiple sessions that will be bound to this engine.
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# step 3 : this allows sqlalchemy to map your python objects to database 
#           tables. 
Base = declarative_base()

# step 4 : this function will be used to get a database session
#           inside our path operations.
def get_db():

    # step 5 : creates a new database session instance.
    db = SessionLocal()
    try:
        # step 6 : yield will pause the function & return the db instance.
        yield db
    finally:
        # step 7 : after the request is finished, it will close the db session.
        db.close()