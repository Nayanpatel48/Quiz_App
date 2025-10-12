from datetime import datetime
from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

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

    # relationships
    # relationship to the many side table
    # This line adds a history attribute to your User Model. When you query a User object, 
    # you can now access their history directly, like my_user.history
    history = relationship("HistoryModel", back_populates="users")

# this is history table for user's test history
class HistoryModel(Base):
    __tablename__ = 'history'

    id = Column(Integer, primary_key=True)
    test_name = Column(String(100), nullable=False)

    # user_id field will be used to fetch all the records for specific user
    user_id = Column(Integer, ForeignKey('users.id')) # foreign key is defined
    score = Column(Integer, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)

    # relationships
    # relationship to the one side table
    # this line adds a user attribute to your History Model. When you query a History object, 
    # you can now access their respective user directly, like my_history.user.
    users = relationship('UserModel', back_populates='history')

# this is table for JavaScript related questions
class JsQuestionsModel(Base):
    __tablename__ = 'js'

    # to uniquely identify each question of javaScript
    id = Column(Integer, primary_key = True)
    question = Column(Text, nullable=False)
    option_a = Column(Text, nullable=False)
    option_b = Column(Text, nullable=False)
    option_c = Column(Text, nullable=False)
    option_d = Column(Text, nullable=False)
    answer = Column(Text, nullable=False)

# this is table for Dart related questions
class DartQuestionsModel(Base):
    __tablename__ = 'dart'

    # to uniquely identify each question of Dart programming
    id = Column(Integer, primary_key = True)
    question = Column(Text, nullable=False)
    option_a = Column(Text, nullable=False)
    option_b = Column(Text, nullable=False)
    option_c = Column(Text, nullable=False)
    option_d = Column(Text, nullable=False)
    answer = Column(Text, nullable=False)

# this is table for Python related questions
class PythonQuestionsModel(Base):
    __tablename__ = 'python'

    # to uniquely identify each question of python programming
    id = Column(Integer, primary_key = True)
    question = Column(Text, nullable=False)
    option_a = Column(Text, nullable=False)
    option_b = Column(Text, nullable=False)
    option_c = Column(Text, nullable=False)
    option_d = Column(Text, nullable=False)
    answer = Column(Text, nullable=False)