ARG CDN_API_KEY

FROM ubuntu:22.04
LABEL org.opencontainers.image.source="https://github.com/siinlab/darija-tts"

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Copy the source code
COPY . .

# Setup environment
RUN bash scripts/setup.sh && bash scripts/install-pyenv.sh

# Set up pyenv in the shell
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PYENV_ROOT/versions:$PATH"
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Install dependencies
RUN pip install requirements-dev.txt && pip install -r requirements.txt

# Pull files from the CDN
RUN dvc remote modify --local bunny password $CDN_API_KEY && dvc pull