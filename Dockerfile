FROM tensorflow/tensorflow:latest-gpu
RUN pip install --no-cache-dir torch torchvision torchaudio kaggle pandas scikit-learn matplotlib numpy ipykernel