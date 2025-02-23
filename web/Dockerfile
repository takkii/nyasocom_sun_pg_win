# distro os.
FROM ubuntu:focal
# mkdir users
LABEL maintainer="Takayuki Kamiyama <karuma.reason@gmail.com>"
# ruby 3.4.x
FROM ruby:3.4.2
# http://manpages.ubuntu.com/manpages/xenial/man7/debconf.7.html
ENV DEBCONF_NOWARNINGS=yes
# build package
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git sqlite3 libxslt1-dev libxml2-dev build-essential patch libsqlite3-dev libcurl4-openssl-dev curl libmagickcore-dev libmagickwand-dev postgresql-client sox libsox-fmt-all ca-certificates curl gnupg
# node.js
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN NODE_MAJOR=20 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install nodejs -y

# npm install --global [npm|yarn]
RUN npm install -g npm@latest
RUN npm install -g yarn

# install
RUN mkdir /nyasocom_sun_pg_win
ENV APP_ROOT /nyasocom_sun_pg_win
WORKDIR $APP_ROOT
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
# env build
RUN mv /bin/sh /bin/sh_tmp && ln -s /bin/bash /bin/sh
RUN echo 'export RUBY_YJIT_ENABLE=1' >> ~/.bashrc
RUN source ~/.bashrc
RUN bundle install
COPY ["package.json", "yarn.lock", "./"]
RUN yarn install
COPY . .
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh
ADD . $APP_ROOT

COPY ./web/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# EXPOSE 3000

# Start the main process.
CMD ["sh", "./web/start-server.sh"]
