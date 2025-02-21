# Use Oracle Linux 9 as the base image
FROM oraclelinux:9

# Update the package list and install Python 3.12 and curl
RUN dnf update -y && \
    dnf install -y python3.12 curl gcc libffi-devel && \
    dnf clean all

# Install pip for Python 3.12 (if it's missing)
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.12 get-pip.py && \
    rm get-pip.py

# Upgrade pip and setuptools
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

