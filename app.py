from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os
from text_generation import Client


client = Client("http://127.0.0.1:3000", timeout=500)

class InferRequest(BaseModel):
    prompt: str
    max_tokens: int = 128
    temperature: float = 0.7
    top_p: float = 0.1
    top_k: int = 40
    repetition_penalty: float = 1.18

app = FastAPI()

@app.get("/healthcheck")
def healthcheck():
    return {"status": "ok"}

@app.post("/generate")
def generate(request: InferRequest):
    try:
        prompt = request.prompt
        max_tokens = request.max_tokens
        temperature = request.temperature
        top_p = request.top_p
        top_k = request.top_k
        repetition_penalty = request.repetition_penalty

        result = client.generate(prompt, max_new_tokens=max_tokens,temperature=temperature,top_p=top_p,top_k=top_k,repetition_penalty=repetition_penalty)
        return {"generated_text":result.generated_text}
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
