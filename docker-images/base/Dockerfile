FROM ubuntu:18.04
MAINTAINER ryuzee
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install wget curl zip unzip git sqlite3 libsqlite3-dev build-essential libssl-dev libreadline-dev libmagickcore-dev libmagic-dev libmagickwand-dev graphviz nginx language-pack-ja ntp libmysqlclient-dev supervisor imagemagick && update-locale LANGUAGE=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN echo "export PATH=/root/.rbenv/shims:/root/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" > /root/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/bin:$PATH
ENV RAILS_ROOT /opt/application/current
RUN bash -c "source /root/.bashrc && rbenv install 2.6.5"
RUN bash -c "source /root/.bashrc && rbenv global 2.6.5"
RUN bash -c "source /root/.bashrc && rbenv exec gem install bundler -v 1.17.3"
RUN bash -c "source /root/.bashrc && rbenv rehash"

COPY supervisor.conf /etc/supervisor.conf

RUN apt-get update && apt-get install -y unoconv xpdf xvfb fonts-vlgothic fonts-mplus fonts-migmix libmagickwand-dev
RUN cd /tmp && wget "http://downloads.sourceforge.net/project/openofficeorg.mirror/4.1.1/binaries/ja/Apache_OpenOffice_4.1.1_Linux_x86-64_install-deb_ja.tar.gz" --tries 3 -O /tmp/openoffice.tar.gz && tar xvfz /tmp/openoffice.tar.gz && cd ja/DEBS && dpkg -i *.deb

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/*

EXPOSE 3000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.conf"]
