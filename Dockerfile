# Use Oracle Linux 9 as the base image
FROM oraclelinux:9

# Update the package list and install Python 3.12
RUN dnf update -y && \
    dnf install -y python3.12 curl && \
    dnf clean all

# Upgrade pip and setuptools for Python 3.12
RUN python3.12 -m pip install --upgrade pip setuptools

# Set environment variable for Python 3.12
ENV PATH=$PATH:/usr/local/bin/python3.12

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt and ui.py into the container
COPY requirements.txt .
COPY ui.py .

# Install Python dependencies
RUN python3.12 -m pip install --no-cache-dir -r requirements.txt

# Expose port 8501 for Streamlit
EXPOSE 8501

# Health check (ensure that the Streamlit app is healthy)
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# Set the default command to run when the container starts
ENTRYPOINT ["streamlit", "run", "ui.py", "--server.port=8501", "--server.address=0.0.0.0"]

