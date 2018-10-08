FROM nginx:1.7

EXPOSE 8088

RUN apt-get update \
  && apt-get install -y curl python \
  && apt-get clean \
  && mkdir -p /reposado/code /reposado/html /reposado/metadata \
  && curl -ksSL https://github.com/wdas/reposado/tarball/master | tar zx \
  && cp -rf wdas-reposado-*/code/* /reposado/code/ \
  && rm -f master /etc/nginx/sites-enabled/default /etc/service/nginx/down \
  && rm -rf wdas-reposado-* /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chown -R www-data:www-data /reposado \
  && chmod -R ug+rws /reposado
