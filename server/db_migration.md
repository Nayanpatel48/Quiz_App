# General Database Migration Guide (Alembic + PostgreSQL + FastAPI)

**Purpose:** Apply _any_ schema changes to an existing database using Alembic.

1.  **Ensure you are in the correct directory**

2.  **Run the Initialization Command:**
    Use `alembic init` to create the standard structure, including the `alembic.ini` configuration file and the `alembic` scripts folder. Since the error suggests the missing folder is named `alembic`, use that name for initialization:

    ```bash
    (venv) $ alembic init alembic
    ```

3.  **Review the Generated Files:**
    This command will create two things:

    - A configuration file: `alembic.ini`
    - A scripts directory: `./alembic/` (containing `env.py`, `script.py.mako`, and the `versions/` folder).

4.  **Configure the Connection:**
    Before you can use `alembic revision --autogenerate`, you must edit two files:

    - **`alembic.ini`**: Update the `sqlalchemy.url` setting with your database connection string:
      ```ini
      # In alembic.ini
      sqlalchemy.url = postgresql://app_user:secure_dev_password@localhost/gamified_coding_app
      ```
    - **`alembic/env.py`**: This file needs to be edited to properly load your SQLAlchemy base models so Alembic knows what tables to create.

5.  **Run the Autogenerate Command:**
    After configuration, your original command will now work:

    ```bash
    (venv) $ alembic revision --autogenerate -m "create initial user and history tables"
    ```

- Project virtualenv active.
- `alembic` configured (`alembic.ini` present) and `env.py` references your SQLAlchemy `Base.metadata` as `target_metadata`.
- Database URL in `alembic.ini` or environment variable.
- Test or development DB available for dry-run.

## Workflow

### 1. Modify SQLAlchemy models

- Edit or add models as needed (new table, column, constraint, relationship, etc.).
- Ensure your Python code imports cleanly with no errors.

### 2. Generate migration

Create an autogenerate revision:

```bash
alembic revision --autogenerate -m "Describe schema change here"
```

Alembic creates a file in `migrations/versions/`.

### 3. Inspect and correct the migration file

1. Open the generated revision file.
2. Confirm `op.create_table`, `op.add_column`, `op.drop_column`, or other operations match your intended schema change.
3. Ensure foreign keys and constraints reference correct table/column names.
4. Add missing constraints manually, e.g.:

```python
op.create_unique_constraint('uq_table_column', 'table_name', ['column_name'])
```

5. For timestamp columns you may want server defaults:

```python
sa.Column('created_at', sa.DateTime(), server_default=sa.func.now())
```

6. Keep `upgrade()` and `downgrade()` symmetric.

### 4. Apply migration

Run:

```bash
alembic upgrade head
```

If errors occur, edit migration file and retry.

### 5. Verify in PostgreSQL

Using `psql` or a DB client:

```sql
\dt
\d <table_name>
```

Confirm the changes applied correctly.

### 6. Tests to run

- Unit test: ensure new columns/tables exist in DB schema.
- Integration test: ensure new models interact as expected.
- Regression test: existing features still work.

### 7. Rollback

Undo last migration locally:

```bash
alembic downgrade -1
```

Revert to a specific revision:

```bash
alembic downgrade <revision_id>
```

### 8. Common pitfalls

- `target_metadata` not set in `env.py` causes empty autogenerate. Fix by importing `Base` and setting `target_metadata = Base.metadata`.
- Alembic may miss unique constraints, server defaults, or index changes → add them manually.
- Foreign key mismatch if table names are inconsistent.
- Never run migrations on production without testing on staging/dev.

### 9. Final notes

- Always commit migration scripts to version control with model changes.
- Keep migration messages short but descriptive.
- Validate migrations in CI/CD with a disposable database.

---

**This process works for any schema modification**: new tables, new columns, altered constraints, or dropped tables. Only the model changes and the generated migration contents vary.
