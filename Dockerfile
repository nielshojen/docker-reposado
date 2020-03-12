FROM nginx:stable

EXPOSE 8088

RUN apt-get update
RUN apt-get install -y curl python
RUN apt-get clean

VOLUME /reposado
RUN mkdir -p /reposado/html /reposado/metadata /reposado/scripts

RUN curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx && cp -rf wdas-reposado-*/code/* /usr/local/bin/
RUN rm -f master /etc/nginx/sites-enabled/default /etc/service/nginx/down
RUN rm -rf wdas-reposado-* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.conf /etc/nginx/
COPY preferences.plist /usr/local/bin/
COPY reposado.conf /etc/nginx/sites-enabled/

RUN chown -R www-data:www-data /reposado
RUN chmod -R ug+rws /reposado

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD /run.sh
