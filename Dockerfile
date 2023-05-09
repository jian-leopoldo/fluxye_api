FROM docker.io/ruby:3.1.2-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    git \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    tzdata \
    yarn

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /app

# Create a directory for the app code
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Copy the Gemfile as well as the Gemfile.lock and install the RubyGems
COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install

# Copy the main application.
COPY . ./

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also tell the Rails dev server to bind to all interfaces by default.

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
