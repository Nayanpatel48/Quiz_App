from pydantic_settings import BaseSettings

# why this is useful?
# ans : because all the settings are in one place so it is very easy to
# manage them & change them if needed

class Settings(BaseSettings):
    # here we've defined settings that our application needs in the form of 
    # class attributes/ properties
    DATABASE_URL: str = "postgresql://app_user:123456789@localhost/gamified_coding_app"
    SECRET_KEY: str = "your-secret-key-here"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

    # this inner class tells pydantic to read a .env file
    # & load whatever variables it finds there
    class Config:
        env_file = ".env"

# create an instance of the Settings class 
# so that it can be imported & used throughout the app
settings = Settings()