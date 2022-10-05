FROM python:3.8-buster

COPY requirements.txt .

ENV FLASK_APP not_set
ENV PORT not_set
ENV FLASK_RUN_HOST not_set
ENV FLASK_ENV not_set
ENV PATH not_set

RUN apt-get update &&\
    /usr/local/bin/python3 -m pip install --upgrade pip &&\
    /usr/local/bin/python3 -m pip install --upgrade setuptools &&\
    /usr/local/bin/python3 -m pip install -r requirements.txt &&\
    adduser myuser

WORKDIR /home/myuser

COPY --chown=myuser:myuser . .

USER myuser

WORKDIR /home/myuser

CMD gunicorn -w 4 --bind 0.0.0.0:$PORT "app:create_app()"