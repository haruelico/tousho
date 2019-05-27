FROM ruby:2.6.3

WORKDIR /app/tousho
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -  \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt update \
  && apt install --assume-yes \
    nodejs yarn \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock /app/tousho/
RUN bundle install
COPY package.json yarn.lock /app/tousho/
RUN yarn install

COPY . .
