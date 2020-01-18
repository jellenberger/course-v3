# Base image
FROM jupyter/minimal-notebook

# Env vars
# NOTE: for pip cache env var, watch https://github.com/pypa/pip/issues/5735
ENV PIP_NO_CACHE_DIR false
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV HOME=/home/jovyan
ENV WORK=$HOME/

USER root

# Install dependencies
# Notes: apt-get update && apt-get install -y [deps here] && rm -rf /var/lib/apt/lists/* \ &&
RUN pip install --no-cache-dir pipenv

USER jovyan

# Install pipenv dependencies and chown home to fix ownership of stuff pipenv leaves
COPY --chown=jovyan:users Pipfile Pipfile.lock $HOME/
RUN pipenv install --system \
   && chown -R jovyan:users $HOME
