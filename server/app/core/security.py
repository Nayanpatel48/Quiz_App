from datetime import datetime, timedelta
import bcrypt
from fastapi import HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt

SECRET_KEY = "supersecretkey"  
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 300
# 5hrs

# it is like door keeper who wants temporary premium pass so that you can enter in the club.
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# 1. Function to hash a plain text password
def get_password_hash(password: str) -> str:
    """Hashes a plain password and returns the string hash."""
    # Encode the string password into bytes
    password_bytes = password.encode('utf-8')

    # Generate a salt
    salt = bcrypt.gensalt()

    # Hash the password bytes with the salt
    hashed_bytes = bcrypt.hashpw(password_bytes, salt)

    # Decode the hashed bytes back into a string to store in the database
    return hashed_bytes.decode('utf-8')

# 2. Function to verify a password
def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Compares a plain password with its hash. Returns True if they match."""
    # Encode both the plain password and the stored hash into bytes
    plain_password_bytes = plain_password.encode('utf-8')
    hashed_password_bytes = hashed_password.encode('utf-8')

    # The checkpw function returns True if they match, False otherwise
    return bcrypt.checkpw(plain_password_bytes, hashed_password_bytes)

# 3. create access token
def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# 4. decode the JWT token
# Assume this is your JWT decoding utility function
# It should decode the token, check expiration/signature, and return the user identifier (e.g., user_id)
# This function is what raises the 401 error if the token is invalid/expired
def decode_jwt(token: str):
    """Decodes the JWT & fetches the user from the database."""
    try:
        # decode your token using your secret key & Algorithm
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])

        # assuming your token stores the user_ID as a 'sub'
        user_id: int = payload.get('sub')

        if user_id is None:
            raise HTTPException(status_code=401, detail='Invalid token!')
    except JWTError:
        raise HTTPException(status_code=401, detail='Invalid token!')
    
    return user_id