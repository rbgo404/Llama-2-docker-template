#!/bin/bash
# Get your HF_TOKEN from hugging face
# export HF_TOKEN=<YOUR_HF_TOKEN>

# Start the TGI server
text-generation-launcher --model-id $MODEL_ID --port $PORT --num-shard $NUM_SHARD --max-input-length $MAX_INPUT_LENGTH --max-total-tokens $MAX_TOTAL_TOKENS

# Wait for the TGI server to start
sleep 30

# Start the Flask app
uvicorn app:app --host 0.0.0.0 --port 7000 --reload
