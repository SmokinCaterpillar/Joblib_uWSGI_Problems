# actual build
FROM python:3.7.2-slim-stretch

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
    nginx \
    supervisor \
    g++

# install requiremnts
COPY requirements.txt /srv
RUN pip install -r /srv/requirements.txt

# the nginx and uwsgi setup
RUN useradd --no-create-home nginx

COPY webserver/nginx.conf /etc/nginx/
COPY webserver/flask-site-nginx.conf /etc/nginx/conf.d/
COPY webserver/uwsgi.ini /etc/uwsgi/
COPY webserver/supervisord.conf /etc/

# copy the app itself
COPY . /srv

ENV PYTHONPATH $PYTHONPATH:/srv

WORKDIR /srv

# for exposing port 80 for webapps
EXPOSE 80

# make supervisor start flask, uwsgi, and nginx
CMD ["/usr/bin/supervisord"]