FROM nginx:stable

ENV PATH /reposado/code:$PATH

EXPOSE 8088

RUN apt-get update
RUN apt-get install -y curl python
RUN apt-get clean
RUN mkdir -p /reposado/code /reposado/html /reposado/metadata /reposado/scripts
RUN curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx
RUN cp -rf wdas-reposado-*/code/* /reposado/code/
RUN rm -f master /etc/nginx/sites-enabled/default /etc/service/nginx/down
RUN rm -rf wdas-reposado-* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY nginx.conf /etc/nginx/
COPY preferences.plist /reposado/code/
COPY reposado.conf /etc/nginx/sites-enabled/

RUN chown -R www-data:www-data /reposado
RUN chmod -R ug+rws /reposado

VOLUME /reposado/html
VOLUME /reposado/metadata
VOLUME /reposado/scripts

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD /run.sh
