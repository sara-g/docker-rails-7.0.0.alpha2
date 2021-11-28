FROM ruby:3.0.2-alpine

RUN apk add --no-cache --update \
   build-base \
   bash \
   git \
   postgresql-dev \
   nodejs \
   yarn \
   imagemagick \
   tzdata \
   && rm -rf /var/cache/apk/*

RUN mkdir -p /myapp
WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
# COPY package.json yarn.lock ./

RUN bundle install
# RUN yarn install

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]