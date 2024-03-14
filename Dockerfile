# Define a imagem base
FROM python:3.9-slim as python-base

# Defina as variáveis de ambiente necessárias
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    POETRY_VERSION=1.0.3 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

# Adicione o Poetry e o venv ao PATH
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# Instalação de dependências
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        build-essential \
        libpq-dev \
        gcc

# Instalação do Poetry
RUN pip install poetry==$POETRY_VERSION

# Criação do diretório para os requisitos do projeto
WORKDIR $PYSETUP_PATH

# Copia os arquivos de requisitos do projeto
COPY poetry.lock pyproject.toml ./

# Instalação das dependências de tempo de execução
RUN pip install poetry poetry init

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto para o diretório de trabalho
COPY . /app/

# Exposição da porta
EXPOSE 8000

# Comando para executar o servidor Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
