FROM python:3.8.3-buster

WORKDIR /app

EXPOSE 8080

COPY requirements.txt /app

RUN pip install -r requirements.txt

RUN touch snmp_targets.json

COPY . /app

ENTRYPOINT python main.py
