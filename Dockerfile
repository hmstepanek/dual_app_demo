# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ssh
# Build newrelic wheel locally and rename before installing due to https://github.com/pypa/pip/issues/9628.
WORKDIR /app/newrelic-python-agent
RUN pip install build && python -m build --wheel --outdir=/app/newrelic-python-agent && mv *.whl newrelic-11.0.2.dev7+g3e8b8742-py3-none-any.whl && pip install newrelic-11.0.2.dev7+g3e8b8742-py3-none-any.whl
WORKDIR /app
# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["newrelic-admin", "run-program", "flask", "run", "--port=5000", "--host=0.0.0.0"]
