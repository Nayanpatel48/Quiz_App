from datetime import datetime
from sqlalchemy import Column, DateTime, Integer, String
from sqlalchemy.ext.declarative import declarative_base


# purpose of this code : This will save you from writting raw sql commands rather you just 
#                       use python objects and sqlalchemy will convert them to sql commands.

# this allows sqlalchemy to map your python objects to database tables. all the database models/classes 
# are inherited from it so sqlalchemy can map them into database tables.
Base = declarative_base()

# this is our users model, this will be shown as a table in our PostgreSQL database
class UserModel(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True) # for uniquely identifying user
    username = Column(String(50), unique=True, nullable=False) # cannot be null
    email = Column(String(50), unique=True, nullable=False) 
    hashed_password = Column(String(500), unique=True, nullable=False) # maximum 500 characters allowed
    created_at = Column(DateTime, default=datetime.utcnow)
