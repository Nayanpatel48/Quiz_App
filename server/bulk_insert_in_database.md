````markdown
# 🗃️ Bulk Insert in Database using SQLAlchemy

This guide explains how to perform a **bulk insert** operation using SQLAlchemy ORM.  
It allows inserting multiple rows efficiently in one transaction.

---

## 📘 Overview

This file:

1. Defines the data (e.g., quiz questions).
2. Uses SQLAlchemy's ORM session to insert all records in one run.
3. Rolls back safely if any error occurs.

---

## 📦 Prerequisites

- A configured SQLAlchemy `engine` connected to your database.
- Your model class (e.g., `DartQuestionsModel`) defined in `models.py`.
- Proper environment setup (`app.core.config.settings.DATABASE_URL`).

---

## 🧠 Example Code

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from typing import Any, Dict

# Local imports
from app.core.config import settings
from app.database.database import engine
from app.models.models import DartQuestionsModel

# 1. Define the data
questions_data: list[Dict[str, Any]] = [
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
    # ... more records
]

# 2. Create session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
engine = create_engine(settings.DATABASE_URL)

# 3. Insert data
def insert_data():
    session = SessionLocal()
    try:
        session.bulk_insert_mappings(DartQuestionsModel, questions_data)
        session.commit()
        print(f"✅ Successfully inserted {len(questions_data)} questions.")
    except Exception as e:
        session.rollback()
        print(f"❌ Error inserting data: {e}")
    finally:
        session.close()

# 4. Run the function if executed directly
if __name__ == "__main__":
    insert_data()
```
````

---

## ⚙️ How It Works

| Step | Operation           | Description                                                   |
| ---- | ------------------- | ------------------------------------------------------------- |
| 1    | **Define Data**     | List of dictionaries representing rows.                       |
| 2    | **Create Session**  | Connects SQLAlchemy ORM to DB.                                |
| 3    | **Bulk Insert**     | Uses `bulk_insert_mappings()` to insert all rows efficiently. |
| 4    | **Commit/Rollback** | Commits transaction or rolls back on error.                   |

---

## 🚀 Run Command

Run the file from the **project root** (so imports work):

```bash
cd ~/github/Gamified-Coding-App/server
python3 -m app.bulk_insert.insert_questions_py
```

---

## 🧩 Notes

- Use `bulk_insert_mappings()` for performance. It avoids model instantiation overhead.
- Keep your data schema aligned with your model’s columns.
- Avoid spaces in folder names (`bulk_insert` not `bulk insert`).
- Wrap insert operations in `try/except` for clean error handling.

---

## ✅ Output Example

```
✅ Successfully inserted 10 questions.
```

If something fails:

```
❌ Error inserting data: (psycopg2.errors...) <error message>
```
