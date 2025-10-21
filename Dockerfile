# Use Ruby 3.0 (2.5 is EOL and Debian Buster repos are no longer available)
FROM ruby:3.0-slim

# Install git (required for bundler to fetch git dependencies)
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /resque-web

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile ./

# Install gems (this will generate a new Gemfile.lock with the current bundler)
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY config.ru README.md $INSTALL_PATH/

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]
