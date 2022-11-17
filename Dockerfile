# syntax=docker/dockerfile:1
FROM ruby:3.1.2-slim
RUN apt-get update -qq && apt-get install -y nodejs libpq-dev postgresql-client-13 build-essential git
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV PATH=/myapp/bin:$PATH

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
