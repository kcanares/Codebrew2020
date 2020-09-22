FROM python:3.7.4

RUN mkdir -p /app/server
WORKDIR /app/server

ENV FLASK_APP src
ENV FLASK_ENV development

COPY requirements.txt /app/server/
RUN pip install -r requirements.txt

COPY . /app/server/

CMD flask run --host=0.0.0.0 --port=$SERVER_PORT