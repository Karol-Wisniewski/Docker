ARG PYTHON_VERSION=3.9

FROM python:${PYTHON_VERSION}-slim-buster

WORKDIR /app

COPY myapp/ .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]