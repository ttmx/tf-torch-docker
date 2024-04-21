FROM tensorflow/tensorflow:latest-gpu as base
RUN pip install --no-cache-dir torch torchvision torchaudio