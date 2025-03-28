from fastapi import FastAPI
from fastapi.responses import FileResponse
import random


app = FastAPI()


@app.get("/")
async def read_index():
    return FileResponse("static/index.html")


@app.get("/api/hello")
async def hello():
    greetings = [
        "Hello, world!",  # English
        "¡Hola, mundo!",  # Spanish
        "Bonjour, le monde!",  # French
        "Hallo, Welt!",  # German
        "Ciao, mondo!",  # Italian
        "Olá, mundo!",  # Portuguese
        "Привет, мир!",  # Russian
        "你好，世界！",  # Chinese
        "こんにちは、世界！",  # Japanese
        "안녕하세요, 세계!",  # Korean
    ]
    return {"message": random.choice(greetings)}
