# Localhost-Backend

1. **PostgreSQL Database Backend on local machine**

   - **PSQL** - local database commands [Jump to usage](#LocalDatabase)

2. **end-to-end connection in local DB**

   - **File** - file path [Jump to file](db_connection.md)

3. **end-to-end migration on local DB**

   - **File** - file path [Jump to file](db_migration.md)

4. **Postgresql DB Super easy notes for production**
   - **File** - file path [Jump to file](postgreq_notes.md)

# Tools for backend on local machine

1.  **Operating System & Environment**

- **Linux** - Base operating system (Ubuntu/Debian recommended)
- **Terminal/Bash** - Command line interface for running commands

2. **Programming Language & Runtime**

- **Python 3.8+** - Main programming language
- **pip** - Python package installer
- **venv** - Python virtual environment manager

3. **Web Framework & API Development**

- **FastAPI** (v0.104.1) - Modern, fast Python web framework for building APIs [Jump to usage](#FastAPI)

  Minimal sequence to run a FastAPI app locally:

- **Uvicorn** (v0.24.0) - ASGI server for running FastAPI applications [Jump to usage](#Uviconrn)

- **Pydantic** - Data validation using Python type annotations (comes with FastAPI) [Jumpt to usage] (#Pydantic)

4. **Database & ORM Tools**

   ----4.1 **Database System**

   - **PostgreSQL** - Primary relational database management system [Jump to usage](#LocalDatabase)
   - **psql** - PostgreSQL command-line client (comes with PostgreSQL)[Jump to usage](#LocalDatabase)

     --- 4.2 **ORM & Database Tools**

   - **SQLAlchemy** (v2.0.23) - Python SQL toolkit and Object-Relational Mapping (ORM) library [Jump to usage](#SQLAlchemy)

   - **psycopg2-binary** (v2.9.7) - PostgreSQL adapter for Python [Jump to usage](#psycopg2-binary)

   - **Alembic** (v1.12.1) - Database migration tool for SQLAlchemy [Jump to usage](#Alembic)

     4.3 Database Management GUI

   - **DBeaver Community Edition** - Universal database tool for developers and database administrators
     - Visual database browser
     - SQL editor
     - Data viewer and editor
     - Database schema visualization

5. **Port already in use problem solution**
   [Jump to usage](#Port-already-in-use-solution)

## FastAPI

- [Jump Up](#Localhost-Backend)

1. **Install FastAPI and Uvicorn**

```bash
pip install fastapi uvicorn
```

2. **Create a file** (e.g. `main.py`)

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}
```

3. **Run the server (development mode)**

```bash
uvicorn main:app --reload
```

- `main` = filename without `.py`
- `app` = FastAPI instance name inside the file
- `--reload` = auto-restart on code change

4. **Access in browser**

- App: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
- Interactive docs (Swagger UI): [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- Alternative docs (ReDoc): [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)

5. **Stop the server**
   Press `CTRL+C` in the terminal.

## Uviconrn

- [Jump Up](#Localhost-Backend)

Key command:

Runs `app` inside `app/main.py` on `127.0.0.1:8000`.

- go to server folder inside which the app folder is present & then run this command.

1. **Auto-reload (development)**

```bash
uvicorn app.main:app --reload
```

where in this command,
main = the Python file (main.py)

app = the FastAPI object inside that file

2. **Change host/port**

```bash
uvicorn app.main:app --host 0.0.0.0 --port 9000 --reload
```

3. **Stop server**
   Hit `CTRL+C` in terminal.

## Pydantic

- [Jump Up](#Localhost-Backend)

Pydantic is a Python library, you use **core patterns** inside Python code. The essential ones:

1. **Define a model**

```python
from pydantic import BaseModel

class User(BaseModel):
    id: int
    name: str
    email: str | None = None
```

2. **Create an instance (validation happens automatically)**

```python
user = User(id=1, name="Nayan", email="nayan@example.com")
```

3. **Access data**

```python
print(user.name)          # field access
print(user.dict())        # dict representation
print(user.json())        # JSON string
```

4. **Validation on bad input**

```python
User(id="not_int", name=123)
# raises ValidationError
```

5. **Default values and optional fields**

```python
class Item(BaseModel):
    name: str
    price: float = 0.0
    tags: list[str] = []
```

6. **Nested models**

```python
class Address(BaseModel):
    city: str
    zipcode: str

class Person(BaseModel):
    name: str
    address: Address
```

7. **Environment variables / settings (Pydantic v2)**

```python
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    db_url: str

settings = Settings()  # reads from env
```

## LocalDatabase

- [Jump Up](#Localhost-Backend)

Doable. Follow these steps on the Linux box.

1. **become the postgres account (no password required if you are sudoer)**

   ```bash
   sudo -i -u postgres
   ```

2. **open psql (as postgres superuser)**

   ```bash
   psql
   ```

3. **basic info and quit commands (inside psql)**

   - server version: `SELECT version();`
   - current connection: `\conninfo`
   - exit psql: `\q`

4. **list databases**

   - quick list: `\l`
   - extended with sizes: `\l+`
   - SQL alternative:

     ```sql
     SELECT datname,
            pg_size_pretty(pg_database_size(datname)) AS size
     FROM pg_database
     ORDER BY pg_database_size(datname) DESC;
     ```

5. **Switch to a database**

   ```sql
   \c database_name
   ```

   Example:

   ```sql
   \c exercise_app
   ```

6. **Check what user you're connected as**

```sql
SELECT current_user, current_database();
```

7. **Check permissions on public schema on database**

If you want to **check the permissions of the `public` schema** in that database, run this SQL command inside `psql`:

```sql
-- Check permissions on public schema of current database
SELECT
    n.nspname       AS schema_name,
    u.usename       AS owner,
    n.nspacl        AS access_privileges
FROM pg_namespace n
JOIN pg_user u ON n.nspowner = u.usesysid
WHERE n.nspname = 'public';
```

- Explanation

* `n.nspname` → schema name (`public`).
* `u.usename` → owner of the schema.
* `n.nspacl` → access control list (who can do what).

8. **List tables**

   ```sql
   \dt
   ```

   - All tables with details:

     ```sql
     \dt+
     ```

   - Filter by schema and pattern, e.g. all public tables:

     ```sql
     \dt public.*
     ```

   So a minimal flow is:

   ```sql
   \c exercise_app
   \dt
   \d some_table
   ```

9. **table contents**

   ```sql
   SELECT * FROM table_name;
   ```

   That shows all rows and columns.

   **_Useful variations_**:

   - Limit rows to avoid huge output:

   ```sql
   SELECT * FROM table_name LIMIT 20;
   ```

   - Pick specific columns:

   ```sql
   SELECT id, name FROM table_name LIMIT 20;
   ```

   - Check structure only (not data):

   ```sql
   \d table_name
   ```

   So flow is:

   ```sql
   \c your_database
   \dt
   SELECT * FROM some_table LIMIT 10;
   ```

10. **Exit psql**

```sql
\q
```

## SQLAlchemy

- [Jump Up](#Localhost-Backend)

  SQLAlchemy gives you a structured way to work with databases in Python. Core flow = **engine → Base → model classes → session → CRUD**.

1.  **Install**

    ```bash
    pip install sqlalchemy psycopg2
    ```

2.  **Engine and session**

    ```python
    from sqlalchemy import create_engine
    from sqlalchemy.orm import sessionmaker

    DATABASE_URL = "postgresql://user:password@localhost:5432/mydb"

    engine = create_engine(DATABASE_URL)
    SessionLocal = sessionmaker(bind=engine)
    session = SessionLocal()
    ```

3.  **Define a model (table)**

    ```python
    from sqlalchemy.orm import declarative_base
    from sqlalchemy import Column, Integer, String

    Base = declarative_base()

    class User(Base):
        __tablename__ = "users"

        id = Column(Integer, primary_key=True, index=True)
        name = Column(String, nullable=False, unique=True)
        email = Column(String, index=True)
    ```

4.  **Create tables**

    ```python
    Base.metadata.create_all(bind=engine)
    ```

5.  **CRUD operations**

- **Insert**

  ```python
  new_user = User(name="Nayan", email="nayan@example.com")
  session.add(new_user)
  session.commit()
  ```

- **Query**

  ```python
  users = session.query(User).all()
  first = session.query(User).filter(User.name == "Nayan").first()
  ```

- **Update**

  ```python
  first.email = "new@example.com"
  session.commit()
  ```

- **Delete**

  ```python
  session.delete(first)
  session.commit()
  ```

6. **Close session**

```python
session.close()
```

## psycopg2-binary

- [Jump Up](#Localhost-Backend)

  `psycopg2-binary` is a pre-compiled wheel of the **PostgreSQL driver** for Python. It lets you connect to PostgreSQL without building from source.

- Install

  ```bash
  pip install psycopg2-binary
  ```

- Basic usage

  ```python
  import psycopg2

  # connect
  conn = psycopg2.connect(
      dbname="exercise_app",
      user="postgres",
      password="your_password",
      host="localhost",
      port=5432
  )

  # open cursor
  cur = conn.cursor()

  # run query
  cur.execute("SELECT version();")
  print(cur.fetchone())

  # insert data
  cur.execute("INSERT INTO users (name, email) VALUES (%s, %s)", ("Nayan", "nayan@example.com"))

  # commit changes
  conn.commit()

  # close
  cur.close()
  conn.close()
  ```

- Notes

  - Use `psycopg2-binary` only for development or quick scripts.
  - For production, `psycopg2` (compiled from source) is recommended, since `-binary` can cause compatibility issues with some environments.

## Alembic

- [Jump Up](#Localhost-Backend)

  Alembic is the **database migration tool** used with SQLAlchemy. It manages schema changes (create/alter tables) with version control.

1. Install

```bash
pip install alembic
```

2.  Initialize in your project

From your project root:

```bash
alembic init alembic
```

This creates an `alembic/` folder and `alembic.ini` config file.

3.  Configure database URL

Edit **alembic.ini**:

```ini
sqlalchemy.url = postgresql://user:password@localhost:5432/mydb
```

Or set dynamically in `alembic/env.py` using your SQLAlchemy `engine`.

4. Create first migration

```bash
alembic revision --autogenerate -m "create users table"
```

- `--autogenerate` inspects your SQLAlchemy models and compares them with the DB.
- Migration script goes into `alembic/versions/`.

5.  Apply migration

```bash
alembic upgrade head
```

6.  Roll back migration

```bash
alembic downgrade -1
```

7.  Common commands

- Current version:

  ```bash
  alembic current
  ```

- History of revisions:

  ```bash
  alembic history
  ```

- Show SQL without running:

  ```bash
  alembic upgrade head --sql
  ```

---

Typical workflow

1. Define/modify SQLAlchemy models.
2. Run `alembic revision --autogenerate -m "desc"` to generate migration.
3. Run `alembic upgrade head` to apply.

### Port-already-in-use-solution

Port 8000 is already taken. Free the port or run Uvicorn on a different port. Steps:

1. **Find the process using port 8000**

```bash
lsof -i :8000
```

Look at the PID column from the output.

2. **Kill the process (graceful then force if needed)**

```bash
kill -9 <PID>
```
