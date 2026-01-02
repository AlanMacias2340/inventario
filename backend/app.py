from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
from routes import health_routes

load_dotenv()

app = FastAPI(title="Inventariado API", version="1.0.0")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this to specific origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routes
app.include_router(health_routes.router, prefix="/api", tags=["health"])

@app.get("/")
def root():
    return {"message": "Welcome to the Inventariado API"}
