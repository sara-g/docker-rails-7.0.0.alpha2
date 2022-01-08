FROM ruby:3.1.0-alpine

RUN apk add --no-cache --update \
   build-base \
   bash \
   git \
    # Postgres
   postgresql-dev \
   # Javascript
   yarn \
  # Image Resizing
   imagemagick \
   vips \
    # ActiveStorage file inspection
   file \
   # Time zone data
   tzdata \
   # Nokogiri Libraries
   zlib-dev \
   libxml2-dev \
   libxslt-dev \
   # Nice to have
   bash \
   git \
   vim \
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