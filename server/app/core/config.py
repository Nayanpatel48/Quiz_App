from pydantic_settings import BaseSettings

class Settings(BaseSettings):
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