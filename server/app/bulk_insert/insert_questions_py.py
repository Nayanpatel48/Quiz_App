# this file defines the data & insert the questions into database in one run
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# 1. define the data that will be inserted into our Python table
from typing import Any, Dict
from app.core.config import settings
from app.database.database import engine

from app.models.models import DartQuestionsModel, JsQuestionsModel

questions_data : list[Dict[str, Any]] = [
    {
        "question": "Which keyword is used to declare a variable that cannot be reassigned after its initial assignment?",
        "option_a": "final",
        "option_b": "var",
        "option_c": "const",
        "option_d": "fixed",
        "answer": "final"
    },
    {
        "question": "Which function is the starting point of execution for every Dart program?",
        "option_a": "start()",
        "option_b": "run()",
        "option_c": "main()",
        "option_d": "execute()",
        "answer": "main()"
    },
    {
        "question": "In Flutter, what are the two main types of widgets?",
        "option_a": "Class and Function",
        "option_b": "Stateful and Stateless",
        "option_c": "Async and Sync",
        "option_d": "Page and Screen",
        "answer": "Stateful and Stateless"
    },
    {
        "question": "What is the primary purpose of the 'pubspec.yaml' file in a Flutter project?",
        "option_a": "Storing user authentication data",
        "option_b": "Defining package dependencies and assets",
        "option_c": "Writing application logic",
        "option_d": "Managing database migrations",
        "answer": "Defining package dependencies and assets"
    },
    {
        "question": "Which Dart feature is used to handle asynchronous operations and avoid callback hell?",
        "option_a": "Threads and Locks",
        "option_b": "Future and async/await",
        "option_c": "Synchronous blocks",
        "option_d": "Generators",
        "answer": "Future and async/await"
    },
    {
        "question": "How do you create a list of integers in Dart?",
        "option_a": "List<int> myList = []",
        "option_b": "var myList: int[]",
        "option_c": "list myList = new List()",
        "option_d": "Integer[] myList = new Array()",
        "answer": "List<int> myList = []"
    },
    {
        "question": "In Flutter, what widget is often used as the root of a single page or screen?",
        "option_a": "Container",
        "option_b": "Row",
        "option_c": "Scaffold",
        "option_d": "Column",
        "answer": "Scaffold"
    },
    {
        "question": "Which primitive type in Dart is used to store floating-point numbers?",
        "option_a": "float",
        "option_b": "double",
        "option_c": "decimal",
        "option_d": "num",
        "answer": "double"
    },
    {
        "question": "What is the keyword used to prevent a class from being subclassed (inherited)?",
        "option_a": "abstract",
        "option_b": "private",
        "option_c": "sealed",
        "option_d": "static",
        "answer": "sealed"
    },
    {
        "question": "What is the preferred way to navigate to a new screen in Flutter?",
        "option_a": "Navigator.pop(context)",
        "option_b": "Navigator.push(context, ...)",
        "option_c": "new Screen().show()",
        "option_d": "routeTo(screenName)",
        "answer": "Navigator.push(context, ...)"
    }
]

# 2. insert data into database

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
engine = create_engine(settings.DATABASE_URL)

def insert_data():
    session = SessionLocal()

    try:
        # we're using ORM's bulk insert mappings for most efficient insert
        session.bulk_insert_mappings(DartQuestionsModel, questions_data)

        session.commit()

        print(f"Successfully inserted {len(questions_data)} questions into python table.")
    except Exception as e:
        session.rollback()
        print(f"Error inserting data: {e}")
    finally:
        session.close()

# 3. run the insert_data() function only if the file is run directly.
if __name__ == "__main__":
    insert_data()