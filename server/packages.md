## Create virtual environment

```python
python3 -m venv .venv
```

### OR (on some systems)

```python
python -m venv .venv
```

#### Step 2: Activate the Virtual Environment

You **must** activate the virtual environment before installing packages or running your code. You will know it's active when `(.venv)` appears at the start of your terminal prompt.

| Operating System         | Command to Activate            |
| :----------------------- | :----------------------------- |
| **macOS / Linux**        | `source .venv/bin/activate`    |
| **Windows (CMD)**        | `.\.venv\Scripts\activate.bat` |
| **Windows (PowerShell)** | `.\.venv\Scripts\Activate.ps1` |

#### Step 3: Execute the Installation

With the environment active, use `pip` to read and install everything listed in your `requirements.txt` file. This is how you execute the file.

```python
(venv) $ pip install -r requirements.txt
```

#### Step 4: Refresh/Update the Requirements File

Whenever you add a _new_ package (e.g., `pip install requests`) to your active environment, you should immediately update the `requirements.txt` file to reflect the change, including the exact version numbers.

## Example: you installed 'requests'

```python
(venv) $ pip install requests
```

## Command to refresh the requirements.txt file

```python
(venv) $ pip freeze > requirements.txt
```

This `pip freeze > requirements.txt` command **overwrites** the existing file, documenting all currently installed packages in your virtual environment. This keeps your project configuration accurate and reproducible.

Let me know if you'd like to dive into the minimal SQLAlchemy model definitions or the basic FastAPI authentication setup next!
