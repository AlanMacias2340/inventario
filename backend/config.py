import os
from dotenv import load_dotenv

load_dotenv()

# Application settings
DEBUG = os.getenv("DEBUG", "True") == "True"
HOST = os.getenv("HOST", "0.0.0.0")
PORT = int(os.getenv("PORT", "5000"))

# CORS settings
CORS_ORIGINS = os.getenv("CORS_ORIGINS", "*").split(",")

# Database settings (add your database configuration here)
DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./test.db")
