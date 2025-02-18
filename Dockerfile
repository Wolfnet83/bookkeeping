FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libc6

WORKDIR /bookke
COPY Gemfile Gemfile.lock ./

RUN bundle config force_ruby_platform true
RUN bundle install

COPY . .

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

#CMD ["tail", "-f", "/dev/null"]
