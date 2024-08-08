# Use the official TGI image as the base image
FROM ghcr.io/huggingface/text-generation-inference:latest

# Set environment variables
ENV MODEL_ID="meta-llama/Llama-2-7b-chat-hf"
ENV NUM_SHARD=1
ENV MAX_INPUT_LENGTH=2048
ENV MAX_TOTAL_TOKENS=4096
ENV PORT=3000
# Copy the application code and start script
COPY app.py /app/app.py
COPY start.sh /app/start.sh

# Set the working directory
WORKDIR /app
RUN pip3 install fastapi==0.101.0
RUN pip3 install pydantic==2.1.1
RUN pip3 install pydantic_core==2.4.0
RUN pip3 install urllib3==2.0.4
RUN pip3 install uvicorn==0.23.2
RUN pip3 install text-generation==0.7.0
# Make the start script executable

RUN chmod +x /app/start.sh

# Expose the port the app runs on
EXPOSE 7000
ENTRYPOINT ["/bin/bash", "/app/start.sh"]
# Use the start script as the entry point
