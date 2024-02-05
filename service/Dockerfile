FROM python:3.11-slim-bullseye

WORKDIR /app

RUN pip install poetry==1.7.1 

COPY pyproject.toml poetry.lock ./
RUN touch README.md

RUN poetry install --no-root

COPY src ./src

RUN poetry install

ENTRYPOINT ["poetry", "run", "uvicorn", "--host", "0.0.0.0", "service.server:app"]
