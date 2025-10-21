FROM ruby:3.0-slim

# Install build dependencies
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

ENV INSTALL_PATH /resque-web
WORKDIR $INSTALL_PATH

# Install gems
COPY Gemfile ./
RUN bundle install

# Copy application code
COPY config.ru $INSTALL_PATH/

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
