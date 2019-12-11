FROM ubuntu:18.04

# Dependencies + NodeJS
RUN apt-get -qq update && \
  echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
  apt-get -y -qq install software-properties-common &&\
  apt-add-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" && \
  apt-add-repository ppa:malteworld/ppa && apt-get -qq update && apt-get -y -qq install \
  apt-utils \
  adobe-flashplugin \
  msttcorefonts \
  ffmpeg \
  fonts-noto-color-emoji \
  fonts-noto-cjk \
  fonts-liberation \
  fonts-thai-tlwg \
  fonts-indic \
  fontconfig \
  libappindicator3-1 \
  pdftk \
  unzip \
  locales \
  gconf-service \
  libasound2 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgcc1 \
  libgconf-2-4 \
  libgdk-pixbuf2.0-0 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  ca-certificates \
  libappindicator1 \
  libnss3 \
  lsb-release \
  xdg-utils \
  wget \
  unzip \
  xvfb \
  nodejs \
  npm \
  curl &&\
  apt-get -y -qq install build-essential &&\
  fc-cache -f -v

RUN useradd -ms /bin/bash nodeuser
RUN mkdir /chrome
RUN mkdir /app
ADD https://storage.googleapis.com/chromium-browser-snapshots/Linux_x64/686378/chrome-linux.zip /chrome
RUN unzip /chrome/chrome-linux.zip -d /chrome
RUN chown -R nodeuser:nodeuser /chrome
RUN chown -R nodeuser:nodeuser /app
ENV CHROME_BIN=/chrome/chrome-linux/chrome
ENV NODE_OPTIONS=--max_old_space_size=8000
RUN apt-get -qq clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
RUN rm /chrome/*.zip
USER nodeuser
WORKDIR /app
